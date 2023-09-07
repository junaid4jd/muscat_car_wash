import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muscat_car_wash/model/input_validator.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/res/constants.dart';
import 'package:muscat_car_wash/utils/utils.dart';
import 'package:muscat_car_wash/view/authentication/userType/usertype_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCarServiceScreen extends StatefulWidget {
  final String name;
  final String descrition;
  final List<String> list;
  final String selectedCategory;
  final String image;
  final String price;
  final String docId;
  final String status;
  const AddCarServiceScreen({Key? key,
    required this.name,
    required this.list,
    required this.selectedCategory,
    required this.descrition,
    required this.image,
    required this.price,
    required this.docId,
    required this.status,

  }) : super(key: key);

  @override
  _AddCarServiceScreenState createState() => _AddCarServiceScreenState();
}

class _AddCarServiceScreenState extends State<AddCarServiceScreen> {
  final TextEditingController _titleControoler = TextEditingController();
  final TextEditingController _descriptionControoler = TextEditingController();
  final TextEditingController _priceControoler = TextEditingController();
  final TextEditingController _passwordControoler = TextEditingController();
  final TextEditingController _confirmPasswordControoler = TextEditingController();
  final TextEditingController _firstNameControoler = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();

  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isVisible = false;
  bool _isVisibleC = false;

  String name = '' , garageName = '',address = '',userType = '', status = '', uid = '',phone = '';
  String text = '';
  int current = 0;
  bool  _imageLoading = false;
  String dropdownvalue = 'Select Category', isClassNameExist = '';
  List items = [
    'Select Category',
  ];

  // getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   FirebaseFirestore.instance.collection('Mechanic').where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
  //     setState(() {
  //       status = value.docs[0]['status'];
  //       name = value.docs[0]['name'];
  //       garageName = value.docs[0]['garageName'];
  //       address = value.docs[0]['address'];
  //       uid = value.docs[0]['uid'];
  //       phone = value.docs[0]['phone'];
  //
  //     });
  //   });
  // }



  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      profileImage == "";
      dropdownvalue = 'Select Category';
      items = widget.list;
      isClassNameExist = '';
    });
    if(widget.status == 'update') {
      setState(() {
        items = widget.list;
        dropdownvalue = widget.selectedCategory;
        isClassNameExist = 'yes';
        _titleControoler.text = widget.name;
        _descriptionControoler.text = widget.descrition;
        _priceControoler.text = widget.price;
        profileImage = widget.image;
      });
    }
  //  getData();
    super.initState();
  }


  PickedFile? _pickedFile;

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? profileImage= '', docId, driverEmail = '', driverName = '', driverUid = '';

  void _showPicker(context, bool isProfile) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(isProfile);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(isProfile);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(bool isProfile) async {

    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50))!;
    setState(() {
      _imageLoading = true;
      print('List Printed');
      getUrl(_pickedFile!.path).then((value) {
        if (value != null) {
          setState(() {
            profileImage = value.toString();
            _imageLoading = false;
          });
        } else {
          setState(() {
            _imageLoading = false;
          });
          print('sorry error');
        }
      });
    });
  }

  _imgFromGallery(bool isProfile) async {


    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    setState(() {
      _imageLoading = true;
      print('List Printed');
      getUrl(_pickedFile!.path).then((value) {
        if (value != null) {
          setState(() {
            profileImage = value.toString();
            _imageLoading = false;
          });

        } else {
          setState(() {
            _imageLoading = false;
          });
          print('sorry error');
        }
      });
    });
  }

  Future<String?> getUrl(String path) async {
    final file = File(path);
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("image" + DateTime.now().toString())
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      return await snapshot.ref.getDownloadURL();
    }

  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightblueColor,

      //resizeToAvoidBottomInset: false,
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Stack(children: [


              Center(
                child: Container(
                  height: size.height*0.3,
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
                      padding: const EdgeInsets.all(60.0),
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
              Container(
                height: size.height*0.3,
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
                  ],
                ),
              ),

            ],),






            Container(
              decoration: BoxDecoration(
                //color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)
                  )
              ),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [



                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: Container(

                          height: size.height * 0.062,
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(30),

                             border: Border.all(color: darkGreyTextColor1, width: 1),
                            color: whiteColor,
                          ),
                          width: size.width * 0.9,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value: dropdownvalue,

                                hint: const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Select',
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  ),
                                ),
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                isDense: true, // Reduces the dropdowns height by +/- 50%
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: greyColor,
                                  ),
                                ),
                                items: items.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(item, style: body4Black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (selectedItem) {
                                  setState(() {
                                    dropdownvalue = selectedItem.toString();
                                  });
                                 // getData(dropdownvalue);
                                }
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),


                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _titleControoler,
                        keyboardType: TextInputType.name,
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
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText:  "Service Name",

                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _descriptionControoler,
                        keyboardType: TextInputType.name,
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
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Service Description",

                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ) ,
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _priceControoler,
                        keyboardType: TextInputType.number,
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
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Service Charges",

                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),


                        ),
                      ),
                    ),


                    SizedBox(
                      height: size.height*0.025,
                    ),



                    Column(children: [

                      Container(
                        //color: whiteColor,
                        width: size.width * 0.9,
                        height: size.height *0.055,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showPicker(context,true);
                              },
                              child: Container(
                                width: size.width * 0.9,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), border: Border.all(color: AppColors.lightBlueColor2, width: 1)),
                                //  width: size.width*0.15,
                                alignment: Alignment.centerLeft,
                                //  height: size.height*0.08,
                                child: Center(child: Text('Upload Image', style: TextStyle(color: AppColors.lightBlueColor2,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                          ],),
                      ),
                    ],
                    ),

                    _imageLoading ? Center(child: CircularProgressIndicator(color: darkRedColor,)) : Container(),

                    profileImage == "" ? Container() :

                    Container(
                      height: 120, width: 120,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(profileImage.toString(),
                                height: 120, width: 120, fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.white,
                            child: IconButton(onPressed: (){
                              setState(() {
                                profileImage = "";
                              });
                            }, icon: Icon(Icons.cancel, color: Colors.red, size: 20,)),
                          ),
                        ],),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),



                    SizedBox(
                      height: size.height*0.025,
                    ),

                    _isLoading
                        ? CircularProgressIndicator(
                      color: buttonColor,
                      strokeWidth: 2,
                    )
                        :

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
                              AppColors.lightBlueColor,
                              AppColors.lightBlueColor2,


                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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

                               if (dropdownvalue == 'Select Category') {
                                 Utils.flushBarErrorMessage(
                                     "Select category",
                                     context,
                                     AppColors.darkRedColor,
                                     'Error',
                                     2);
                              }
                             else if(_titleControoler.text.isEmpty)
                              {

                                Utils.flushBarErrorMessage(
                                    "Service Name is required",
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);

                              }

                              else if (_descriptionControoler.text.isEmpty  ) {
                                Utils.flushBarErrorMessage(
                                    "Enter Service Description",
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);

                              }
                              else if (profileImage == ''  ) {
                                Utils.flushBarErrorMessage(
                                    "Upload service image",
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);

                              }


                              else {
                                setState(() {
                                  _isLoading = true;
                                  print('We are in loading');
                                  //  state = ButtonState.loading;
                                });

                                print(_titleControoler.text.toString());
                                print( _descriptionControoler.text.toString());
                                print( _passwordControoler.text.toString());
                                //createAccount();
                                //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                try {

                                  if(widget.status == 'update' ) {


                                    FirebaseFirestore.instance
                                        .collection("Services")
                                        .doc(widget.docId)
                                        .set({
                                      "servicePrice": _priceControoler.text,
                                      "serviceName": _titleControoler.text,
                                      "serviceDescription": _descriptionControoler.text,
                                      "serviceImage": profileImage,
                                      "category": dropdownvalue.toString(),
                                      "address": address.toString(),

                                    }).then((value) => print('success'));

                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.of(context).pop();
                                    Utils.flushBarErrorMessage(
                                        "Service updated successfully",
                                        context,
                                        Colors.green,
                                        'Success',
                                        2);


                                  } else {


                                    FirebaseFirestore.instance
                                        .collection("Services")
                                        .doc()
                                        .set({
                                      "servicePrice": _priceControoler.text,
                                      "serviceName": _titleControoler.text,
                                      "serviceDescription": _descriptionControoler.text,
                                      "serviceImage": profileImage,
                                      "category": dropdownvalue.toString(),
                                      "address": address.toString(),

                                    }).then((value) => print('success'));

                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.of(context).pop();

                                    Utils.flushBarErrorMessage(
                                        "Service added successfully",
                                        context,
                                        Colors.green,
                                        'Success',
                                        2);


                                  }



                                }
                                catch (e) {
                                  setState(() {
                                    _isLoading = false;
                                  });

                                  print(e.toString());
                                }



                              }

                            }, child: Text(
                            widget.status == 'update' ? 'Update Service' :
                            'Add Service', style: buttonStyle)),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.1,
                    ),


                  ],
                ),
              ),

            ),
          ],),
      ),
    );
  }
}
