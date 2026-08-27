import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WatchImage extends StatelessWidget {
  const WatchImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final BorderRadius borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => const ColoredBox(
          color: Color(0xFFE8E8E8),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (context, url, error) => const ColoredBox(
          color: Color(0xFFE8E8E8),
          child: Icon(Icons.watch_outlined, color: Colors.black38),
        ),
      ),
    );
  }
}
