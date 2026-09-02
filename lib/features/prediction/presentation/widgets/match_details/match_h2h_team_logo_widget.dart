import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MatchH2hTeamLogoWidget extends StatelessWidget {
  final String? logoUrl;
  final double size;
  final Color fallbackColor;

  const MatchH2hTeamLogoWidget({
    super.key,
    required this.logoUrl,
    required this.size,
    required this.fallbackColor,
  });

  @override
  Widget build(BuildContext context) {
    if (logoUrl != null && logoUrl!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: logoUrl!,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Container(
              color: fallbackColor,
            ),
          ),
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fallbackColor,
      ),
    );
  }
}
