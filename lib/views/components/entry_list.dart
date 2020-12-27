import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/business_logic/BLoC/bloc/value_changed_bloc.dart';
import 'package:gratitude_app/business_logic/BLoC/states/value_changed_states.dart';
import 'package:gratitude_app/business_logic/models/entry.dart';
import 'package:gratitude_app/views/components/entry_list_item.dart';
import 'package:gratitude_app/views/components/utils/remove_glow.dart';
import 'package:grouped_list/grouped_list.dart';

typedef void EditModalFunctionCallBack(Entry element, int index);

// ignore: must_be_immutable
class EntryList extends StatelessWidget {
  final ValueChangedBloc<List<Entry>> _entriesBloc;
  final EditModalFunctionCallBack _editCallback;
  List<Entry> _entries = List();

  List<Entry> get entries => _entries;
  EntryList(
    this._entriesBloc,
    this._editCallback, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _entriesBloc,
      listener: (context, state) {
        if (state is NewValueState) _entries.addAll(state.value);
      },
      child: BlocBuilder(
          cubit: _entriesBloc,
          builder: (context, state) {
            return ScrollConfiguration(
              behavior: NoGlow(),
              child: GroupedListView<Entry, DateTime>(
                  shrinkWrap: true,
                  sort: true,
                  order: GroupedListOrder.DESC,
                  elements: _entries,
                  groupBy: (Entry element) => DateTime(
                      element.creationDate.year,
                      element.creationDate.month,
                      element.creationDate.day),
                  itemComparator: (e1, e2) =>
                      -e2.creationDate.compareTo(e1.creationDate),
                  indexedItemBuilder: (context, element, index) =>
                      EntryListItem(
                          _editCallback, _entries.length, index, element),
                  groupSeparatorBuilder: (element) => Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                        child: Text(
                          formatDate(element, [d, '-', M, '-', yyyy]),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      )),
            );
          }),
    );
  }
}
