import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/Models/giveaway.dart';

class ImagePreviewScreen extends StatefulWidget {
  static const String routeName = '/ImagePreviewScreen';
  final Giveaway? giveaway;
  final FreetoPlay? freetoPlay;
  const ImagePreviewScreen(
      {required this.giveaway, required this.freetoPlay, super.key});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 7),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: widget.freetoPlay == null
              ? widget.giveaway!.id
              : widget.freetoPlay!.id,
          child: SizedBox(
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.giveaway == null
                  ? widget.freetoPlay!.thumbnail
                  : widget.giveaway!.thumbnail,
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
