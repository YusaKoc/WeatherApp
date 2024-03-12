import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:havadurumu/mainPage.dart';

final GoRouter router = GoRouter(routes:[ GoRoute(path: "/",builder: (BuildContext context,GoRouterState state){
  return MainPage();
})]);