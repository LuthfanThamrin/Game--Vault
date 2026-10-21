import 'package:flutter/material.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/widgets/game_image.dart';


class GameSquare extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;
  final Widget? trailing;

  const GameSquare({
    super.key,
    required this.game,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GameImage(
            path: game.image,
            fallbackColor: game.color,
            radius: 14,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 8,
            child: Text(
              game.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (trailing != null) Positioned(top: 4, right: 4, child: trailing!),
        ],
      ),
    );
  }
}