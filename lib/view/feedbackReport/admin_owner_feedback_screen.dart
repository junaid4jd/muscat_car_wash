
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/view/feedbackReport/feedbackReportDetail/feedback_report_detail_screen.dart';
import 'package:muscat_car_wash/view/feedbackReport/feedback_report_screen.dart';

class ViewFeedbackScreen extends StatefulWidget {
  const ViewFeedbackScreen({Key? key}) : super(key: key);

  @override
  _ViewFeedbackScreenState createState() => _ViewFeedbackScreenState();
}

class _ViewFeedbackScreenState extends State<ViewFeedbackScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.lightBlueColor2,
        title: Text(
          'Feedback',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.whiteColor,

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Feedback').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: AppColors.greenColor2,
                ));
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            // got data from snapshot but it is empty

            return Center(child: Text("No Data Found"));
          } else {
            return Center(
              child: Container(
                width: size.width * 0.95,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FeedBackReportDetailScreen(
                            paitentName: snapshot.data!.docs[index]["name"].toString(),
                            screenTitle: "Feedback",
                            patientEmail: snapshot.data!.docs[index]["email"].toString(),
                            title: snapshot.data!.docs[index]["title"].toString(),
                            description: snapshot.data!.docs[index]["description"].toString(),
                          )),
                        );

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 0, right: 0),
                        child: Container(
                          width: size.width * 0.95,

                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: AppColors.greenColor2),
                            borderRadius: BorderRadius.circular(10),
                            //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                            // gradient:  LinearGradient(
                            //   begin: Alignment.centerRight,
                            //   end: Alignment.centerLeft,
                            //   colors:
                            //
                            //   <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), ],
                            // ),


                            //whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.green,
                                  ),
                                  width: size.width * 0.17,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.whiteColor,
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                        "assets/images/logo.png"
                                    ),
                                  ),
                                ),
                                Container(
                                  //  color: redColor,
                                  // width: size.width * 0.73,

                                  child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          Container(
                                            //  color: Colors.orange,
                                            width: size.width * 0.48,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child:  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["name"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppColors.blackColor,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w800,
                                                        height: 1.3),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child:  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["title"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppColors.blackColor,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.3),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),


                                          SizedBox(width: 5,),

                                          Center(
                                            child:  OutlinedButton(

                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => FeedBackReportDetailScreen(
                                                      paitentName: snapshot.data!.docs[index]["name"].toString(),
                                                      screenTitle: "Feedback",
                                                      patientEmail: snapshot.data!.docs[index]["email"].toString(),
                                                      title: snapshot.data!.docs[index]["title"].toString(),
                                                      description: snapshot.data!.docs[index]["description"].toString(),
                                                    )),
                                                  );

                                                },
                                                child: new Text("View", style: TextStyle(color: AppColors.greenColor2, fontSize: 12),)),
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(builder: (context) => FeedBackReportDetailScreen(
                                          //         paitentName: snapshot.data!.docs[index]["name"].toString(),
                                          //         screenTitle: "Feedback",
                                          //         patientEmail: snapshot.data!.docs[index]["email"].toString(),
                                          //         title: snapshot.data!.docs[index]["title"].toString(),
                                          //         description: snapshot.data!.docs[index]["description"].toString(),
                                          //       )),
                                          //     );
                                          //
                                          //   },
                                          //   child: Container(
                                          //       height: size.height*0.045,
                                          //       width: size.width*0.25,
                                          //       decoration: BoxDecoration(
                                          //           color: AppColors.purpleColor,
                                          //           borderRadius: BorderRadius.circular(10)
                                          //       ),
                                          //       child: Center(
                                          //         child: Text("View",
                                          //           style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500, color: Colors.white),),
                                          //       )
                                          //   ),
                                          // ),

                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  //Container(child: Text('AdminHome'),),
                ),
              ),
            );
          }
        },
      ),

    );
  }
}
