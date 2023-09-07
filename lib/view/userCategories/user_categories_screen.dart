import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/components/app_text.dart';
import 'dart:math' as math;

import 'package:muscat_car_wash/res/constants.dart';

class UserCategoriesScreen extends StatefulWidget {
  final String category;
  const UserCategoriesScreen({super.key, required this.category});

  @override
  State<UserCategoriesScreen> createState() => _UserCategoriesScreenState();
}

class _UserCategoriesScreenState extends State<UserCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(

          iconTheme: IconThemeData(color: whiteColor, size: 25),
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: AppColors.lightBlueColor2,
          title: Text(
           widget.category,
            style: TextStyle(
              // color: AppColors.darkGreenColor,
                fontWeight: FontWeight.bold,
                fontSize: TextStylesData.titleFontSize),
          ),
          centerTitle: true,
        ),
      body: Container(
        //  color: Colors.red,
        width: size.width ,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Services").where(
              "category", isEqualTo : widget.category.toString()
          ).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: AppColors.lightGreyColor,
                  ));
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              // got data from snapshot but it is empty

              return Center(child: Text("No Data Found"));
            } else {
              return  Padding(
                padding: const EdgeInsets.only(left: 8,right: 8, top: 8),
                child: Container(

                  child: GridView.builder(
                      padding: EdgeInsets.only(top: 8),
                      shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 0,
                          mainAxisExtent: size.height * 0.17,
                          crossAxisCount: 2,
                          mainAxisSpacing: 8),
                      itemCount:snapshot.data!.docs.length,

                      itemBuilder: (BuildContext ctx, index) {

                        return InkWell(
                          onTap: () {


                          },
                          child: Padding(
                            padding:  EdgeInsets.only(left: 4,right: 4),
                            child: Container(
                              // height: size.height*0.25,
                              width: size.width*0.43,
                              decoration: BoxDecoration(
                                gradient:  LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors:

                                  <Color>[Color((math.Random().nextDouble() * 0x000FF0).toInt()),Color((math.Random().nextDouble() * 0x000000).toInt()).withOpacity(0.8), ],
                                ),
                                // color:
                                // <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2), ],

                                // index == 0 ? AppColors.purpleColor.withOpacity(0.5) :
                                // index == 1 ? AppColors.greenColor2.withOpacity(0.5) :
                                // index == 2 ? AppColors.darkRedColor.withOpacity(0.5) :
                                // index == 3 ? AppColors.orangeColor.withOpacity(0.5) :
                                // Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.lightGreyColor3,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.3
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(snapshot.data!.docs[index]["serviceImage"].toString(), fit: BoxFit.cover,
                                          height: size.height*0.09,
                                          width: size.width*0.4,
                                          // height: 80,
                                          // width: 80,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: size.width*0.43,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                          child: Text( snapshot.data!.docs[index]["serviceName"].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),

                                    Container(
                                      width: size.width*0.28,
                                      decoration: BoxDecoration(
                                          color: AppColors.darkRedColor,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8, top: 4,bottom: 4),
                                          child: Text( "Price OMR"+ snapshot.data!.docs[index]["servicePrice"].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w500),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
          },
        ),
      )
    );
  }
}
