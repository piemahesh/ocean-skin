import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skin_chat/core/bloc_observer.dart';
import 'app/app.dart';
import 'app/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Bloc.observer = AppBlocObserver(); // For BLoC logging

  runApp(const MyApp());
}
