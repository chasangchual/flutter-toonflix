import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  final WebtoonEpisode episode;

  const Episode({super.key, required this.episode});

  void openWebToon({required int webtoonId, required int episodeId}) async {
    var url =
        Uri.parse('https://comic.naver.com/webtoon/detail?titleId=${webtoonId.toString()}&no=${episodeId.toString()}');
    print(url.toString());
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openWebToon(webtoonId: episode.webtoonId, episodeId: episode.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.purple.shade400),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '${episode.title} [ ${episode.date} ]',
              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
            ),
          ]),
        ),
      ),
    );
  }
}
