class Review {
  final int gameId;
  final String user;
  final int rating; 
  final String comment;

  const Review({
    required this.gameId,
    required this.user,
    required this.rating,
    required this.comment,
  });
}
