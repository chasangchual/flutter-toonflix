class WebtoonDetail {
  final int id;
  final String title;
  final String about;
  final String genre;
  final String age;
  final String thumb;

  WebtoonDetail.fromJson(this.id, Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'],
        thumb = json['thumb'];
}
