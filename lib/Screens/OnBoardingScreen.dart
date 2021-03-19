import 'package:flutter/material.dart';
import '../widgets/Indicator.dart';
import '../utils.dart';
import '../model_data.dart';
import './OnBoarding.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  _onChangedFunction(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PageView(
        onPageChanged: _onChangedFunction,
        controller: _pageController,
        children: onboardingData
            .map((e) => OnBoarding(
                  imageUrl: e.iconUrl,
                  smallMessage: e.message,
                  messageBig: e.messageBig,
                ))
            .toList(),
      ),
      Positioned(
        bottom: 60,
        left: 0,
        right: 0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Indicator(
              positionIndex: 0,
              currentIndex: _currentIndex,
            ),
            SizedBox(
              width: 10,
            ),
            Indicator(
              positionIndex: 1,
              currentIndex: _currentIndex,
            ),
            SizedBox(
              width: 10,
            ),
            Indicator(
              positionIndex: 2,
              currentIndex: _currentIndex,
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 200,
        left: 0,
        right: 0,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90.0),
            child: _currentIndex == 2
                ? Container(
                    width: 150,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.white,
                        onPressed: () {
                          //@todo routepage to login screen
                        },
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                              color: convertToHex("#06512C"), fontSize: 15),
                        )))
                : Container(
                    width: 150,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.white,
                        onPressed: _nextFunction,
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: convertToHex("#06512C"), fontSize: 15),
                        )))),
      )
    ]);
  }
}
