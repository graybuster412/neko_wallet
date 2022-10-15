import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/skeleton_container.dart';

class SkeletonImageCacheNetwork extends StatelessWidget {
  const SkeletonImageCacheNetwork(
      {required this.imageURL,
      this.errorWidget,
      this.imageSize: const Size(0, 0)});

  final String imageURL;

  final Size imageSize;

  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: imageURL,
        placeholder: (content, url) => SkeletonContainer.circular(
          height: imageSize.height,
          width: imageSize.width,
          borderRadius: BorderRadius.circular(36 / 2),
        ),
        errorWidget: (content, object, trace) => (errorWidget ?? Container()),
        fit: BoxFit.fill,
      );
}
