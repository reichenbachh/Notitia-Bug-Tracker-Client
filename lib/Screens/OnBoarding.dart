import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notitia/utils.dart';

class OnBoarding extends StatelessWidget {
  final String messageBig;
  final String imageUrl;
  final String smallMessage;
  OnBoarding(
      {required this.messageBig,
      required this.imageUrl,
      required this.smallMessage});
  @override
  Widget build(BuildContext context) {
    final String assetPath = imageUrl;
    final Widget svg = SvgPicture.asset(assetPath);
    return SafeArea(
      child: Scaffold(
        backgroundColor: convertToHex("#06512C"),
        body: Container(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                svg,
                SizedBox(
                  height: 80,
                ),
                Text(
                  "${messageBig.split("  ")[0]}\n${messageBig.split("  ")[1]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 80.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  smallMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
