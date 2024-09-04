import 'package:flutter/material.dart';
class NavigationService{
  GlobalKey<NavigatorState>navigatorKey= new GlobalKey<NavigatorState>();
  void removeAndNavigateRoute(String _route){
    navigatorKey.currentState!.popAndPushNamed(_route);
  }
  void navigateToRoute(String _route){
    navigatorKey.currentState!.pushNamed(_route);
  }
  void navigateToPage(Widget _page){
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (BuildContext _context)=> _page));
  }
}