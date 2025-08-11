import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/app.dart';
import 'package:learn_flutter/features/controllers/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(create: (_)=> ListController(),
      child: App())
      );
}

