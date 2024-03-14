import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaderBoardTopCard extends StatelessWidget {
  final String name;
  final String point;
  final double fullHeight;
  final double boxHeight;
  final Color cardColor;
  final String image;
  final IconData icon;
  final Color iconColor;
  final double? padding;
  final BorderRadiusGeometry borderRadius;
  const LeaderBoardTopCard(
      {super.key,
      required this.name,
      required this.point,
      required this.fullHeight,
      required this.boxHeight,
      required this.cardColor,
      required this.image,
      required this.icon,
      required this.iconColor,
      required this.borderRadius, this.padding});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: boxHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration:  BoxDecoration(
                      color: cardColor,
                      borderRadius:borderRadius),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold,fontSize: 10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            color: iconColor,
                            size: 30,
                          ),
                          Text(
                            point,
                            style: context.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ).paddingOnly(top: padding??0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: fullHeight,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  imageUrl: image,
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
