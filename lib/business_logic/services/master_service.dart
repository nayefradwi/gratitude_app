import 'package:gratitude_app/business_logic/models/entry.dart';
import 'package:gratitude_app/business_logic/services/shared_pref_service.dart';

import 'hive_db_service.dart';
import 'local_notifications_service.dart';

class MasterService {
  MasterService._();
  static MasterService _service = MasterService._();
  factory MasterService.getInstance() => _service;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  Future<void> init() async {
    if (_isInitialized) return;
    await HiveDbService.getInstance().init();
    await SharedPrefService.getInstance().init();
    await LocalNotificationsService.getInstance().init();
    _isInitialized = true;
  }

  void loadEntries({int size}) {
    for (int i = 0; i < size; i++)
      HiveDbService.getInstance().addEntry(
          Entry("test ${i + SharedPrefService.getInstance().entriesLength}"));
  }
}
