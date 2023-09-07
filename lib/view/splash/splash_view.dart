import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/components/app_text.dart';
import 'package:muscat_car_wash/utils/services/splash_services.dart';
import 'package:muscat_car_wash/view/authentication/userType/usertype_screen.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashDelay = 1; // delay for 5 seconds

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserType()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.width,
          // color: AppColors.greenColor2,
          decoration: BoxDecoration(

            gradient: LinearGradient(
                colors: [
                  AppColors.lightBlueColor,
                  AppColors.lightBlueColor3,
                ],
                stops: [
                  0.0,
                  1.0
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.repeated),

          ),
          child: SizedBox(
            width: 10.0,
            height: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Container(
                width: 10.0,
                height: 10.0,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/logo.png',),
              ),

            ),
          ),

        ),
      ),


      // Container(
      //   decoration:  BoxDecoration(
      //       gradient: LinearGradient(
      //           colors: [
      //             AppColors.darkGreenColor,
      //             AppColors.lightGreenColor,
      //           ],
      //           stops: [
      //             0.0,
      //             1.0
      //           ],
      //           begin: Alignment.centerLeft,
      //           end: Alignment.centerRight,
      //           tileMode: TileMode.repeated)),
      //   width: size.width,
      //   height: size.height,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         child: Image.asset('assets/images/logo.png', height: 100,width: 100,fit: BoxFit.scaleDown,),
      //       ),
      //       Center(
      //           child: Padding(
      //             padding: EdgeInsets.only(top: 10),
      //             child: Text(
      //               'Road Safety',
      //               style: TextStyle(
      //                   fontSize: TextStylesData.headingSmallFontSize,
      //                   color: AppColors.blackColor,
      //                   fontWeight: FontWeight.bold),
      //               textAlign: TextAlign.center,
      //             ),
      //           )),
      //     ],
      //   ),
      // ),
    );
  }
}
