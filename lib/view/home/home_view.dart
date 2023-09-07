import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/components/app_text.dart';
import 'package:muscat_car_wash/res/constants.dart';
import 'package:muscat_car_wash/view/admin/categories/main_categories_screen.dart';

import 'package:muscat_car_wash/view/carServices/service_detail_screen.dart';
import 'package:muscat_car_wash/view/emergency_service/emergency_service_view.dart';
import 'package:muscat_car_wash/view/feedbackReport/feedback/feedback_screen.dart';
import 'package:muscat_car_wash/view/incidentReport/incident_report_view.dart';
import 'package:muscat_car_wash/view/userCategories/user_categories_screen.dart';
import 'package:muscat_car_wash/view/viewMap/view_map.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int current = 0;
  int selectedIndex = 1000;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      selectedIndex = 1000;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> banners1 = [

      ClipRRect(
          borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 170,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl:  'https://i.ytimg.com/vi/IXPf4IVSvsA/maxresdefault.jpg',
          //   placeholder: (context, url) => CircularProgressIndicator(color: darkRedColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),

      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 170,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl:  'https://3.bp.blogspot.com/-eFUhozNDLts/W3aR1_8qGBI/AAAAAAAAAAM/Mvyywc2xtdEpzxPNsgEK3jBQExVus10QQCLcBGAs/s1600/Car%2Bwash.jpg',
          //   placeholder: (context, url) => CircularProgressIndicator(color: darkRedColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),

      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 170,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl:  'https://images.jdmagicbox.com/comp/bangalore/h5/080pxx80.xx80.160617221801.w4h5/catalogue/the-best-car-wash-kalkere-bangalore-car-washing-services-jwm1uukm78.jpg',
          //   placeholder: (context, url) => CircularProgressIndicator(color: darkRedColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),


    ];
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,//Color(0xFF1c1f26),

      appBar: AppBar(
        elevation: 0,

        iconTheme: IconThemeData(color: AppColors.whiteColor),
        leading: Icon(Icons.menu),
        backgroundColor: AppColors.lightBlueColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TextStylesData.appBarRound),
        ),
        title: Text(
          AppText.appName,
          style: TextStyle(
              // color: AppColors.darkGreenColor,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = LinearGradient(
                colors: <Color>[AppColors.whiteColor, AppColors.whiteColor],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              fontSize: TextStylesData.titleFontSize),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(children: [

          SizedBox(
            height: size.height*0.005,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: CarouselSlider(
                  items: banners1,
                  options: CarouselOptions(
                    height: size.height*0.16,
                     aspectRatio: 16/9,
                    viewportFraction: 0.999,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
                      setState(() {
                        current = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  )
              ),
            ),
          ),
          AnimatedSmoothIndicator(
            activeIndex: current,
            count: 3,//pages.length,
            effect:  JumpingDotEffect(
                dotHeight: 7,
                dotWidth: 7,
                jumpScale: .7,
                verticalOffset: 10,
                activeDotColor: AppColors.darkGreenColor,
                dotColor: Colors.grey),
          ),
          // SizedBox(
          //   height: size.height*0.02,
          // ),

          Container(
            width: size.width*0.9,
            child: Text('Categories', style: TextStyle(
              //color: Colors.black,
                fontSize: 16,
                foreground: Paint()..shader = LinearGradient(
                  colors: <Color>[AppColors.lightBlueColor, AppColors.lightBlueColor2],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                fontWeight: FontWeight.bold),),
          ),

          Container(
            //  color: Colors.red,
            height: size.height * .12,
            width: size.width ,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
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
                    padding: const EdgeInsets.only(left: 8,right: 8, top: 0),
                    child: Container(

                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 8),
                          shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount:snapshot.data!.docs.length,

                          itemBuilder: (BuildContext ctx, index) {

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => UserCategoriesScreen(category: snapshot.data!.docs[index]["categoryName"].toString(),),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 0),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:  EdgeInsets.only(left: 4,right: 4),
                                child: Container(
                                  // height: size.height*0.25,
                                  width: size.width*0.18,

                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        CircleAvatar(
                                          backgroundImage: NetworkImage(snapshot.data!.docs[index]["categoryImage"].toString()),
                                          radius: 30,
                                        ),

                                        SizedBox(
                                          height: 8,
                                        ),

                                        Center(
                                          child: Text( snapshot.data!.docs[index]["categoryName"].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            TextStyle(color: Colors.black, fontSize: 11,fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
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
          ),
          SizedBox(
            height: size.height*0.005,
          ),
          Container(
            width: size.width*0.9,
            child: Text('Car Services', style: TextStyle(
                //color: Colors.black,
                fontSize: 16,
                foreground: Paint()..shader = LinearGradient(
                  colors: <Color>[AppColors.lightBlueColor, AppColors.lightBlueColor2],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                fontWeight: FontWeight.bold),),
          ),



          Container(
            //  color: Colors.red,
             height: size.height * 0.19,
            width: size.width ,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Services").snapshots(),
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
                    padding: const EdgeInsets.only(left: 8,right: 8, top: 0),
                    child: Container(

                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 8),
                          shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount:snapshot.data!.docs.length,

                          itemBuilder: (BuildContext ctx, index) {

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => ServiceDetailScreen(
                                      serviceName: snapshot.data!.docs[index]["serviceName"].toString(),
                                      servicePrice: snapshot.data!.docs[index]["servicePrice"].toString(),
                                      serviceDescription: snapshot.data!.docs[index]["serviceDescription"].toString(),
                                      payment: 'Not Paid',
                                      status: 'bookUser',
                                      docId: snapshot.data!.docs[index].id,
                                      serviceImage: snapshot.data!.docs[index]["serviceImage"].toString(),),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 0),
                                  ),
                                );
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


                    Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8, top: 8),
                    child: Container(

                      child: GridView.builder(
                          padding: EdgeInsets.only(top: 8),
                          shrinkWrap: true,
                       //   physics: NeverScrollableScrollPhysics(),
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisExtent: size.height * 0.17,
                              crossAxisCount: 2,
                              mainAxisSpacing: 16),
                          itemCount:snapshot.data!.docs.length,

                          itemBuilder: (BuildContext ctx, index) {

                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => ServiceDetailScreen(
                                        serviceName: snapshot.data!.docs[index]["serviceName"].toString(),
                                        servicePrice: snapshot.data!.docs[index]["servicePrice"].toString(),
                                        serviceDescription: snapshot.data!.docs[index]["serviceDescription"].toString(),
                                        payment: 'Not Paid',
                                        status: 'bookUser',
                                        docId: snapshot.data!.docs[index].id,
                                        serviceImage: snapshot.data!.docs[index]["serviceImage"].toString(),),
                                      transitionsBuilder: (c, anim, a2, child) =>
                                          FadeTransition(opacity: anim, child: child),
                                      transitionDuration: Duration(milliseconds: 0),
                                    ),
                                  );
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
          ),

          SizedBox(
            height: size.height*0.02,
          ),
          Container(
            width: size.width*0.9,
            child: Text('Nearest Service Centers', style: TextStyle(
              //color: Colors.black,
                fontSize: 16,
                foreground: Paint()..shader = LinearGradient(
                  colors: <Color>[AppColors.lightBlueColor, AppColors.lightBlueColor2],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                fontWeight: FontWeight.bold),),
          ),

          StreamBuilder(
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
                      shrinkWrap: true,
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
                                          height: size.height*0.005,
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
                                          height: size.height*0.005,
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
                                          height: size.height*0.005,
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
                                          height: size.height*0.005,
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
          SizedBox(
            height: size.height*0.01,
          ),
          // InkWell(
          //   onTap: () {
          //
          //
          //   },
          //   child: Padding(
          //     padding:  EdgeInsets.only(left: 4,right: 4),
          //     child: Container(
          //        height: size.height*0.18,
          //       width: size.width*0.95,
          //       decoration: BoxDecoration(
          //        color: AppColors.lightBlueColor,
          //         // color:
          //         // <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2), ],
          //
          //         // index == 0 ? AppColors.purpleColor.withOpacity(0.5) :
          //         // index == 1 ? AppColors.greenColor2.withOpacity(0.5) :
          //         // index == 2 ? AppColors.darkRedColor.withOpacity(0.5) :
          //         // index == 3 ? AppColors.orangeColor.withOpacity(0.5) :
          //         // Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //               color: AppColors.lightGreyColor,
          //               spreadRadius: 0.5,
          //               blurRadius: 0.3
          //           )
          //         ],
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //
          //             SizedBox(
          //               height: size.height*0.013,
          //             ),
          //
          //             Container(
          //               width: size.width*0.9,
          //               child: Column(
          //                 children: [
          //                   Center(
          //                     child: Padding(
          //                       padding: const EdgeInsets.only(left: 8,right: 8),
          //                       child: Text( "Didnt find your service? Dont worry you can post your requirements.",
          //                         overflow: TextOverflow.ellipsis,
          //                         style:
          //                         TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w400),
          //                         maxLines: 2,
          //                         textAlign: TextAlign.center,
          //                       ),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: size.height*0.01,
          //                   ),
          //
          //                   Container(
          //                     width: size.width*0.6,
          //                     height: size.height*0.05,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(10),
          //                       gradient: LinearGradient(
          //                         colors: [Color(0xFF005d7b), Color(0xFF0a394d)],
          //                         begin: Alignment.topLeft,
          //                         end: Alignment.topRight,
          //                         stops: [0.0, 0.8],
          //                         tileMode: TileMode.clamp,
          //                       ),
          //                     ),
          //                     child: Center(
          //                       child: Padding(
          //                         padding: const EdgeInsets.only(left: 8,right: 8),
          //                         child: Text( " + Post a new service",
          //                           overflow: TextOverflow.ellipsis,
          //                           style:
          //                           TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
          //                           maxLines: 2,
          //                           textAlign: TextAlign.center,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //
          //             SizedBox(
          //               height: size.height*0.013,
          //             ),
          //
          //
          //
          //
          //
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),



        ],),
      ),

    );
  }
}
