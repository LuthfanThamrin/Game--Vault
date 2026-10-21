import 'package:flutter/material.dart';

class GameImage extends StatelessWidget {
  final String? path;
  final Color fallbackColor;
  final double? width;
  final double? height;
  final double radius;
  final Alignment alignment;

  const GameImage({
    super.key,
    required this.path,
    required this.fallbackColor,
    this.width,
    this.height,
    this.radius = 8,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: path == null
            ? Container(color: fallbackColor)
            : Image.asset(
                path!,
                fit: BoxFit.cover,
                alignment: alignment,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: fallbackColor),
              ),
      ),
    );
  }
}
