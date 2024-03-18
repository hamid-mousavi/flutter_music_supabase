import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music/data/repository/song_repository.dart';
import 'package:music/theme/AppTheme.dart';

void main() async {
  await songRepository.getAll();
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
      theme: ThemeData(
        iconTheme:
            const IconThemeData(size: 40, color: AppTheme.iconBackgroundColor),
        fontFamily: 'Vazir',
        textTheme: const TextTheme(
            headlineSmall: TextStyle(
                color: AppTheme.fontTitleColor,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Color(0xff62CD5D),
            ),
            iconTheme: IconThemeData(
              color: AppTheme.fontTitleColor,
              size: 27,
            )),
        colorScheme: const ColorScheme.light(
          background: AppTheme.backgroundColor,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        leading: const Icon(CupertinoIcons.search),
        title: const Text('data'),
        actions: [const Icon(CupertinoIcons.ellipsis_vertical)],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Text(
                  'News',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Container(
                  height: 4,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.amber,
                          ),
                          width: 147,
                          height: 185,
                        ),
                        const Positioned(
                            bottom: -10,
                            right: 3,
                            child: Icon(
                              CupertinoIcons.play_circle_fill,
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 15),
                      child: Text(
                        'data',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'data',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppTheme.fontCaptionColor,
                            ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
