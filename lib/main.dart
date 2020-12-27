import 'package:flutter/material.dart';
import 'package:gratitude_app/business_logic/services/master_service.dart';
import 'package:gratitude_app/business_logic/services/shared_pref_service.dart';
import 'package:gratitude_app/business_logic/services/work_manager_service.dart';
import 'package:gratitude_app/views/screens/main_screen.dart';
import 'package:gratitude_app/views/screens/set_up_screen.dart';
import 'package:gratitude_app/views/screens/tutorial_screen.dart';

const String MAIN_SCREEN_ROUTE = "/main_screen";
const String CHOOSE_APP_OPTIONS_SCREEN_ROUTE = "/choose_options_screen";
const String SET_UP_SCREEN_ROUTE = "/setup_screen";
const String TUTORIAL_SCREEN_ROUTE = "/tutorial_screen";
void main() async {
  await MasterService.getInstance().init();
  WorkManagerService.getInstance().init();
  bool isAppSetUp = SharedPrefService.getInstance().isAppSetUp;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: isAppSetUp ? MAIN_SCREEN_ROUTE : TUTORIAL_SCREEN_ROUTE,
    theme: ThemeData(
        backgroundColor: const Color(0xFFF3F3F3),
        primaryColor: Colors.blueGrey[900],
        buttonColor: Colors.blueGrey[900],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blueGrey[900]),
        textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.blueGrey[900],
                fontFamily: "Playball",
                fontSize: 32),
            headline2: TextStyle(
                color: Colors.blueGrey[900],
                fontFamily: "Playball",
                fontSize: 28),
            headline3: TextStyle(
                color: Colors.blueGrey[900],
                fontFamily: "Playball",
                fontSize: 26),
            button: TextStyle(
                fontFamily: "Sanchez", fontSize: 16, color: Color(0xFFF3F3F3)),
            subtitle1: TextStyle(
                fontFamily: "Sanchez",
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.blueGrey[900],
                decoration: TextDecoration.underline),
            subtitle2: TextStyle(
                fontFamily: "Biryani",
                fontSize: 16,
                color: Colors.blueGrey[800]))),
    routes: {
      MAIN_SCREEN_ROUTE: (context) => MainScreen(),
      TUTORIAL_SCREEN_ROUTE: (context) => TutorialScreen(),
      SET_UP_SCREEN_ROUTE: (context) => SetUpScreen(),
    },
  ));
}
