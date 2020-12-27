import 'package:gratitude_app/business_logic/services/work_manager_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPrefService _prefService = SharedPrefService._();
  static const ENTRIES_LENGTH = "entriesLength";
  static const USERNAME = "username";
  static const PHRASE_CHOSEN = "phraseChosen";
  static const BUTTON_PHRASE = "buttonPhraseChosen";
  static const RELIGION = "religion";
  static const IS_APP_SETUP = "isAppSetup";
  SharedPrefService._();
  SharedPreferences _preferences;
  int _entriesLength;
  String _phraseChosen, _buttonPhrase, _username;
  bool _isAppSetUp;
  SharedPreferences get preferences => _preferences;
  int get entriesLength => _entriesLength;
  String get phraseChosen => _phraseChosen;
  String get username => _username;
  String get buttonPhrase => _buttonPhrase;
  bool get isAppSetUp => _isAppSetUp;
  factory SharedPrefService.getInstance() => _prefService;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _entriesLength = _preferences.getInt(ENTRIES_LENGTH) ?? 0;
    _phraseChosen = _preferences.getString(PHRASE_CHOSEN) ?? "Alhamdulillah";
    _buttonPhrase = _preferences.getString(BUTTON_PHRASE) ?? "ALHAMDULILLAH";
    _username = _preferences.getString(USERNAME) ?? "Abdullah";
    _isAppSetUp = _preferences.getBool(IS_APP_SETUP) ?? false;
  }

  void entryAdded() async {
    await _preferences.setInt(ENTRIES_LENGTH, ++_entriesLength);
    if (entriesLength == 1)
      WorkManagerService.getInstance()
          .setNotifactionScheduleForPastEntryReminder();
  }

  Future<void> setUpApp(
      String username, String phraseChosen, String buttonPhrase,
      {bool isSetup: true}) async {
    _phraseChosen = phraseChosen ?? _phraseChosen;
    _username = username ?? _username;
    _buttonPhrase = buttonPhrase ?? _buttonPhrase;
    await _preferences.setString(PHRASE_CHOSEN, _phraseChosen);
    await _preferences.setString(USERNAME, _username);
    await _preferences.setString(BUTTON_PHRASE, _buttonPhrase);
    await _preferences.setBool(IS_APP_SETUP, true);
    if (isSetup)
      WorkManagerService.getInstance()
          .setNotificationSchedulesForInputReminder();
  }

  void clearEntryLenght() async {
    await _preferences.setInt(ENTRIES_LENGTH, 0);
  }
}
