import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_board_app/ui/leader_board.dart';

void main() {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  ConnectivityResult connectionStatus = ConnectivityResult.none;

  final Connectivity connectivity = Connectivity();

  void showNoInternetDialog(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }
  void updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        showNoInternetDialog("Connected to mobile Wifi");
        break;
      case ConnectivityResult.mobile:
        showNoInternetDialog("Connected to mobile data");
        break;
      case ConnectivityResult.none:
        showNoInternetDialog("No internet connection");
        break;
      case ConnectivityResult.other:
        showNoInternetDialog("No internet connection");
        break;
      default:
        showNoInternetDialog("Unknown Connection");
    }
  }
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await connectivity.checkConnectivity();
    } catch (e) {
      log(e.toString());
    }
    connectionStatus = result;
  }



  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Leader Board',
        theme: ThemeData(
          // useMaterial3: true,
        ),
        getPages: [GetPage(name: "/", page: () => const LeaderBoard())],
      ),
    );
  }
}
