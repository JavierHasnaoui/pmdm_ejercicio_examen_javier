import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmdm_ejercicio_examen/my_app/my_app.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
Pasos a realizar antes de esto;
  - Comandos;
      - firebase login
      - flutterfire configure
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.signOut();


  // Para el firestore;
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(const MyApp());
}




