import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';

class ImageFromUrl extends ConsumerWidget {
  final String? imageUrl;
  const ImageFromUrl({this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInvalidUrl =
        (imageUrl != null) ? imageUrl!.startsWith("http") : false;
    if (imageUrl == null || imageUrl == Strings.emptyString || !isInvalidUrl) {
      return const Icon(Icons.broken_image);
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
        fit: BoxFit.cover,
      );
    }
  }
}
