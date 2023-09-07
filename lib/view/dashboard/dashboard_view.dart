import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muscat_car_wash/res/colors.dart';
import 'package:muscat_car_wash/view/home/home_view.dart';
import 'package:muscat_car_wash/view/settings/setting_view.dart';
import 'package:muscat_car_wash/view/users/orders/orders_request_screen.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class DashboardView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardViewState();
  }
}

class DashboardViewState extends State<DashboardView> {
  bool clickedCentreFAB = false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";

  int _selectedIndex = 0;
  List<Widget> _pages = [
    HomeView(),
     UserOrderServiceRequestScreen(),
    SettingView()
  ];


  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      if(index== 0) {
        setState(() {
          _pages[0] = HomeView();
        });
      }  else if(index== 1) {
        setState(() {
          _pages[1] = UserOrderServiceRequestScreen();
        });
      }
      else if(index== 2) {
        setState(() {
          _pages[2] = SettingView();
        });
      }
      else {
      }

      text = buttonText;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor3,
      body: _pages.elementAt(selectedIndex),
      //specify the location of the FAB
      bottomNavigationBar: Container(

        child: BottomAppBar(
         // color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF005d7b), Color(0xFF0a394d)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                stops: [0.0, 0.8],
                tileMode: TileMode.clamp,
              ),
            ),
            margin: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  //update the bottom app bar view each time an item is clicked
                  onPressed: () {
                    updateTabSelection(0, "Home");
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  iconSize: 27.0,
                  icon: Image.asset('assets/images/home.png',
                    color: _selectedIndex == 0 ?  Colors.
                      white: Colors.grey.withOpacity(0.8),
                    fit: BoxFit.scaleDown,width: 25,height: 25,),
                ),
                //to leave space in between the bottom app bar items and below the FAB
                IconButton(
                  //update the bottom app bar view each time an item is clicked
                  onPressed: () {
                    updateTabSelection(1, "Orders");
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  iconSize: 27.0,
                  icon: Image.asset('assets/images/orders.png',
                    color: _selectedIndex == 1 ?  Colors.
                    white: Colors.grey.withOpacity(0.8),
                    fit: BoxFit.scaleDown,width: 25,height: 25,),
                ),
                IconButton(
                  onPressed: () {
                    updateTabSelection(2, "settings");
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  iconSize: 27.0,
                  icon: Image.asset('assets/images/user.png',
                    color: _selectedIndex == 2 ?  Colors.white : Colors.grey.withOpacity(0.8),
                    fit: BoxFit.scaleDown,width: 25,height: 25,),
                ),
              ],
            ),
          ),
          //to add a space between the FAB and BottomAppBar
          shape: CircularNotchedRectangle(),
          //color of the BottomAppBar

        ),
      ),
    );
  }
}