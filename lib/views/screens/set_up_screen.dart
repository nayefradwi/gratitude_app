import 'package:flutter/material.dart';
import 'package:gratitude_app/business_logic/services/shared_pref_service.dart';
import 'package:gratitude_app/main.dart';
import 'package:gratitude_app/views/components/utils/remove_glow.dart';

class SetUpScreen extends StatefulWidget {
  @override
  _SetUpScreenState createState() => _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isDataLoaded = false;
  int _selectedPhraseIndex = 0;
  String _selectedPhrase = "Alhamdulillah";
  String _selectedButtonPhrase = "ALHAMDULILLAH";
  bool _isEdit = false;
  List<String> _phrases = [
    "Alhamdulillah",
    "Thank you Allah",
    "I'm grateful",
    "I'm thankful",
  ];
  List<String> _buttonPhrases = [
    "ALHAMDULILLAH",
    "THANK ALLAH",
    "BE GRATEFUL",
    "BE THANKFUL"
  ];
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDataLoaded && ModalRoute.of(context).settings.arguments != null) {
      _selectedPhrase = SharedPrefService.getInstance().phraseChosen;
      _selectedButtonPhrase = SharedPrefService.getInstance().buttonPhrase;
      _selectedPhraseIndex = _phrases.indexOf(_selectedPhrase);
      _nameController.text = SharedPrefService.getInstance().username;
      _isDataLoaded = true;
      _isEdit = true;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: _isEdit
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                splashRadius: 20,
                color: Colors.blueGrey[800],
              )
            : Container(),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 6,
        title: Text(
          !_isEdit ? "Set up" : "Edit details",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      maxLength: 20,
                      controller: _nameController,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 28),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          labelText: "Name",
                          contentPadding: EdgeInsets.symmetric(vertical: -10)),
                    ),
                  ),
                  Text(
                    "Choose a phrase",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontSize: 28),
                  ),
                  _setUp(context),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      !_isEdit
                          ? Navigator.of(context)
                              .pushReplacementNamed(MAIN_SCREEN_ROUTE)
                          : Navigator.of(context).pop("edited");
                      await SharedPrefService.getInstance().setUpApp(
                          _nameController.text,
                          _selectedPhrase,
                          _selectedButtonPhrase.toUpperCase(),
                          isSetup: !_isEdit);
                    },
                    label: !_isEdit ? Text("DONE") : Text("EDIT"),
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _setUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Radio(
                  value: 0,
                  groupValue: _selectedPhraseIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedPhraseIndex = value;
                      _selectedPhrase = _phrases[_selectedPhraseIndex];
                      _selectedButtonPhrase =
                          _buttonPhrases[_selectedPhraseIndex];
                      print(_selectedButtonPhrase);
                    });
                  }),
              Text(
                _phrases[0],
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 1,
                  groupValue: _selectedPhraseIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedPhraseIndex = value;
                      _selectedPhrase = _phrases[_selectedPhraseIndex];
                      _selectedButtonPhrase =
                          _buttonPhrases[_selectedPhraseIndex];
                      print(_selectedButtonPhrase);
                    });
                  }),
              Text(
                _phrases[1],
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 2,
                  groupValue: _selectedPhraseIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedPhraseIndex = value;
                      _selectedPhrase = _phrases[_selectedPhraseIndex];
                      _selectedButtonPhrase =
                          _buttonPhrases[_selectedPhraseIndex];
                      print(_selectedButtonPhrase);
                    });
                  }),
              Text(
                _phrases[2],
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 3,
                  groupValue: _selectedPhraseIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedPhraseIndex = value;
                      _selectedPhrase = _phrases[_selectedPhraseIndex];
                      _selectedButtonPhrase =
                          _buttonPhrases[_selectedPhraseIndex];
                      print(_selectedButtonPhrase);
                    });
                  }),
              Text(
                _phrases[3],
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
