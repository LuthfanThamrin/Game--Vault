import 'package:flutter/material.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/widgets/game_image.dart';

class GameBox extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;

  const GameBox({super.key, required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            GameImage(
              path: game.image,
              fallbackColor: game.color,
              radius: 12,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  game.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
