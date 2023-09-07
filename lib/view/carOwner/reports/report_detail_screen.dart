
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muscat_car_wash/res/constants.dart';

import '../../../res/colors.dart';

class ReportDetailScreen extends StatefulWidget {
  final String name;
  final String date;
  final String Case;
  final String total;
  final String status;
  final String payment;

  const ReportDetailScreen({super.key,
  required this.name,
  required this.Case,
  required this.date,
  required this.payment,
  required this.status,
  required this.total,
  });

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
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
          child: Column(children: [


            Stack(children: [


              // Center(
              //   child: Container(
              //     height: size.height*0.3,
              //     width: size.width,
              //     // color: AppColors.greenColor2,
              //     decoration: BoxDecoration(
              //
              //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
              //           bottomRight: Radius.circular(30)),
              //       gradient: LinearGradient(
              //           colors: [
              //             AppColors.lightBlueColor,
              //             AppColors.lightBlueColor3,
              //           ],
              //           stops: [
              //             0.0,
              //             1.0
              //           ],
              //           begin: Alignment.centerLeft,
              //           end: Alignment.centerRight,
              //           tileMode: TileMode.repeated),
              //
              //     ),
              //     child: SizedBox(
              //       width: 100.0,
              //       height: 100.0,
              //       child: Padding(
              //         padding: const EdgeInsets.all(60.0),
              //         child: Container(
              //           width: 100.0,
              //           height: 100.0,
              //           decoration: new BoxDecoration(
              //             color: Colors.white,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Image.asset('assets/images/logo.png',),
              //         ),
              //
              //       ),
              //     ),
              //
              //   ),
              // ),
              Container(
                height: size.height*0.2,
                child: Column(
                  children: [

                    SizedBox(
                      height: size.height*0.05,
                    ),
                    Row(children: [

                      Container(

                        child: IconButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, icon: Icon(Icons.arrow_back, color: Colors.white,size: 20,)),
                      )
                    ],),
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        // borderRadius: BorderRadius.circular(5)

                      ),
                      width: size.width*0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Report', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 25),)),
                      ),
                    ),
                  ],
                ),
              ),

            ],),

            SizedBox(
              width: 100.0,
              height: 100.0,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
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

            SizedBox(
              height: size.height*0.01,
            ),

            Container(
              decoration: BoxDecoration(
                // color: Colors.white,
                // borderRadius: BorderRadius.circular(5)

              ),
              width: size.width*0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('Muscat Car Wash', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 15),)),
              ),
            ),

            SizedBox(
              height: size.height*0.01,
            ),


            Center(
              child: Container(
                width: size.width*0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)

                      ),
                      width: size.width*0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Date', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 12),),
                      ),
                    ),

                    Container(
                      width: size.width*0.58,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.date, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 12),),
                      ),
                    ),


                  ],),
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),

            Container(
              width: size.width*0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)

                    ),
                    width: size.width*0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('User Name', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 12),),
                    ),
                  ),

                  Container(
                    width: size.width*0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 12),),
                    ),
                  ),


                ],),
            ),

            SizedBox(
              height: size.height*0.01,
            ),




            Container(
              width: size.width*0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)

                    ),
                    width: size.width*0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Payment', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 12),),
                    ),
                  ),

                  Container(
                    width: size.width*0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.payment.toString() == 'Paid' ? 'Paid by credit card' :
                      widget.payment.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height*0.01,
            ),

            Container(
              width: size.width*0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)

                    ),
                    width: size.width*0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Service Type', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 12),),
                    ),
                  ),

                  Container(
                    width: size.width*0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.Case
                        , style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height*0.01,
            ),

            Container(
              width: size.width*0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)

                    ),
                    width: size.width*0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Address', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 12),),
                    ),
                  ),

                  Container(
                    width: size.width*0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Muscat Oman'
                        , style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height*0.01,
            ),
            Container(
              width: size.width*0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)

                    ),
                    width: size.width*0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Status', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 12),),
                    ),
                  ),

                  Container(
                    width: size.width*0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.status
                        , style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height*0.01,
            ),

            Container(
              width: size.width*0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)

                    ),
                    width: size.width*0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Service Charges', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 12),),
                    ),
                  ),

                  Container(
                    width: size.width*0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'OMR '+widget.total

                        , style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500,fontSize: 13),),
                    ),
                  ),


                ],),
            ),

            SizedBox(
              height: size.height*0.05,
            ),



            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Container(

                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Colors.red.shade200,
                      Colors.red,

                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      // elevation: MaterialStateProperty.all(3),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),

                    onPressed: () async {


                      Navigator.of(context).pop();

                      // Navigator.pushReplacement(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (c, a1, a2) =>
                      //         AppBottomNavBarScreen(index: 0, title: '', subTitle: '',),
                      //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      //     transitionDuration: Duration(milliseconds: 100),
                      //   ),
                      // );



                    }, child: Text('Go Back', style: buttonStyle)),
              ),
            ),

            SizedBox(
              height: size.height*0.2,
            ),


          ],),
        ),
      ),

    );
  }
}
