import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkCachedImage extends StatelessWidget {
  const NetworkCachedImage({
    super.key,
    required this.url,
    this.wight,
    this.height,
    this.fit,
  });

  final String url;
  final double? wight;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (_, __, ___) {
        return const CircularProgressIndicator();
      },
      errorWidget: (_, __, ___){
        return const Icon(Icons.error_outline);
      },
    );
  }
}
