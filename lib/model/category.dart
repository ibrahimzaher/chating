class Category {
  static const String sports = 'sports';
  static const String movies = 'movies';
  static const String musics = 'musics';
  String id;
  late String title;
  late String image;
  Category({required this.id, required this.title, required this.image});
  Category.fromId(this.id) {
    if (id == sports) {
      title = 'Sports';
      image = 'assets/images/sports.jpg';
    } else if (id == musics) {
      title = 'Musics';
      image = 'assets/images/musics.jpg';
    } else {
      title = 'Movies';
      image = 'assets/images/movies.png';
    }
  }
  static List<Category> getCategories() {
    return [
      Category.fromId(movies),
      Category.fromId(sports),
      Category.fromId(musics),
    ];
  }
}
