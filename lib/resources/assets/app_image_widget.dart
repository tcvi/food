import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'images_path.dart';

class AppImageWidget extends StatelessWidget {
  final String url;
  final Color? color;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  const AppImageWidget(
      {Key? key,
        required this.url,
        this.color,
        this.fit,
        this.width,
        this.height,
        this.placeHolder,
        this.errorWidget,
        this.borderRadius})
      : super(key: key);

  const AppImageWidget.square({
    Key? key,
    required this.url,
    this.color,
    this.fit,
    required double dimension,
    this.placeHolder,
    this.errorWidget,
    this.borderRadius,
  })  : width = dimension,
        height = dimension,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.startsWith('http')) {
      final imageWidget = CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: _buildPlaceWidget,
        errorWidget: _buildErrorWidget,
      );
      if (borderRadius != null) {
        return ClipRRect(
          borderRadius: borderRadius,
          child: imageWidget,
        );
      }
      return imageWidget;
    }
    return AppImage(
      url,
      color: color,
      fit: fit,
      width: width,
      height: height,
    );
  }

  Widget _buildErrorWidget(BuildContext context, String url, error) {
    if (errorWidget != null) return errorWidget!;
    return AppImage(
      ImagesPath.icError,
      color: color,
      fit: fit,
      width: width,
      height: height,
    );
  }

  Widget _buildPlaceWidget(BuildContext context, String url) {
    if (placeHolder != null) return placeHolder!;
    return const Placeholder();
  }
}

class AppImage extends StatelessWidget {
  final String name;
  final Color? color;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final String path;

  const AppImage(
      this.name, {
        Key? key,
        this.color,
        this.fit,
        this.height,
        this.width,
      })  : path = '${ImagesPath.imagesFolder}/$name',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (name.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      );
    }
    return Image.asset(
      path,
      color: color,
      height: height,
      width: width,
      fit: fit ?? BoxFit.fitHeight,
    );
  }
}