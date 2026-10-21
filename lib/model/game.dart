import 'package:flutter/material.dart';

class Game {
  final int id;
  final String title;
  final String genre;
  final double rating;
  final String description;
  final Color color;
  final String? image;
  final String? banner;
  bool isFav;
  bool inLibrary;

  Game({
    required this.id,
    required this.title,
    required this.genre,
    required this.rating,
    required this.description,
    required this.color,
    this.image,
    this.banner,
    this.isFav = false,
    this.inLibrary = false,
  });
}
