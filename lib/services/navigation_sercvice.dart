import 'package:flutter/material.dart';
class NavigationService{
  GlobalKey<NavigatorState>navigatorKey= GlobalKey<NavigatorState>();
  void removeAndNavigateRoute(String route){
    navigatorKey.currentState!.popAndPushNamed(route);
  }
  void navigateToRoute(String route){
    navigatorKey.currentState!.pushNamed(route);
  }
  void navigateToPage(Widget page){
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (BuildContext context)=> page));
  }
}