import 'package:flutter/material.dart';
import 'package:game_vault/constants.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/widgets/game_image.dart';

class GameTile extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;
  final Widget? trailing;

  const GameTile({
    super.key,
    required this.game,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            GameImage(
              path: game.image,
              fallbackColor: game.color,
              width: 64,
              height: 80,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(game.genre, style: const TextStyle(color: Colors.grey)),
                  Text(
                    '⭐ ${game.rating}',
                    style: const TextStyle(color: Colors.amber),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
