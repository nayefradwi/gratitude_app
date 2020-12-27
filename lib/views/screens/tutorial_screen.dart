import 'package:flutter/material.dart';
import 'package:gratitude_app/main.dart';
import 'package:gratitude_app/views/components/utils/gratitude_app_icons.dart';
import 'package:introduction_screen/introduction_screen.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle:
          Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 32),
      bodyTextStyle:
          Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 26),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).backgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: IntroductionScreen(
            globalBackgroundColor: Theme.of(context).backgroundColor,
            dotsDecorator:
                DotsDecorator(activeColor: Theme.of(context).primaryColor),
            key: introKey,
            pages: [
              PageViewModel(
                  title: "Good days",
                  body: "we all have good days that makes us happy",
                  decoration: pageDecoration,
                  image: _buildImage("happy_face")),
              PageViewModel(
                  title: "Bad days",
                  body: "we all have bad days that makes us kinda sad",
                  decoration: pageDecoration,
                  image: _buildImage("sad_face")),
              PageViewModel(
                  title: "Grateful",
                  body:
                      "but no matter what, there are many things we should be grateful for",
                  decoration: pageDecoration,
                  image: _buildImage("family_")),
              PageViewModel(
                  title: "Add Button",
                  decoration: pageDecoration,
                  bodyWidget: Column(
                    children: [
                      FloatingActionButton.extended(
                        onPressed: null,
                        label: Text("BE GRATEFUL"),
                        icon: Icon(GratitudeAppIcons.heart),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Text(
                          "when you see this button then clicking on it will help you add something you are grateful for",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontSize: 26),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
              PageViewModel(
                  title: "Edit Button",
                  decoration: pageDecoration,
                  bodyWidget: Column(
                    children: [
                      Icon(
                        GratitudeAppIcons.pencil,
                        size: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Text(
                          "This button is to edit an entry that you previously entered",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontSize: 26),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
            ],
            done: Text(
              "Done",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(decoration: TextDecoration.none),
            ),
            onDone: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  SET_UP_SCREEN_ROUTE, (Route<dynamic> route) => false);
            },
          ),
        ),
      ),
    );
  }
}
