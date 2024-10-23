import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ios_activities/channels/channels.dart';
import 'package:flutter_ios_activities/utils/random_address.dart';
import 'package:flutter_ios_activities/models/uber_model.dart';
import 'package:flutter_ios_activities/utils/time_generator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  var channels = Channels();
  var uberModel = UberModel.defaultData();
  var timeGenerator = TimeGenerator("3:01pm");
  var counter = 0.02;
  Timer? timer;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CustomCupertinoNavigationBar(
        title: "Flutter Conf 2024",
        height: 180,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              child: const Text('Dynamic Island On Start'),
              onPressed: () async {
                final map = uberModel.toMap();
                await channels.onStart(map);
              },
            ),
            CupertinoButton(
              child: const Text('Dynamic Island On Update'),
              onPressed: () async {
                await channels.onUpdateDynamicIsland(uberModel
                    .copyWith(
                      data: uberModel.data.copyWith(),
                    )
                    .toMap());
              },
            ),
            const Divider(),
            CupertinoButton(
              child: const Text('Widget'),
              onPressed: () {},
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (Timer t) async {
            var sum = counter += 0.02;

            await channels.onUpdateDynamicIsland(uberModel
                .copyWith(
                  data: uberModel.data.copyWith(
                    uberProgress: sum,
                    uberAddress: AddressGenerator.generateRandomAddress(),
                    uberArriveTime: timeGenerator.decreaseTime(),
                  ),
                )
                .toMap());
          },
        );
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}

class CustomCupertinoNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final String title;
  final double height;

  const CustomCupertinoNavigationBar({
    super.key,
    required this.title,
    this.height = 100.0, // Set a default or custom height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: CupertinoColors.systemGrey.withOpacity(0.1), // Optional background
      padding: const EdgeInsetsDirectional.only(start: 16, top: 30),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
