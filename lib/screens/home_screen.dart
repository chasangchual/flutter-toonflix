import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toonflix/services/api_service.dart';

import '../models/webtoon_models.dart';
import '../widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<Webtoon>> webtoons = WebtoonApiService().getTodayWebtoons();

  @override
  Widget build(BuildContext context) {
    print(webtoons);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Today\'s WebToon',
          style: TextStyle(fontSize: 24, fontFamily: GoogleFonts.openSans.toString(), fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Expanded(child: buildWebtoonList(snapshot))
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView buildWebtoonList(AsyncSnapshot<List<Webtoon>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        var webtoon = snapshot.data![index];
        return WebtoonThumb(id: webtoon.id, title: webtoon.title, thumbUrl: webtoon.thumb);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 20,
        );
      },
    );
  }
}
