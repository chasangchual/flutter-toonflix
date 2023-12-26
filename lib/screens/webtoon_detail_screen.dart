import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../services/api_service.dart';
import '../widgets/episode_widget.dart';

class WebtoonDetailScreen extends StatefulWidget {
  final String title, thumbUrl;
  final int id;
  const WebtoonDetailScreen({super.key, required this.id, required this.title, required this.thumbUrl});

  @override
  State<WebtoonDetailScreen> createState() => _WebtoonDetailScreenState();
}

class _WebtoonDetailScreenState extends State<WebtoonDetailScreen> {
  late Future<WebtoonDetail> webtoonDetail;
  late Future<List<WebtoonEpisode>> episodes;
  late SharedPreferences prefs;
  bool isFavorite = false;

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? liked = prefs.getStringList('liked');
    if (liked != null) {
      isFavorite = liked.contains(widget.id.toString());
      setState(() {});
    } else {
      await prefs.setStringList('liked', []);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webtoonDetail = WebtoonApiService().getDetailById(widget.id);
    episodes = WebtoonApiService().getEpisodesById(widget.id);

    initPref();
  }

  void appBarIconPressed() async {
    isFavorite = !isFavorite;

    List<String> liked = await prefs.getStringList('liked')!;
    if (isFavorite) {
      liked.add(widget.id.toString());
    } else {
      do {
        liked.remove(widget.id.toString());
      } while (liked.contains(widget.id.toString()));
    }
    await prefs.setStringList('liked', liked);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 24, fontFamily: GoogleFonts.openSans.toString(), fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 3,
        actions: [
          IconButton(
              onPressed: appBarIconPressed,
              icon: isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                        width: 200,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
                          BoxShadow(blurRadius: 10, offset: const Offset(10, 10), color: Colors.black.withOpacity(0.7))
                        ]),
                        child: Image.network(
                          widget.thumbUrl,
                          headers: const {
                            'User-Agent':
                                'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                            'Referer': 'https://comic.naver.com',
                          },
                          errorBuilder: (context, exception, stackTrace) {
                            print("Exception >> ${exception.toString()}");
                            return const Text("error");
                          },
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder(
                  future: webtoonDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: episodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [for (var episode in snapshot.data!) Episode(episode: episode)],
                      );
                    }
                    ;
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
