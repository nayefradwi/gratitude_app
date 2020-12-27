import 'package:gratitude_app/business_logic/services/hive_db_service.dart';
import 'package:gratitude_app/business_logic/services/local_notifications_service.dart';
import 'package:gratitude_app/business_logic/services/master_service.dart';
import 'package:gratitude_app/business_logic/services/random_number_service.dart';
import 'package:gratitude_app/business_logic/services/shared_pref_service.dart';
import 'package:workmanager/workmanager.dart';

const String PERIODIC_GRATEFUL_REMINDER = "periodicGratefulReminder";
const String PERIODIC_INPUT_REMINDER = "periodicInputReminder";
const String TITLE = "notificationTitle";
const String BODY = "notificationBody";

// loop should be setup after the user set's up the app
void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    // ensure all services are initialized to avoid null exception
    await MasterService.getInstance().init();
    if (task == PERIODIC_INPUT_REMINDER) {
      LocalNotificationsService.getInstance().displayNotification(
          "Be Thankful!", "Dont forget to be thankful today!");
      WorkManagerService.getInstance()
          .setNotificationSchedulesForInputReminder();
    } else if (task == PERIODIC_GRATEFUL_REMINDER) {
      LocalNotificationsService.getInstance()
          .displayNotification(inputData[TITLE], inputData[BODY]);
      WorkManagerService.getInstance()
          .setNotifactionScheduleForPastEntryReminder();
    }
    return true;
  });
}

class WorkManagerService {
  WorkManagerService._();
  static WorkManagerService _service = WorkManagerService._();
  factory WorkManagerService.getInstance() => _service;
  bool _isInitialized = false;
  void init() {
    if (_isInitialized) return;
    Workmanager.initialize(callbackDispatcher);
    _isInitialized = true;
  }

  void setNotificationSchedulesForInputReminder() {
    int timingOne = RandomNumberService.getInstance()
        .getRandomNumber(6, includedLowerLimit: 7);
    this.registerPeriodicInputReminder(Duration(seconds: timingOne));
  }

  void setNotifactionScheduleForPastEntryReminder() {
    int timingTwo = RandomNumberService.getInstance()
        .getRandomNumber(6, includedLowerLimit: 7);
    print("timing one is: $timingTwo");
    this.registerPeriodicGratefulReminder(Duration(hours: timingTwo), {
      TITLE: SharedPrefService.getInstance().phraseChosen,
      BODY:
          "${SharedPrefService.getInstance().phraseChosen} for ${HiveDbService.getInstance().getRandomEntry().entryText}"
    });
  }

  void registerPeriodicInputReminder(Duration delay) {
    Workmanager.registerOneOffTask(
      "1",
      PERIODIC_INPUT_REMINDER,
      initialDelay: delay,
    );
    print("task 1 registered");
  }

  void registerPeriodicGratefulReminder(
      Duration delay, Map<String, dynamic> inputData) {
    Workmanager.registerOneOffTask(
      "2",
      PERIODIC_GRATEFUL_REMINDER,
      initialDelay: delay,
      inputData: inputData,
    );
    print("task 2 registered");
  }
}
