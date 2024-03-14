import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:leader_board_app/controller/leader_board_controller.dart';
import 'package:leader_board_app/utils/custom_widgets/leader_list_card.dart';

import '../utils/custom_widgets/leader_top_card.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final controller = Get.put(LeaderBoardController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getLeaderListFromDB();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Text(
          String.fromCharCode(Icons.arrow_back_ios.codePoint),
          style: TextStyle(
            inherit: false,
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: Icons.arrow_back_ios.fontFamily,
            package: Icons.arrow_back_ios.fontPackage,
          ),
        ).paddingOnly(left: 15, top: 18),
        title: Text(
          "LeaderBoard",
          style: context.textTheme.titleLarge
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Region:",
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ).paddingOnly(right: 5),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        color: Colors.blue,
                        size: 13,
                      ),
                      Text(
                        "Kozhikode",
                        style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ).paddingOnly(bottom: 20, right: 20, left: 20),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: LeaderBoardTopCard(
                      name: "Jane Smith",
                      point: "3200",
                      fullHeight: 140,
                      boxHeight: 110,
                      cardColor: Color(0xFFC3C3C8),
                      image: "https://randomuser.me/api/portraits/women/1.jpg",
                      icon: Icons.arrow_drop_up,
                      iconColor: Color(0xFF17A526),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                ),
                Expanded(
                  child: LeaderBoardTopCard(
                      name: "John Doe",
                      point: "3500",
                      fullHeight: 180,
                      boxHeight: 150,
                      cardColor: Color(0xFFFAD741),
                      image: "https://randomuser.me/api/portraits/men/1.jpg",
                      icon: Icons.arrow_drop_up,
                      iconColor: Color(0xFF17A526),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                ),
                Expanded(
                  child: LeaderBoardTopCard(
                      name: "Michael johnson",
                      point: "3000",
                      fullHeight: 120,
                      boxHeight: 100,
                      cardColor: Color(0xFFD2965A),
                      image: "https://randomuser.me/api/portraits/men/2.jpg",
                      icon: Icons.arrow_drop_down,
                      iconColor: Colors.red,
                      padding: 35,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                ),
              ],
            ).paddingOnly(bottom: 10, right: 20, left: 20),
            GetBuilder<LeaderBoardController>(


                builder: (controller) {
              return Visibility(
                visible: controller.leaderList.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.white,
                        Colors.grey.shade200,
                        Colors.grey.shade200,
                        Colors.grey.shade200,
                      ])),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFDCDCDC)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Username",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Points",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 5),
                            GetBuilder<LeaderBoardController>(
                                init : LeaderBoardController (),
                              builder: (controller) {
                                return Column(
                                  children: controller.leaderList
                                      .asMap()
                                      .entries
                                      .map((e) {
                                    final data = e.value;
                                    final index = e.key;
                                    return Animate(
                                      effects: const [
                                        ScaleEffect(),
                                      ],
                                      delay: Duration(
                                          milliseconds: 300 + (index * 100)),
                                      child: LeaderBoardListCard(
                                        name: data.name.toString(),
                                        point: data.points.toString(),
                                        number: data.userId.toString(),
                                        image: data.profilePic.toString(),
                                        // Adjust width if necessary
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ).paddingOnly(top: 20),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        height: 60,
        shape: const CircularNotchedRectangle(),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        clipBehavior: Clip.hardEdge,
        shadowColor: Colors.black,
        elevation: 20,
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/home.png",
              height: 25,
              width: 25,
            ),
            Image.asset(
              "assets/images/arrow.png",
              height: 30,
              width: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () async {},
          backgroundColor: Colors.red,
          child: const ImageIcon(
            AssetImage(
              "assets/images/scanner.png",
            ),
            color: Colors.white,
            size: 20,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
