import 'package:flutter/material.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/widgets/favorite_button.dart';
import 'package:game_vault/widgets/game_tile.dart';
import 'package:game_vault/widgets/message_view.dart';


class FavoritesTab extends StatelessWidget {
  final List<Game> games;
  final void Function(Game game) onTapGame;
  final void Function(Game game) onToggleFav;

  const FavoritesTab({
    super.key,
    required this.games,
    required this.onTapGame,
    required this.onToggleFav,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = games.where((g) => g.isFav).toList();

    if (favorites.isEmpty) {
      return const MessageView(
        icon: Icons.favorite_border,
        text: 'Belum ada game favorit.\nTekan ikon hati pada sebuah game.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final game = favorites[index];
        return GameTile(
          game: game,
          onTap: () => onTapGame(game),
          trailing: FavoriteButton(
            isFav: game.isFav,
            onPressed: () => onToggleFav(game),
          ),
        );
      },
    );
  }
}
