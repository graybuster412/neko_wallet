import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../skeleton_image_cache_network.dart';

class SkeletonCircleAvatar extends StatelessWidget {
  const SkeletonCircleAvatar({Key? key, required this.url, this.radius: 40})
      : super(key: key);

  final String url;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SkeletonImageCacheNetwork(
        imageURL: url,
        imageSize: Size(36, 36),
        errorWidget: Icon(
          FontAwesomeIcons.circleUser,
          size: 36,
        ),
      ),
    );
  }
}
