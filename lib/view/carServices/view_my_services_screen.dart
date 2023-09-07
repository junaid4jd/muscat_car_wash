import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/constants.dart';
import 'package:muscat_car_wash/view/carServices/add_carService_screen.dart';

class ViewServiceScreen extends StatefulWidget {
  final List<String> list;
  const ViewServiceScreen({Key? key,required this.list}) : super(key: key);

  @override
  _ViewServiceScreenState createState() => _ViewServiceScreenState();
}

class _ViewServiceScreenState extends State<ViewServiceScreen> {
  String dropdownvalue = 'Select Category';
  List items = [
    'Select Category',
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      dropdownvalue = 'Select Category';
      items = widget.list;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.lightBlueColor2,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCarServiceScreen(
              name: '', descrition: '', price: '', status: 'add', docId: '', image: '', list: widget.list, selectedCategory: '',)),
          );
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.lightBlueColor2,
        centerTitle: true,
        title: Text('Services',style: TextStyle(color: Colors.white,fontSize: 14),),
      ),

      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Services").snapshots(),
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
            return Center(
              child: Container(
                width: size.width * 0.95,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (c, a1, a2) => UserDetailScreen(
                        //       docId: snapshot.data!.docs[index].id.toString(),
                        //       userStatus: "Students",
                        //
                        //     ),
                        //     transitionsBuilder: (c, anim, a2, child) =>
                        //         FadeTransition(opacity: anim, child: child),
                        //     transitionDuration: Duration(milliseconds: 100),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 0, left: 0, right: 0),
                        child: Container(
                          width: size.width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: primaryColor1),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0,bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  //  color: redColor,
                                  // width: size.width * 0.73,

                                  child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Row(
                                        children: [

                                          ClipRRect(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                            child: Image.network(snapshot
                                                .data!
                                                .docs[index]
                                            ["serviceImage"]
                                                .toString(),
                                            height: 110,
                                              width: size.width * 0.25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              //  color: Colors.orange,
                                              width: size.width * 0.35,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [
                                                  Container(
                                                    // color: Colors.yellow,
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      "Service Id #${index+1}" ,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600,
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
                                                      ["serviceName"]
                                                          .toString() ,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500,
                                                          height: 1.3),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: size.width*0.35,
                                                    // color: Colors.yellow,
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      snapshot
                                                          .data!
                                                          .docs[index]
                                                      ["serviceDescription"]
                                                          .toString() ,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.3),
                                                      maxLines: 2,
                                                    ),
                                                  ),

                                                  Container(
                                                    // color: Colors.yellow,
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      "OMR " + snapshot
                                                          .data!
                                                          .docs[index]
                                                      ["servicePrice"]
                                                          .toString() ,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Container(
                                            width: 1,
                                            height: 40,
                                            color: Colors.grey.withOpacity(0.3),
                                          ),

                                          Container(
                                            // color: Colors.greenAccent,
                                            // width: size.width * 0.27,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [

                                                      SizedBox(width: size.width*0.05,),
                                                      GestureDetector(
                                                          onTap:() {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => AddCarServiceScreen(
                                                                name: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["serviceName"]
                                                                    .toString(),
                                                                descrition:  snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["serviceDescription"]
                                                                    .toString(),
                                                                price:  snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["servicePrice"]
                                                                    .toString(), status: 'update', docId: snapshot
                                                                  .data!
                                                                  .docs[index].id.toString(), image:
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["serviceImage"]
                                                                  .toString(), selectedCategory: '', list: []
                                                                ,)),
                                                            );
                                                          },
                                                          child: Icon(Icons.edit, size: 25,color: Colors.blue,)),
                                                      SizedBox(width: 10,),
                                                      GestureDetector(
                                                          onTap:() {

                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title:
                                                                  const Text('Delete'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        Navigator.of(
                                                                            context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor1,
                                                                              borderRadius: BorderRadius.circular(0)
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(16.0),
                                                                            child: const Text('Cancel', style: TextStyle(color: whiteColor),),
                                                                          )),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () async {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            "Services")
                                                                            .doc(snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .id
                                                                            .toString())
                                                                            .delete()
                                                                            .whenComplete(
                                                                                () {
                                                                              Navigator.of(
                                                                                  context)
                                                                                  .pop();
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                  const SnackBar(
                                                                                      backgroundColor: Colors.red,
                                                                                      content:  Text('Successfully Deleted',style: TextStyle(color: whiteColor),)
                                                                                  )
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.red,
                                                                              borderRadius: BorderRadius.circular(0)
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(16.0),
                                                                            child: const Text('Delete', style: TextStyle(color: whiteColor),),
                                                                          )),
                                                                    ),
                                                                  ],
                                                                  content: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisSize:
                                                                    MainAxisSize.min,
                                                                    children: [
                                                                      const Text(
                                                                          'Are you sure you want to delete?'),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );

                                                          },
                                                          child: Icon(Icons.delete, size: 25,color: Colors.red,)),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
