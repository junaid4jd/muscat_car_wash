import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/components/app_text.dart';
import 'package:muscat_car_wash/res/components/round_button.dart';
import 'package:muscat_car_wash/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String userName = '', address = '';
  bool isLoading = false;
  String name = '',email = '', docId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;


  getData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('uid',isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        docId = value.docs[0].id.toString();
        name = value.docs[0]['name'];
        email = value.docs[0]['email'];
        _emailAddressController.text = value.docs[0]['email'];
        _phoneController.text = value.docs[0]['phone'];
        _nameController.text = value.docs[0]['name'];
        _addressController.text = value.docs[0]['address'];
      });
    });

    print(userName.toString() + ' name is here');

  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  bool isLoadingImage = false;

  //final FirebaseAuth auth = FirebaseAuth.instance;
  String? profileImage = '',
      driverEmail = '',
      driverName = '',
      driverUid = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor3,

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
          child: Column(
            children: [

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
                          child: Center(child: Text('Edit Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 25),)),
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
                  width: size.width,
                  child: Center(
                    child: Text(
                      '$name',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                  width: size.width,
                  child: Center(
                    child: Text(
                      '$email',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGreyColor2,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                      child: TextFormField(
                        controller: _nameController,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          hintText: "Full Name",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          //create lable
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGreyColor2,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                      child: TextFormField(
                        controller: _emailAddressController,
                        enabled: false,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          hintText: "Email",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          //create lable
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGreyColor2,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                      child: TextFormField(
                        controller: _phoneController,
                        enabled: false,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          hintText: "Phone",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          //create lable
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGreyColor2,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                      child: TextFormField(
                        controller: _addressController,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.lightBlueColor2, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          hintText: "Address",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),

                          //create lable
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    isLoading
                        ? CircularProgressIndicator(
                      color: Colors.orange,
                      strokeWidth: 2,
                    )
                        :
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: RoundButton(
                        width: size.width,
                        //isLoading: authViewModel.loading,
                        round: 30.0,
                        color: AppColors.orangeColor,
                        title: 'Update',
                        onPress: () async {

                          if(_nameController.text.isEmpty) {
                            Utils.flushBarErrorMessage("Name is required", context, AppColors.darkRedColor, "Error", 2);

                          } else if (_addressController.text.isEmpty) {
                            Utils.flushBarErrorMessage("Address is required", context, AppColors.darkRedColor, "Error", 2);

                          } else {
                            setState(() {
                              isLoading = true;
                            });

    FirebaseFirestore.instance
          .collection('Users')
          .doc(docId)
          .update({
      'name':_nameController.text,
      'address':_addressController.text,
    })
          .then((value) {
      setState(() {
          isLoading = false;
      });
            Navigator.of(context).pop();
      Utils.flushBarErrorMessage("Updated successfully", context, AppColors.greenColor2, "Success", 2);



    });

                          }

                          // Navigator.pushNamed(context, RoutesName.dashView);
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
