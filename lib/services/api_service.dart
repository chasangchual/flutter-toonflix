import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../models/webtoon_models.dart';

class WebtoonApiService {
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = "today";
  final String episodes = "episodes";

  Future<List<Webtoon>> getTodayWebtoons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    List<Webtoon> webtoons = [];

    if (response.statusCode == 200) {
      List<dynamic> webtoonJsons = jsonDecode(response.body);

      for (var webtoonJson in webtoonJsons) {
        webtoons.add(Webtoon.fromJson(webtoonJson));
      }
      return webtoons;
    }

    throw Error();
  }

  Future<WebtoonDetail> getDetailById(int id) async {
    final url = Uri.parse('$baseUrl/${id.toString()}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return WebtoonDetail.fromJson(id, jsonDecode(response.body));
    }
    throw Error();
  }

  Future<List<WebtoonEpisode>> getEpisodesById(int id) async {
    final url = Uri.parse('$baseUrl/${id.toString()}/${episodes}');
    final response = await http.get(url);
    List<WebtoonEpisode> webtoonEpisodes = [];

    if (response.statusCode == 200) {
      List<dynamic> episodesJson = jsonDecode(response.body);

      for (var episodeJson in episodesJson) {
        webtoonEpisodes.add(WebtoonEpisode.fromJson(id, episodeJson));
      }
      return webtoonEpisodes;
    }

    throw Error();
  }
}
