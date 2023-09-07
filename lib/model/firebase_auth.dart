import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
final CollectionReference _mainCollection = firestoreInstance.collection('notes');
class UserData {
  final String? uid;

  UserData({this.uid});
}

class MethodsHandler{

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // UserData? userFromFirebase(User? user) {
  //   return user == null ? null : UserData(uid: user.uid);
  // }
  //
  // Future signInWithEmailAndPassword(String email, String password, BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     final result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     final user = result.user;
  //     prefs.setString('userEmail', email);
  //     prefs.setString('userPassword', password.toString());
  //     prefs.setString('userId', user!.uid);
  //     print('Account creation successful');
  //
  //     Utils.flushBarErrorMessage("Login successfully", context, AppColors.greenColor2, "Success", 2);
  //
  //     return userFromFirebase(user);
  //   } on FirebaseAuthException catch (e) {
  //     print(e.code);
  //     switch (e.code) {
  //       case 'invalid-email':
  //         Utils.flushBarErrorMessage("Login successfully", context, AppColors.darkRedColor, "Success", 2);
  //
  //         Fluttertoast.showToast(
  //           msg: "Invalid Email Address",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 4,
  //         );
  //         break;
  //       case 'wrong-password':
  //         Utils.flushBarErrorMessage("Login successfully", context, AppColors.darkRedColor, "Success", 2);
  //
  //         Fluttertoast.showToast(
  //           msg: "Wrong Password",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 4,
  //         );
  //         break;
  //       case 'user-not-found':
  //         Utils.flushBarErrorMessage("Login successfully", context, AppColors.darkRedColor, "Success", 2);
  //
  //         Fluttertoast.showToast(
  //           msg: "User Not Found",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 4,
  //         );
  //         break;
  //       case 'user-disabled':
  //         Utils.flushBarErrorMessage("Login successfully", context, AppColors.darkRedColor, "Success", 2);
  //
  //         Fluttertoast.showToast(
  //           msg: "User Disabled",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 4,
  //         );
  //         break;
  //     }
  //   }
  // }
  //
  // Future registerWithEmailAndPassword(String email, String password, BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     User? result = (await _auth.createUserWithEmailAndPassword(
  //         email: email.trim(), password: password.trim())).user;
  //     var user = result;
  //     firestoreInstance.collection('users').doc(user!.uid).set(
  //         {
  //           "email": email.trim(),
  //           "password": password,
  //           "uid": user.uid,
  //         }
  //     ).then((value) => print('success'));
  //     prefs.setString('userEmail', email);
  //     prefs.setString('userPassword', password.toString());
  //     prefs.setString('userId', user.uid);
  //     print('Account creation successful');
  //     Fluttertoast.showToast(
  //       msg: "Account created successfully",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 4,
  //     );
  //
  //     try {
  //       await FirebaseFirestore.instance.collection('greetings').doc(user.uid).get().then((doc) {
  //         bool exist = doc.exists;
  //         if(exist == true){
  //           Navigator.push(
  //             context,
  //             PageRouteBuilder(
  //               pageBuilder: (c, a1, a2) => const AppBottomNavigationBar(index: 0,image: '',title: '', date: '', content: '',),
  //               transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
  //               transitionDuration: Duration(milliseconds: 0),
  //             ),
  //           );
  //         } else {
  //           // Navigator.push(
  //           //   context,
  //           //   PageRouteBuilder(
  //           //     pageBuilder: (c, a1, a2) => const AppBottomNavigationBar(index: 0,image: '',title: '', date: '', content: '',),
  //           //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
  //           //     transitionDuration: Duration(milliseconds: 0),
  //           //   ),
  //           // );
  //           // Navigator.push(
  //           //   context,
  //           //   PageRouteBuilder(
  //           //     pageBuilder: (c, a1, a2) =>  GreetingsScreen(status: '',),
  //           //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
  //           //     transitionDuration: Duration(milliseconds: 0),
  //           //   ),
  //           // );
  //         }
  //       });
  //
  //     } catch (e) {
  //       // If any error
  //       return false;
  //     }
  //
  //     //create a new document for the user with the ui
  //     // await DatabaseService(uid: user.uid).updateUserData('', '', 37.4220, -122.0840, '', '', DateTime.now());
  //
  //     return userFromFirebase(user);
  //   }
  //   catch (e) {
  //     return null;
  //   }
  // }
  //
  // Future signOut(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     return await _auth.signOut().whenComplete(() {
  //       prefs.remove('userEmail');
  //       prefs.remove('userType');
  //       prefs.remove('userPassword');
  //       prefs.remove('userId');
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));
  //
  //
  //     });
  //   } catch (e) {
  //     return null;
  //   }
  // }
  //
  // Future<void> resetPassword(String email, BuildContext context) async {
  //   await _auth.sendPasswordResetEmail(email: email).then((value) {
  //     showAlertDialog(context, 'Reset Password', 'Reset Password Email Sent Successfully');
  //     // Fluttertoast.showToast(
  //     //   msg: "Reset Password Email Sent Successfully",
  //     //   toastLength: Toast.LENGTH_SHORT,
  //     //   gravity: ToastGravity.BOTTOM,
  //     //   timeInSecForIosWeb: 4,
  //     // );
  //
  //   });
  // }

  showAlertDialog(BuildContext context, String title, String content) {

    // set up the button

    CupertinoAlertDialog alert =  CupertinoAlertDialog(
      title: Text("$title"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("$content"),
      ),
      actions: [
        // CupertinoDialogAction(
        //     child: Text("YES"),
        //     onPressed: ()
        //     {
        //       Navigator.of(context).pop();
        //     }
        // ),
        CupertinoDialogAction(
            child: Text("OK"),
            onPressed: (){
              Navigator.of(context).pop();
            }
        )
      ],
    );


    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}





