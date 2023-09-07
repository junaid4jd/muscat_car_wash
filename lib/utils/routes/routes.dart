import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muscat_car_wash/utils/routes/routes_name.dart';
import 'package:muscat_car_wash/view/dashboard/dashboard_view.dart';
import 'package:muscat_car_wash/view/home/home_view.dart';

import 'package:muscat_car_wash/view/splash/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());

      case RoutesName.dashView:
        return MaterialPageRoute(
            builder: (BuildContext context) =>  DashboardView());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Center(
                  child: Text('No Route Defined'),
                ));
    }
  }
}
