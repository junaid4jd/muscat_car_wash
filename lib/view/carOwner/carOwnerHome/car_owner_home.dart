import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/constants.dart';
import 'package:muscat_car_wash/view/admin/adminHomeScreen/admin_home_screen.dart';
import 'package:muscat_car_wash/view/authentication/userType/usertype_screen.dart';
import 'package:muscat_car_wash/view/carOwner/carServices/view_services_screen.dart';
import 'package:muscat_car_wash/view/carServices/service_request_screen.dart';
import 'package:muscat_car_wash/view/feedbackReport/admin_owner_feedback_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../admin/nearestCarServices/nearest_car_services.dart';

class CarOwnerHomeScreen extends StatefulWidget {
  const CarOwnerHomeScreen({super.key});

  @override
  State<CarOwnerHomeScreen> createState() => _CarOwnerHomeScreenState();
}

class _CarOwnerHomeScreenState extends State<CarOwnerHomeScreen> {
  List<String> categories = [];

  int y=0, current = 0;
  String name = '' , email = '',
      uid = '',
      users = '',
      feedback = '',
      incidents = '',
      category = '';
  String text = '';
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String subject = '';
  // MethodsHandler _methodsHandler = MethodsHandler();
  bool isloading = true;

  List<Product> _categories = [

    Product(
      title: 'Feedback',
      addToCart: 0,
      sale: 'Sale',
      isNew: '',
      id: '',
      quantity: '330g',
      ruppes: 'AED3.81',
      image: 'assets/images/feedback.png',
      favorite: false,
    ),
    Product(
      title: 'Car Services',
      addToCart: 0,
      sale: 'Sale',
      isNew: '',
      id: '',
      quantity: '330g',
      ruppes: 'AED3.81',
      image: 'assets/images/service.png',
      favorite: false,
    ),
    Product(
      title: 'Request Services',
      addToCart: 0,
      sale: 'Sale',
      isNew: '',
      id: '',
      quantity: '330g',
      ruppes: 'AED3.81',
      image: 'assets/images/request.png',
      favorite: false,
    ),
    Product(
      title: 'Logout',
      addToCart: 0,
      sale: 'Sale',
      isNew: '',
      id: '',
      quantity: '330g',
      ruppes: 'AED3.81',
      image: 'assets/images/shutdown.png',
      favorite: false,
    ),
  ];



  getData() {

    setState(() {
      y=1;
    });
    // FirebaseFirestore.instance.collection('Users').get().then((value) {
    //
    //   if(value.docs.isNotEmpty) {
    //     setState(() {
    //       users = value.docs.length.toString();
    //     });
    //
    //   }
    // });

    FirebaseFirestore.instance.collection('Feedback').get().then((value) {

      if(value.docs.isNotEmpty) {
        setState(() {
          feedback = value.docs.length.toString();
        });

      }
    });

    // FirebaseFirestore.instance.collection('Categories').get().then((value) {
    //   setState(() {
    //     categories.clear();
    //   });
    //   if(value.docs.isNotEmpty) {
    //
    //     setState(() {
    //       category = value.docs.length.toString();
    //       categories.add('Select Category');
    //     });
    //     for(int i=0;i<value.docs.length;i++) {
    //       setState(() {
    //         categories.add(value.docs[i]['categoryName'].toString());
    //       });
    //     }
    //
    //   }
    // });


  }

  @override
  void initState() {
    setState(() {

      isloading = false;
      y=0;
      users = '0';
      feedback = '0';
      incidents = '0';
      category = '0';
    });
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> banners1 = [

      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 170,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl:  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9hToXYtp3O9N8wu4l6CvzQwewc1XFlzz5LGSka0oKtm_I0tkkLcmo4XC07SHTl6U2jnw&usqp=CAU',
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
          imageUrl:  'https://stepbystepbusiness.com/wp-content/uploads/2021/11/How-to-Start-a-Car-Wash-Business_Thumbnail-1024x612.jpg',
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
          imageUrl:  'https://www.cdge.com.sg/wp-content/uploads/2022/06/Training-Personal-Homepage_Related-Services-3_580x900.jpg',
          //   placeholder: (context, url) => CircularProgressIndicator(color: darkRedColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),


    ];
    if(y==0) {
      getData();
    }
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: showExitPopup,

      child: Scaffold(
          backgroundColor: lightblueColor,
          resizeToAvoidBottomInset: false,


          body:
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade300, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  stops: [0.0, 0.8],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Column(children: [
                SizedBox(
                  height: size.height*0.05,
                ),

                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    //  height: size.height * 0.1,
                      width: size.width,
                      decoration: BoxDecoration(
                        //     color: primaryColor,

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.whiteColor
                              ),
                              child: Image.asset('assets/images/logo.png',height: 100, width: 100,fit: BoxFit.cover,))


                        ],)
                  ),
                ),
                SizedBox(
                  height: size.height*0.015,
                ),
                Text('Welcome Car Wash Owner', style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w700),),


                // Padding(
                //   padding: const EdgeInsets.only(left: 8,right: 8, top: 8),
                //   child: Container(
                //
                //     child: GridView.builder(
                //         padding: EdgeInsets.only(top: 8),
                //         shrinkWrap: true,
                //         //   physics: NeverScrollableScrollPhysics(),
                //         gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisSpacing: 10,
                //             mainAxisExtent: size.height * 0.17,
                //             crossAxisCount: 2,
                //             mainAxisSpacing: 16),
                //         itemCount:snapshot.data!.docs.length,
                //
                //         itemBuilder: (BuildContext ctx, index) {
                //
                //           return InkWell(
                //             onTap: () {
                //               if(index == 0) {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(builder: (context) => FeedbackScreen()));
                //               }
                //
                //               if(index == 1) {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(builder: (context) => EmergencyService()));
                //               }
                //
                //               if(index == 2) {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(builder: (context) => IncidentReportView()));
                //               }
                //               if(index == 3) {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(builder: (context) => ViewMap()));
                //               }
                //
                //               else {
                //
                //                 // Navigator.push(
                //                 //   context,
                //                 //   PageRouteBuilder(
                //                 //     pageBuilder: (c, a1, a2) => CategoryItemScreen(category: snapshot.data!.docs[index]["categoryName"].toString(),),
                //                 //     transitionsBuilder: (c, anim, a2, child) =>
                //                 //         FadeTransition(opacity: anim, child: child),
                //                 //     transitionDuration: Duration(milliseconds: 0),
                //                 //   ),
                //                 // );
                //               }
                //
                //             },
                //             child: Padding(
                //               padding:  EdgeInsets.only(left: 4,right: 4),
                //               child: Container(
                //                 // height: size.height*0.25,
                //                 width: size.width*0.43,
                //                 decoration: BoxDecoration(
                //                   gradient:  LinearGradient(
                //                     begin: Alignment.centerRight,
                //                     end: Alignment.centerLeft,
                //                     colors:
                //
                //                     <Color>[Color((math.Random().nextDouble() * 0x000FF0).toInt()),Color((math.Random().nextDouble() * 0x000000).toInt()).withOpacity(0.8), ],
                //                   ),
                //                   // color:
                //                   // <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2), ],
                //
                //                   // index == 0 ? AppColors.purpleColor.withOpacity(0.5) :
                //                   // index == 1 ? AppColors.greenColor2.withOpacity(0.5) :
                //                   // index == 2 ? AppColors.darkRedColor.withOpacity(0.5) :
                //                   // index == 3 ? AppColors.orangeColor.withOpacity(0.5) :
                //                   // Colors.white,
                //                   borderRadius: BorderRadius.circular(10),
                //                   boxShadow: [
                //                     BoxShadow(
                //                         color: AppColors.lightGreyColor3,
                //                         spreadRadius: 0.5,
                //                         blurRadius: 0.3
                //                     )
                //                   ],
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.only(left: 0),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     children: [
                //
                //                       Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: ClipRRect(
                //                           borderRadius: BorderRadius.circular(10),
                //                           child: Image.network(snapshot.data!.docs[index]["serviceImage"].toString(), fit: BoxFit.cover,
                //                             height: size.height*0.09,
                //                             width: size.width*0.4,
                //                             // height: 80,
                //                             // width: 80,
                //                           ),
                //                         ),
                //                       ),
                //
                //                       Container(
                //                         width: size.width*0.43,
                //                         child: Center(
                //                           child: Padding(
                //                             padding: const EdgeInsets.only(left: 8,right: 8),
                //                             child: Text( snapshot.data!.docs[index]["serviceName"].toString(),
                //                               overflow: TextOverflow.ellipsis,
                //                               style:
                //                               TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),
                //                               maxLines: 2,
                //                               textAlign: TextAlign.center,
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //
                //                       SizedBox(
                //                         height: size.height*0.01,
                //                       ),
                //
                //                       Container(
                //                         width: size.width*0.28,
                //                         decoration: BoxDecoration(
                //                             color: AppColors.darkRedColor,
                //                             borderRadius: BorderRadius.circular(10)
                //                         ),
                //                         child: Center(
                //                           child: Padding(
                //                             padding: const EdgeInsets.only(left: 8,right: 8, top: 4,bottom: 4),
                //                             child: Text( "Price OMR"+ snapshot.data!.docs[index]["servicePrice"].toString(),
                //                               overflow: TextOverflow.ellipsis,
                //                               style:
                //                               TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w500),
                //                               maxLines: 2,
                //                               textAlign: TextAlign.center,
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //
                //
                //
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           );
                //         }),
                //   ),
                // ),

                SizedBox(
                  height: size.height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: CarouselSlider(
                        items: banners1,
                        options: CarouselOptions(
                          height: size.height*0.18,
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

                isloading ? Center(child: CircularProgressIndicator(color: primaryColor,)) :
                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                      child: Column(
                        children: [
                          Container(
                            // decoration: BoxDecoration(
                            //     color: primaryColor,
                            //     borderRadius: BorderRadius.circular(50)
                            //
                            // ),
                            // height: size.height * 0.5,
                            child: GridView.builder(
                                padding: EdgeInsets.only(top: 0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 0,
                                    crossAxisCount: 2,
                                    mainAxisExtent: 135,
                                    mainAxisSpacing: 10),
                                itemCount: _categories
                                    .length, //snapshot.data!.docs.length,//myProducts.length,
                                itemBuilder: (BuildContext ctx, index1) {
                                  return GestureDetector(
                                    onTap: () async {
                                      print(index1.toString());

                                      if(index1 == 0) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ViewFeedbackScreen()));
                                      }
                                      if(index1 == 1) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ViewOwnerServiceScreen()));
                                      }
                                      else if(index1 == 2) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ServiceRequestScreen()));
                                      }
                                      else if(index1 == 3) {

                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        try {
                                          prefs.remove('userEmail');
                                          prefs.remove('userType');
                                          prefs.remove('userPassword');
                                          prefs.remove('userId');
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));
                                        } catch (e) {
                                          return null;
                                        }
                                      }


                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 8,top: 0),
                                      child: Container(
                                        //width: size.width * 0.3,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          //shape: BoxShape.circle,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                                          color: Colors.white,
                                          gradient:  LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors:
                                            index1 == 0 ? <Color>[Colors.red.shade100, AppColors.darkRedColor,] :
                                            index1 == 1 ? <Color>[Colors.purple.shade50, threeColor.withOpacity(0.5),] :
                                            index1 == 2 ? <Color>[Colors.blue.shade50, fourColor.withOpacity(0.5),] :
                                            index1 == 3 ? <Color>[Colors.green.shade100, Colors.green,] :
                                            index1 == 4 ? <Color>[Colors.orange.shade50, AppColors.orangeColor,] :
                                            <Color>[Colors.teal.shade50, Colors.teal],
                                          ),

                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Container(

                                                  child:
                                                  _categories[index1].title.toString() == 'Users' ?
                                                  Image.asset(
                                                    _categories[index1].image.toString(),
                                                    // _categories[index]
                                                    //     .image
                                                    //     .toString(),
                                                    fit: BoxFit.scaleDown,
                                                    height: 40,
                                                    width: 40,
                                                    color:
                                                    Colors.white
                                                    ,
                                                  ) : Image.asset(
                                                    _categories[index1].image.toString(),
                                                    // _categories[index]
                                                    //     .image
                                                    //     .toString(),
                                                    fit: BoxFit.scaleDown,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            // index1 == 2 || index1 == 3 || index1 == 4 ? Container() :
                                            // Center(
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //       shape: BoxShape.circle,
                                            //       color: whiteColor,
                                            //       boxShadow: [
                                            //         BoxShadow(
                                            //           color: primaryColor1
                                            //               .withOpacity(0.4),
                                            //           spreadRadius: 1.2,
                                            //           blurRadius: 0.8,
                                            //           offset: Offset(0,
                                            //               0), // changes position of shadow
                                            //         ),
                                            //       ],
                                            //     ),
                                            //     child: Padding(
                                            //       padding: const EdgeInsets.all(8.0),
                                            //       child: Text(
                                            //         index1 == 0 ? users.toString() :
                                            //         index1 == 1 ? feedback.toString() :
                                            //         index1 == 2 ? incidents.toString() :
                                            //
                                            //         category.toString(),
                                            //         style: TextStyle(fontSize: 15,color:
                                            //         index1 == 0 ? fourColor  :
                                            //         index1 == 1 ? threeColor  :
                                            //         index1 == 2 ? twoColor  :
                                            //         oneColor,fontWeight: FontWeight.bold,),
                                            //         textAlign: TextAlign.center,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),

                                            Center(
                                              child: Text(
                                                _categories[index1].title.toString(),
                                                style: TextStyle(fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: size.height * 0.02,
                    // ),
                  ],
                ),
                SizedBox(
                  height: size.height*0.0,
                ),
                GestureDetector(
                  onTap: () async {
                  //  print(index1.toString());

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CarRepairListView()));


                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18,right: 18,top: 0),
                    child: Container(
                      height: size.height * 0.15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                        color: Colors.white,
                        gradient:  LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors:

                          <Color>[Colors.teal.shade50, Colors.teal],
                        ),

                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Container(

                                child:
                                Image.asset(
                                  'assets/images/location.png',
                                  // _categories[index]
                                  //     .image
                                  //     .toString(),
                                  fit: BoxFit.scaleDown,
                                  height: 60,
                                  width: 60,
                                ),
                              )),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          Center(
                            child: Text(
                              'Nearest Car Service Centers',
                              style: TextStyle(fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height*0.1,
                ),

              ],),
            ),
          )





      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await
    showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                primary: redColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}
