import 'package:flutter/material.dart';
import 'package:game_vault/constants.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/model/review.dart';
import 'package:game_vault/service/game_service.dart';
import 'package:game_vault/widgets/favorite_button.dart';
import 'package:game_vault/widgets/game_image.dart';
import 'package:game_vault/widgets/review_card.dart';


class DetailPage extends StatefulWidget {
  final Game game; 

  const DetailPage({super.key, required this.game});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _commentController = TextEditingController();
  List<Review> _reviews = [];
  bool _loadingReviews = true;
  String? _reviewError;
  bool _sending = false;
  int _myRating = 5;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  
  Future<void> _loadReviews() async {
    try {
      final data = await GameService.fetchReviews(widget.game.id);
      if (!mounted) return;
      setState(() {
        _reviews = data;
        _loadingReviews = false;
        _reviewError = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _reviewError = e.toString();
        _loadingReviews = false;
      });
    }
  }

  Future<void> _sendReview() async {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review tidak boleh kosong')),
      );
      return;
    }

    setState(() => _sending = true);

    bool success;
    try {
      await GameService.addReview(
        Review(
          gameId: widget.game.id,
          user:  'kamu',
          rating: _myRating,
          comment: comment,
        ),
      );
      await _loadReviews(); 
      success = true;
    } catch (e) {
      success = false;
    }

    if (!mounted) return;
    if (success) _commentController.clear();
    setState(() => _sending = false);
    final message = success ? 'Review terkirim!' : 'Gagal mengirim review';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  
  void _toggleLibrary() {
    final game = widget.game;
    setState(() {
      game.inLibrary = !game.inLibrary;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          game.inLibrary ? 'Ditambahkan ke library' : 'Dihapus dari library',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        actions: [
          FavoriteButton(
            isFav: game.isFav,
            onPressed: () {
              setState(() {
                game.isFav = !game.isFav;
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        children: [
          
          SizedBox(
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                GameImage(
                  path: game.banner,
                  fallbackColor: game.color,
                  radius: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      game.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(game.genre, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            '⭐ ${game.rating}',
            style: const TextStyle(color: Colors.amber, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Text(game.description, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 16),

          
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: game.inLibrary ? Colors.red : kAccent,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: _toggleLibrary,
            icon: Icon(game.inLibrary ? Icons.delete : Icons.add),
            label: Text(
              game.inLibrary ? 'Hapus dari Library' : 'Tambah ke Library',
            ),
          ),
          const SizedBox(height: 24),

          
          const Text(
            'BERI RATING & REVIEW',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              final star = index + 1;
              return IconButton(
                onPressed: () => setState(() => _myRating = star),
                icon: Icon(
                  star <= _myRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              );
            }),
          ),
          TextField(
            controller: _commentController,
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Tulis review...',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: kDark,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _sending ? null : _sendReview,
              child: _sending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Kirim'),
            ),
          ),
          const SizedBox(height: 24),

        
          const Text('REVIEW KOMUNITAS', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          _buildReviews(),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    if (_loadingReviews) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_reviewError != null) {
      return Text(
        'Gagal memuat review: $_reviewError',
        style: const TextStyle(color: Colors.grey),
      );
    }
    if (_reviews.isEmpty) {
      return const Text(
        'Belum ada review.',
        style: TextStyle(color: Colors.grey),
      );
    }
    return Column(
      children: _reviews.map((review) => ReviewCard(review: review)).toList(),
    );
  }
}
