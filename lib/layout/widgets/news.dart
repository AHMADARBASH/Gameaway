import 'package:flutter/material.dart';
import 'package:gameaway/data/Models/news.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsWidget extends StatefulWidget {
  final double width;
  final News news;
  const NewsWidget({
    super.key,
    required this.width,
    required this.news,
  });

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('coudn\'t open the URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    final boxShadow = BoxShadow(
      color: Theme.of(context).shadowColor,
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(1, 1),
    );
    return InkWell(
      onTap: () {
        _launchUrl(Uri.parse(widget.news.articleUrl));
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            width: widget.width,
            height: 30.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow],
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.news.mainImage,
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            alignment: Alignment.topLeft,
          ),
          Container(
            height: 12.h,
            width: widget.width * 0.95,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [boxShadow]),
                  child: Text(
                    widget.news.title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 15.sp,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
