import 'dart:io';

import 'package:jejuya/app/common/utils/extension/string/file_path_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

/// All in one media loader widget.
class MediaLoader extends StatelessWidget {
  /// Default constructor
  const MediaLoader({
    super.key,
    this.url,
    this.mediaType,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorView,
    this.onAverageColorChanged,
    this.compressQuality = 50,
  });

  /// The URL of the image to load.
  final String? url;

  /// The media type of the image.
  final MediaType? mediaType;

  /// The width of the image.
  final double? width;

  /// The height of the image.
  final double? height;

  /// The fit of the image.
  final BoxFit fit;

  /// The border radius of the image.
  final BorderRadius? borderRadius;

  /// The placeholder widget to display while the image is loading.
  final Widget? placeholder;

  /// The error widget to display if the image fails to load.
  final Widget? errorView;

  /// Compresse image file quality
  final int compressQuality;

  /// The callback to be called when the average color of the image changes.
  final void Function(Color? color)? onAverageColorChanged;

  /// A cache of average colors for images.
  static final Map<String, Color?> averageColorCache = {};

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child: switch (mediaType ?? url?.mediaType) {
          MediaType.image => _imageWidget,
          MediaType.lottie => _lottieWidget,
          MediaType.video => _errorView,
          MediaType.audio => _errorView,
          MediaType.other => _errorView,
          _ => _errorView,
        },
      ),
    );
  }

  Widget get _imageWidget {
    final imageUrl = url;
    if (imageUrl == null) {
      return _errorView;
    }

    if (imageUrl.endsWith('.svg')) {
      if (imageUrl.fileType == FileType.asset) {
        return SvgPicture.asset(
          imageUrl,
          fit: fit,
          width: width,
          height: height,
          placeholderBuilder: (context) => _placeholder,
        );
      }
      if (imageUrl.fileType == FileType.local) {
        final imageProvider = FileImage(File(imageUrl));
        return Image.file(
          imageProvider.file,
          fit: fit,
          width: width,
          height: height,
        );
      }
      return SvgPicture.network(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        placeholderBuilder: (context) => _placeholder,
      );
    }

    if (imageUrl.fileType == FileType.asset) {
      return Image.asset(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => _errorView,
      );
    }

    if (imageUrl.fileType == FileType.local) {
      return Image.file(
        File(imageUrl),
        fit: fit,
        width: width,
        height: height,
        gaplessPlayback: true,
        errorBuilder: (_, __, ___) => _errorView,
      );
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) {
          return child;
        }
        return _placeholder;
      },
      errorBuilder: (context, url, error) => _errorView,
    );
  }

  Widget get _lottieWidget {
    final lottieUrl = url;
    if (lottieUrl == null) {
      return _errorView;
    }
    if (lottieUrl.fileType == FileType.asset) {
      return Lottie.asset(
        lottieUrl,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => _errorView,
      );
    }

    if (lottieUrl.fileType == FileType.local) {
      return Lottie.file(
        File(lottieUrl),
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => _errorView,
      );
    }

    return Lottie.network(
      lottieUrl,
      width: width,
      height: height,
      fit: fit,
      onLoaded: (composition) {
        _placeholder;
      },
      errorBuilder: (context, url, error) => _errorView,
    );
  }

  Widget get _placeholder => placeholder ?? const SizedBox.shrink();

  Widget get _errorView => errorView ?? const SizedBox.shrink();
}
