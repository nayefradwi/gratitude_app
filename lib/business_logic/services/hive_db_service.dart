import 'package:gratitude_app/business_logic/models/entry.dart';
import 'package:gratitude_app/business_logic/services/random_number_service.dart';
import 'package:gratitude_app/business_logic/services/shared_pref_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'master_service.dart';

class HiveDbService {
  static const String ENTRY_BOX = "entryBox";
  HiveDbService._();
  static final HiveDbService _service = HiveDbService._();
  factory HiveDbService.getInstance() => _service;
  Box<Entry> _entryBox;

  Box<Entry> get entryBox => _entryBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EntryAdapter());
    _entryBox = await Hive.openBox(ENTRY_BOX);
  }

  List<Entry> getEntries({int start, int end}) {
    List entries = _entryBox.values.toList();
    return entries;
  }

  void addEntry(Entry entry) async {
    if (_entryBox.isOpen) {
      print(entry);
      await _entryBox.add(entry);
      SharedPrefService.getInstance().entryAdded();
    }
  }

  Future<void> closeAllBoxes() async {
    _entryBox.close();
  }

  Entry getRandomEntry() {
    // to ensure that sharedPreferences is not null
    MasterService.getInstance().init();
    return _entryBox.getAt(RandomNumberService.getInstance()
        .getRandomNumber(SharedPrefService.getInstance().entriesLength));
  }
}
