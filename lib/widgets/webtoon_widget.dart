import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toonflix/screens/webtoon_detail_screen.dart';

class WebtoonThumb extends StatelessWidget {
  final String title, thumbUrl;
  final int id;

  const WebtoonThumb({super.key, required this.id, required this.title, required this.thumbUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => WebtoonDetailScreen(id: id, title: title, thumbUrl: thumbUrl)));
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
                width: 200,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
                  BoxShadow(blurRadius: 10, offset: const Offset(10, 10), color: Colors.black.withOpacity(0.7))
                ]),
                child: Image.network(
                  thumbUrl,
                  headers: const {
                    'User-Agent':
                        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                    'Referer': 'https://comic.naver.com',
                  },
                  errorBuilder: (context, exception, stackTrace) {
                    print("Exception >> ${exception.toString()}");
                    return Text("error");
                  },
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style:
                TextStyle(fontFamily: GoogleFonts.notoSansGothic.toString(), fontSize: 15, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
