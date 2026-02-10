import 'package:flutter/material.dart';
import 'package:pmdm_ejercicio_examen/go_router/app_router.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,

    );
  }
}