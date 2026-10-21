import 'package:flutter/material.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/model/review.dart';


class GameService {
  static bool failFirstLoad = false;

  static final List<Game> _games = [
    Game(
      id: 1,
      title: 'Grand Theft Auto V',
      genre: 'Action • Open World',
      rating: 4.5,
      description: 'Ketika seorang penipu jalanan muda, mantan perampok bank profesional, dan seorang psikopat menakutkan terseret ke dalam dunia bawah tanah kriminal, pemerintah AS, serta industri hiburan, mereka harus melancarkan serangkaian perampokan nekat untuk bertahan hidup di kota Los Santos yang tidak percaya pada siapa pun.',
      color: Colors.green,
      image: 'assets/picture/GTA V 1.jpg',
      banner: 'assets/picture/GTA V 2.jpg',
    ),
    Game(
      id: 2,
      title: 'Red Dead Redemption 2',
      genre: 'Adventure',
      rating: 4.9,
      description: 'Amerika, 1899. Akhir dari era Wild West telah dimulai. Setelah perampokan di kota Blackwater berakhir kacau, Arthur Morgan dan geng Van der Linde terpaksa melarikan diri. Dengan agen federal dan pemburu hadiah terbaik terus mengejar, mereka harus merampok, mencuri, dan bertarung melintasi wilayah Amerika yang keras demi bertahan hidup.',
      color: Colors.red,
      image: 'assets/picture/RDR 1.jpg',
      banner: 'assets/picture/RDR 2.jpg',
    ),
    Game(
      id: 3,
      title: 'Elden Ring',
      genre: 'Souls-like • RPG',
      rating: 4.8,
      description: 'Bangkitlah, wahai Tarnished, dan biarkan petunjuk cahaya menuntunmu untuk menguasai kekuatan Elden Ring dan menjadi Elden Lord di Lands Between. Jelajahi dunia luas yang penuh bahaya serta ruang bawah tanah raksasa demi mengalahkan para demigod pemegang pecahan Elden Ring.',
      color: Colors.orange,
      image: 'assets/picture/Elden ring 1.jpg',
      banner: 'assets/picture/Elden Ring 2 .jpg',
    ),
    Game(
      id: 4,
      title: 'Cyberpunk 2077',
      genre: 'RPG • Futuristic',
      rating: 4.2,
      description: 'Sebuah RPG aksi petualangan open-world yang berlatar di Night City, megacity yang terobsesi dengan kekuasaan, glamor, dan modifikasi tubuh. Kamu bermain sebagai V, seorang tentara bayaran cyber-enhanced yang berburu implan langka pencapai keabadian.',
      color: Colors.purple,
      image: 'assets/picture/CP 2077 1.jpg',
      banner: 'assets/picture/CP 2077 2.jpg',
    ),
  ];

  static final List<Review> _reviews = [
    const Review(
        gameId: 1, user: 'andi', rating: 5, comment: 'Mode online-nya seru!'),
    const Review(
        gameId: 2, user: 'sari', rating: 5, comment: 'Ceritanya juara.'),
    const Review(
        gameId: 3, user: 'budi', rating: 4, comment: 'Sulit tapi memuaskan.'),
    const Review(
        gameId: 3, user: 'rina', rating: 5, comment: 'Game of the year.'),
  ];

  
  static Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return password == '1234';
  }

  
  static Future<List<Game>> fetchGames() async {
    await Future.delayed(const Duration(seconds: 2));
    if (failFirstLoad) {
      failFirstLoad = false;
      throw Exception('Server tidak merespons');
    }
    return List<Game>.from(_games);
  }

  
  static Future<List<Review>> fetchReviews(int gameId) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return _reviews.where((r) => r.gameId == gameId).toList();
  }

  
  static Future<void> addReview(Review review) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _reviews.insert(0, review); // review terbaru di paling atas
  }
}
