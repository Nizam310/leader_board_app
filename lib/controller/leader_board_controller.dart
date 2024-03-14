import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/LeadBoardModel.dart';

class LeaderBoardController extends GetxController {
  final screenWidth = MediaQuery.of(Get.context!).size.width;
  RxBool startAnimation = false.obs;
  List<Leaders> leaderList = [];
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  final Dio _dio = Dio();

  RxBool loadData = false.obs;

  void trustAllCertificates() {
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  }

  Future<void> getLeaderList() async {
    try {
      trustAllCertificates();
      final response = await _dio
          .get("https://run.mocky.io/v3/078310bd-5004-4d1e-af40-65917daa6eeb");
      if (response.statusCode == 200) {
        final jsonData = jsonEncode(response.data);
        final jsonD = jsonDecode(jsonData) as Map<String, dynamic>;
        final LeadBoardModel model = LeadBoardModel.fromJson(jsonD);
        model.leaders?.sort((a, b) => int.parse(a.userId.toString())
            .compareTo(int.parse(b.userId.toString())));
        final leaderMap = <int, Leaders>{};
        for (final leader in model.leaders?.toList() ?? []) {
          leaderMap[int.parse(leader.userId.toString())] = leader;
        }

        leaderList = leaderMap.values.toList();

        final pref = await SharedPreferences.getInstance();
        pref.setString("leadList", json.encode(leaderMap.values.toList()));
        update();
      } else {
        log(response.statusCode.toString());
      }
    } catch (error) {
      log("Error exception: $error");
    }
  }

  ConnectivityResult connectionStatus = ConnectivityResult.none;

  getLeaderListFromDB() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(
      "leadList",
    );
    if (data != null) {
      leaderList =
          (json.decode(data) as List).map((e) => Leaders.fromJson(e)).toList();
      print(leaderList.length);
      update();
    } else {
      log("List is empty");
    }
  }

  final Connectivity connectivity = Connectivity();

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await connectivity.checkConnectivity();
    } catch (e) {
      log(e.toString());
    }
    connectionStatus = result;
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

  void showNoInternetDialog(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    getLeaderList();
    getLeaderListFromDB();
  }
}
