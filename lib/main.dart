import 'package:flutter/material.dart';
import 'package:havadurumu/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Hava Durumu Tarsus',
      theme: ThemeData(
      ),
    );
  }
}



