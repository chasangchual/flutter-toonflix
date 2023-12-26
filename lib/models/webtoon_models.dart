class Webtoon {
  final int id;
  final String title;
  final String thumb;

  Webtoon.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        title = json['title'],
        thumb = json['thumb'];
}
