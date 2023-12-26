class WebtoonEpisode {
  final int webtoonId;
  final int id;
  final String title;
  final String rating;
  final String date;
  final String thumb;

  WebtoonEpisode.fromJson(this.webtoonId, Map<String, dynamic> json)
      : id = int.parse(json['id']),
        title = json['title'],
        rating = json['rating'],
        date = json['date'],
        thumb = json['thumb'];
}
