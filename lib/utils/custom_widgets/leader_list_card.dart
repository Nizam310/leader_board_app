import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaderBoardListCard extends StatelessWidget {
  final String name;
  final String point;
  final String number;
  final String image;
  const LeaderBoardListCard({
    super.key,
    required this.name,
    required this.point,
    required this.number,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "$number" "${"."}",
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ).paddingOnly(right: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    imageUrl: image,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ).paddingOnly(right: 10),
                Text(
                  name,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Text(
              point,
              style: context.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
