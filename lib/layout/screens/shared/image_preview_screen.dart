import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/utilities/context_extenstions.dart';

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
            color: context.primaryColor,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Hero(
          tag: widget.freetoPlay == null
              ? widget.giveaway!.id
              : widget.freetoPlay!.id,
          child: SizedBox(
            width: context.width,
            height:
                context.isTablet ? context.height * 0.7 : context.height * 0.30,
            child: CachedNetworkImage(
              imageUrl: widget.giveaway == null
                  ? widget.freetoPlay!.thumbnail
                  : widget.giveaway!.thumbnail,
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
