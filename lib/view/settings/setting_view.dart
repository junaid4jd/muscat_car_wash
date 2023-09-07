import 'package:flutter/material.dart';
import 'package:muscat_car_wash/model/dummy_data.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/components/app_text.dart';
import 'package:muscat_car_wash/view/authentication/userType/usertype_screen.dart';
import 'package:muscat_car_wash/view/feedbackReport/feedback/feedback_screen.dart';
import 'package:muscat_car_wash/view/profile_view/profile_view.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {





  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor3,


      body:   SingleChildScrollView(
        child: Column(

          children: [

            Container(
              height: size.height*0.08,
              width: size.width,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: TextStylesData.titleFontSize),
                  ),
                ],
              ),
            ),

            Center(
              child: Container(
                height: size.height*0.25,
                width: size.width,
                // color: AppColors.greenColor2,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
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
                  width: 100.0,
                  height: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
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
            SizedBox(
              height: size.height*0.02,
            ),
            Container(
              //width: size.width*0.9,
              height: size.height*0.8,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: DummyData.settingList.length,
                  itemBuilder: ( context ,  index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4,bottom: 4,left: 8,right: 8),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.whiteColor,
                        ),
                        // color: AppColors.lightGreyColor,
                        //width: size.width*0.9,
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              if(index == 0 ) {

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => ProfileView(),
                                    transitionDuration: Duration(milliseconds: 300),
                                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                  ),
                                );
                              }
                              else if(index == 1 ) {

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => FeedbackScreen(),
                                    transitionDuration: Duration(milliseconds: 300),
                                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                  ),
                                );
                              }
                              else if (index == 2) {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => UserType(),
                                    transitionDuration: Duration(milliseconds: 300),
                                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                  ),
                                );
                              }



                            },
                            hoverColor: AppColors.whiteColor,
                            splashColor: AppColors.whiteColor,
                            minLeadingWidth: 60,
                            minVerticalPadding: 10,
                            horizontalTitleGap: 10,
                            contentPadding: EdgeInsets.zero,

                            leading: Padding(
                              padding: const EdgeInsets.only(left: 4,bottom: 6),
                              child: Container(
                                width: 50,height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.lightBlueColor.withOpacity(0.2)
                                ),
                                child: Center(child: DummyData.settingList[index].icon),
                              ),
                            ),
                            title: Text(DummyData.settingList[index].name.toString(), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),
                            //      trailing: Icon(Icons.arrow_forward_ios, color: AppColors.purpleColor,size: 13,),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
