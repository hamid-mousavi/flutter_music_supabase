import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:music/Screens/Auth/Auth.dart';
import 'package:music/Screens/Home/home_page.dart';
import 'package:music/Screens/root/root_screen.dart';
import 'package:music/data/Services/Artist/Artist_Service.dart';
import 'package:music/data/Services/Auth/AuthService.dart';
import 'package:music/data/Services/song/Song_service.dart';
import 'package:music/data/repository/song_repository.dart';
import 'package:music/theme/AppTheme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://ifbdbzawjrqdxbuojwbk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlmYmRiemF3anJxZHhidW9qd2JrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0NTA0NTYsImV4cCI6MjAyNjAyNjQ1Nn0.9OYh7N0O165GoxhaVJfRvJ_YVK2TzWe37gMvJZ7boCQ',
  );

  // songRepository.insertData('test', 'test', 2);
  // var s = songRepository.getAll();

  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      home: const Directionality(
          textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
