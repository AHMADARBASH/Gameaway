import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_states.dart';
import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/layout/screens/shared/image_preview_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class FreetoPlayDetailsScreen extends StatefulWidget {
  static const String routeName = '/FreetoPlayDetailsScreen';
  final FreetoPlay freetoPlay;

  const FreetoPlayDetailsScreen({super.key, required this.freetoPlay});

  @override
  State<FreetoPlayDetailsScreen> createState() =>
      _FreetoPlayDetailsScreenState();
}

class _FreetoPlayDetailsScreenState extends State<FreetoPlayDetailsScreen> {
  final duration = const Duration(milliseconds: 800);

  final ftoast = FToast();
  @override
  void initState() {
    ftoast.init(context);

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    ftoast.removeCustomToast();
    super.dispose();
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('coudn\'t open the URL');
    }
  }

  void openFreeToPlay() async {
    try {
      await _launchUrl(Uri.parse(widget.freetoPlay.gameUrl));
    } catch (_) {
      ftoast.showToast(
          toastDuration: const Duration(seconds: 2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'unable to open URL',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 15.sp, color: Colors.white),
                ),
              ],
            ),
          ));
    }
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.bebasNeue(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.bebasNeue(fontSize: 15.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        leading: FadeInLeft(
          delay: const Duration(milliseconds: 200),
          duration: duration,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: IconButton(
              padding: const EdgeInsets.only(left: 7),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        actions: [
          BlocConsumer<FreetoPlayFavoritesCubit, FreetoPlayFavoritesState>(
            listener: (context, state) {},
            builder: (context, state) => FadeInRight(
              delay: const Duration(milliseconds: 200),
              duration: duration,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    state.ids.contains(widget.freetoPlay.id)
                        ? BlocProvider.of<FreetoPlayFavoritesCubit>(context)
                            .removeFavorite(id: widget.freetoPlay.id)
                        : BlocProvider.of<FreetoPlayFavoritesCubit>(context)
                            .addFavorite(freetoplay: widget.freetoPlay);
                  },
                  icon: Icon(
                    state.ids.contains(widget.freetoPlay.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ImagePreviewScreen.routeName, arguments: {
                    'giveaway': null,
                    'freetoplay': widget.freetoPlay,
                  });
                },
                child: FadeInUp(
                  duration: duration,
                  curve: Curves.easeOutQuart,
                  child: Hero(
                    tag: widget.freetoPlay.id,
                    child: SizedBox(
                      height: 25.h,
                      width: double.infinity,
                      child: Image(
                        image: CachedNetworkImageProvider(
                          widget.freetoPlay.thumbnail,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 22.h,
                  ),
                  SlideInUp(
                    delay: const Duration(milliseconds: 100),
                    duration: duration,
                    child: Container(
                      height: 78.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SizedBox(
                        width: 100.w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: FadeIn(
                                  delay: const Duration(milliseconds: 400),
                                  duration: const Duration(milliseconds: 400),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5)),
                                    width: 15.w,
                                    height: 6,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 300),
                                    duration: duration,
                                    curve: Curves.easeOutQuart,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      child: SizedBox(
                                        width: 60.w,
                                        child: Text(
                                          widget.freetoPlay.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontSize: 20.sp),
                                          maxLines: 3,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ),
                                  ),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 200),
                                    duration: duration,
                                    curve: Curves.easeOutQuart,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue.withOpacity(0.2),
                                        border: Border.all(
                                          color: Colors.blue[600]!,
                                          width: 1,
                                        ),
                                      ),
                                      width: 20.w,
                                      height: 11.h,
                                      child: Icon(
                                        FontAwesome.gamepad,
                                        color: Colors.blue[600],
                                        size: 30.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              FadeInLeft(
                                delay: const Duration(milliseconds: 400),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: buildTitle('description'),
                              ),
                              FadeInLeft(
                                delay: const Duration(milliseconds: 500),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: SizedBox(
                                  child: SingleChildScrollView(
                                    child: buildText(
                                        widget.freetoPlay.shortDescription),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FadeInRight(
                                  delay: const Duration(milliseconds: 600),
                                  duration: duration,
                                  curve: Curves.easeOutQuart,
                                  child: buildTitle('publisher')),
                              FadeInRight(
                                delay: const Duration(milliseconds: 700),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: SizedBox(
                                  child: SingleChildScrollView(
                                    child:
                                        buildText(widget.freetoPlay.publisher),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FadeInLeft(
                                delay: const Duration(milliseconds: 800),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: buildTitle('developer'),
                              ),
                              FadeInLeft(
                                delay: const Duration(milliseconds: 900),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: SizedBox(
                                  child: SingleChildScrollView(
                                    child:
                                        buildText(widget.freetoPlay.developer),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FadeInRight(
                                delay: const Duration(milliseconds: 900),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: buildTitle('release date'),
                              ),
                              FadeInRight(
                                delay: const Duration(milliseconds: 1000),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: SizedBox(
                                  child: SingleChildScrollView(
                                      child: buildText(
                                    widget.freetoPlay.releaseDate,
                                  )),
                                ),
                              ),
                              const Spacer(),
                              FadeInUp(
                                delay: const Duration(milliseconds: 1100),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: InkWell(
                                  onTap: openFreeToPlay,
                                  child: Container(
                                    width: double.infinity,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: Colors.blue[600]!,
                                            width: 1)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Game URL  ',
                                          style: GoogleFonts.bebasNeue(
                                            color: Colors.blue[600],
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        Icon(
                                          FontAwesome5.external_link_alt,
                                          color: Colors.blue[600],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
