import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muscat_car_wash/model/dummy_data.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/constants.dart';
import 'package:muscat_car_wash/view/admin/nearestCarServices/add_nearest_service_screen.dart';

import 'package:url_launcher/url_launcher.dart';

class CarRepairListView extends StatefulWidget {
  const CarRepairListView({super.key});

  @override
  State<CarRepairListView> createState() => _CarRepairListViewState();
}

class _CarRepairListViewState extends State<CarRepairListView> {
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
          'Nearest Car Services',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton:  FloatingActionButton(
        elevation: 0.0,
        child: Icon(Icons.add),
        backgroundColor: AppColors.lightBlueColor2,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddNearestServiceScreen()));
        },
      ),
      backgroundColor: AppColors.lightGreyColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Shops").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: primaryColor,
                ));
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            // got data from snapshot but it is empty

            return Center(child: Text("No Data Found"));
          } else {
            return   Center(
              child: Container(
                width: size.width * 0.95,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // DocumentSnapshot ds = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             OrderDetailScreen(
                        //               name: snapshot.data!.docs[index]["recipientName"].toString(),
                        //               email: snapshot.data!.docs[index]["recipientEmail"].toString(),
                        //               orderId: snapshot.data!.docs[index]["orderId"].toString(),
                        //               orderTotal: snapshot.data!.docs[index]["orderTotal"].toString(),
                        //               payment: snapshot.data!.docs[index]["paymentMethod"].toString(),
                        //               productsList: snapshot.data!.docs[index]["items"],
                        //               address: snapshot.data!.docs[index]["deliveryAddress"].toString(),
                        //               orderStatus:snapshot.data!.docs[index]["orderStatus"].toString(),
                        //             )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 8, bottom: 3),
                        child: Container(
                          width: size.width*0.95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: whiteColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                // color: redColor,
                                width: size.width*0.25,
                                // height: size.height*0.12,
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    snapshot
                                        .data!
                                        .docs[index]
                                    ["shopImage"]
                                        .toString()
                                    , fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              Container(
                                //   color: redColor,
                                //width: size.width*0.5,

                                child:  Column(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Container(

                                      width: size.width*0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width*0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8,top: 8),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["shopName"]
                                                    .toString()
                                                , style: TextStyle(
                                                color: Colors.black, fontSize: 13, fontWeight: FontWeight.w800,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),

                                    Container(

                                      width: size.width*0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width*0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8,),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["shopTime"]
                                                    .toString()
                                                , style: TextStyle(
                                                  color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500, height: 1.3,
                                                  overflow: TextOverflow.ellipsis),overflow: TextOverflow.ellipsis,maxLines: 3,),


                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),

                                    Container(

                                      width: size.width*0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width*0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8,),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["shopDescription"]
                                                    .toString()
                                                , style: TextStyle(
                                                  color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500, height: 1.3,
                                                  overflow: TextOverflow.ellipsis),overflow: TextOverflow.ellipsis,maxLines: 3,),


                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),
                                    Container(

                                      width: size.width*0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width*0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8,),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["shopAddress"]
                                                    .toString()
                                                , style: TextStyle(
                                                  color: Colors.green, fontSize: 10, fontWeight: FontWeight.w500, height: 1.3,
                                                  overflow: TextOverflow.ellipsis),overflow: TextOverflow.ellipsis,maxLines: 3,),


                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),
                                    Container(

                                      width: size.width*0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.call, color: Colors.red,),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8,),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                  ["shopPhone"]
                                                      .toString()
                                                  , style: TextStyle(
                                                    color: Colors.red, fontSize: 11, fontWeight: FontWeight.w500, height: 1.3),),
                                              ),
                                            ],),
                                          Center(
                                            child:  OutlinedButton(

                                                onPressed: () => launch("tel:${snapshot
                                                    .data!
                                                    .docs[index]
                                                ["shopPhone"]
                                                    .toString()}"),
                                                child: new Text("Call Now", style: TextStyle(color: AppColors.greenColor2, fontSize: 12),)),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),



                                  ],),
                              ),
                            ],
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