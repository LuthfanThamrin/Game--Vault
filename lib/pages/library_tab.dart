import 'package:flutter/material.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/widgets/game_square.dart';
import 'package:game_vault/widgets/message_view.dart';


class LibraryTab extends StatelessWidget {
  final List<Game> games;
  final void Function(Game game) onTapGame;
  final void Function(Game game) onRemove;

  const LibraryTab({
    super.key,
    required this.games,
    required this.onTapGame,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final library = games.where((g) => g.inLibrary).toList();

    if (library.isEmpty) {
      return const MessageView(
        icon: Icons.book_outlined,
        text: 'Library masih kosong.\nTambahkan dari halaman detail game.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: library.length,
      itemBuilder: (context, index) {
        final game = library[index];
        return GameSquare(
          game: game,
          onTap: () => onTapGame(game),
          trailing: Container(
            decoration: const BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              tooltip: 'Hapus dari library',
              onPressed: () => onRemove(game),
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.white70,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}