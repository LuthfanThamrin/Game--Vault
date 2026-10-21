import 'package:flutter/material.dart';
import 'package:game_vault/constants.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/widgets/favorite_button.dart';
import 'package:game_vault/widgets/game_box.dart';
import 'package:game_vault/widgets/game_tile.dart';
import 'package:game_vault/widgets/section_title.dart';


class HomeTab extends StatefulWidget {
  final List<Game> games;
  final void Function(Game game) onTapGame;
  final void Function(Game game) onToggleFav;

  const HomeTab({
    super.key,
    required this.games,
    required this.onTapGame,
    required this.onToggleFav,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.games
        .where((g) => g.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    final library = widget.games.where((g) => g.inLibrary).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          onChanged: (value) => setState(() => _query = value),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search games...',
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: kDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SectionTitle('MY LIBRARY'),
        const SizedBox(height: 10),
        if (library.isEmpty)
          const Text(
            'Belum ada game di library.',
            style: TextStyle(color: Colors.grey),
          )
        else
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: library.length,
              itemBuilder: (context, index) {
                final game = library[index];
                return GameBox(game: game, onTap: () => widget.onTapGame(game));
              },
            ),
          ),
        const SizedBox(height: 24),
        const SectionTitle('DISCOVER'),
        const SizedBox(height: 12),
        if (filtered.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: Text(
                'Game tidak ditemukan',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ...filtered.map(
          (game) => GameTile(
            game: game,
            onTap: () => widget.onTapGame(game),
            trailing: FavoriteButton(
              isFav: game.isFav,
              onPressed: () => widget.onToggleFav(game),
            ),
          ),
        ),
      ],
    );
  }
}