import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFav;
  final VoidCallback onPressed;

  const FavoriteButton({
    super.key,
    required this.isFav,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav ? Colors.red : Colors.grey,
      ),
    );
  }
}
