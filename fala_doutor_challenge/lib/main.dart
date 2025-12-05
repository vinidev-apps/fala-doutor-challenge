import 'package:fala_doutor_challenge/app/app_module.dart';
import 'package:fala_doutor_challenge/app/app_widget.dart';
import 'package:fala_doutor_challenge/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // App
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
