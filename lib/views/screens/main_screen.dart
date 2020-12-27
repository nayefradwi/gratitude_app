import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/business_logic/BLoC/bloc/value_changed_bloc.dart';
import 'package:gratitude_app/business_logic/BLoC/states/value_changed_states.dart';
import 'package:gratitude_app/business_logic/models/entry.dart';
import 'package:gratitude_app/business_logic/services/hive_db_service.dart';
import 'package:gratitude_app/business_logic/services/shared_pref_service.dart';
import 'package:gratitude_app/views/components/entry_list.dart';
import 'package:gratitude_app/views/components/entry_textfield.dart';
import 'package:gratitude_app/views/components/utils/gratitude_app_icons.dart';

import '../../main.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueChangedBloc<List<Entry>> _entriesBloc = ValueChangedBloc(null);
  final ValueChangedBloc<bool> _entryTextValidationBloc =
      ValueChangedBloc(null);
  final ValueChangedBloc<bool> _isScrolledBloc = ValueChangedBloc(false);
  EntryList _entryList;

  @override
  void initState() {
    _entryList = EntryList(_entriesBloc, _showEditModalSheet);
    Future.delayed(Duration(milliseconds: 100), () {
      _entriesBloc.changeValue(HiveDbService.getInstance().getEntries());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showModalSheet();
        },
        label: Text(SharedPrefService.getInstance().buttonPhrase),
        icon: Icon(GratitudeAppIcons.heart),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: false,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(GratitudeAppIcons.cog),
                onPressed: () async {
                  await Navigator.of(context)
                      .pushNamed(SET_UP_SCREEN_ROUTE, arguments: true);
                  setState(() {});
                },
                splashRadius: 20,
                color: Colors.blueGrey[800],
              )
            ],
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              "Hello ${SharedPrefService.getInstance().username}!",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [_entryList],
          ))
        ],
      ),
    );
  }

  _showModalSheet() {
    final TextEditingController _entryController = TextEditingController();
    bool isValid = false;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EntryTextField(_entryTextValidationBloc, _entryController),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocListener(
                        cubit: _entryTextValidationBloc,
                        listener: (context, state) {
                          if (state is NewValueState) isValid = state.value;
                        },
                        child: BlocBuilder(
                          cubit: _entryTextValidationBloc,
                          builder: (context, state) {
                            return FloatingActionButton.extended(
                              elevation: 0,
                              onPressed: () {
                                if (isValid) {
                                  _addEntry(_entryController.text, context);
                                } else
                                  _cancel(context);
                              },
                              label: (isValid ? Text("ADD") : Text("CANCEL")),
                              icon: Icon(isValid ? Icons.add : Icons.cancel),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  _showEditModalSheet(Entry entry, index) {
    final TextEditingController _entryController =
        TextEditingController(text: entry.entryText);
    bool isValid = true;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EntryTextField(_entryTextValidationBloc, _entryController),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocListener(
                        cubit: _entryTextValidationBloc,
                        listener: (context, state) {
                          if (state is NewValueState) isValid = state.value;
                        },
                        child: BlocBuilder(
                          cubit: _entryTextValidationBloc,
                          builder: (context, state) {
                            return FloatingActionButton.extended(
                              elevation: 0,
                              onPressed: () {
                                !isValid
                                    ? _cancel(context)
                                    : _editEntry(
                                        entry, _entryController.text, context);
                              },
                              label: isValid ? Text("EDIT") : Text("CANCEL"),
                              icon: Icon(isValid ? Icons.add : Icons.cancel),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  void dispose() {
    _entriesBloc.close();
    _isScrolledBloc.close();
    _entryTextValidationBloc.close();
    HiveDbService.getInstance().closeAllBoxes();
    super.dispose();
  }

  _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  _addEntry(String text, BuildContext context) {
    Entry entry = Entry(text);
    HiveDbService.getInstance().addEntry(entry);
    _entriesBloc.changeValue([entry]);
    Navigator.of(context).pop();
  }

  _editEntry(Entry entry, String text, context) async {
    await entry.setEntryText(text);
    _entriesBloc.initValueToRefresh();
    Navigator.of(context).pop();
  }
}
