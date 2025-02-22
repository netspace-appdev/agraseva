import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData errorIcon;
  final Color errorWidgetBg;

  const CustomCachedImage({
    Key? key,
    required this.imageUrl,
    this.width = 100.0,
    this.height = 100.0,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorIcon = Icons.person,
    this.errorWidgetBg = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: borderRadius,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color:errorWidgetBg,
          borderRadius: borderRadius,
        ),
        child: Icon(
          errorIcon,
          color: Colors.grey,
          size: width < height ? width * 0.5 : height * 0.5,
        ),
      ),
    );
  }
}
