import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/freetoplay/freetoplay_favorites_states.dart';
import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/layout/screens/shared/image_preview_screen.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:gameaway/utilities/widget_extenstion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    super.dispose();
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('couldn\'t open the URL');
    }
  }

  void openFreeToPlay() async {
    try {
      await _launchUrl(Uri.parse(widget.freetoPlay.gameUrl));
    } catch (_) {
      toastification.show(
          title: Text(
            'unable to open URL',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 15.sp),
          ),
          showProgressBar: true,
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          alignment: Alignment.bottomCenter,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: context.canvasColor,
          autoCloseDuration: const Duration(seconds: 3),
          foregroundColor: Colors.white,
          applyBlurEffect: true);
    }
  }

  Widget buildTitle(String text, BuildContext context) => Text(
        text,
        style: GoogleFonts.bebasNeue(
          fontSize: context.isTablet ? 15.sp : 20.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  Widget buildText(String text, BuildContext context) => Text(
        text,
        style: GoogleFonts.bebasNeue(fontSize: 13.sp),
      );
  Widget landscapeUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: context.height > 800 ? 1 : 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInLeft(
                curve: Curves.easeOutQuart,
                delay: const Duration(milliseconds: 100),
                duration: duration,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ImagePreviewScreen.routeName, arguments: {
                      'giveaway': null,
                      'freetoplay': widget.freetoPlay,
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.sp),
                      child: Hero(
                        tag: widget.freetoPlay.id,
                        child: SizedBox(
                          height: 32.h,
                          child: Image(
                              image: CachedNetworkImageProvider(
                                widget.freetoPlay.thumbnail,
                              ),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInLeft(
                    delay: const Duration(milliseconds: 400),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: context.width / 3,
                            child: Text(
                              widget.freetoPlay.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 15.sp),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.sp),
                        color: context.primaryColor.withOpacity(0.2),
                        border: Border.all(
                          color: context.primaryColor,
                          width: 1,
                        ),
                      ),
                      width: 35.sp,
                      height: 35.sp,
                      child: Icon(
                        FontAwesome.gamepad,
                        color: context.primaryColor,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FadeInRight(
                delay: const Duration(milliseconds: 500),
                duration: duration,
                curve: Curves.easeOutQuart,
                child: InkWell(
                  onTap: () async {
                    try {
                      await _launchUrl(Uri.parse(widget.freetoPlay.gameUrl));
                    } catch (_) {
                      toastification.show(
                          title: Text(
                            'unable to open URL',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 15.sp),
                          ),
                          showProgressBar: true,
                          type: ToastificationType.error,
                          style: ToastificationStyle.flatColored,
                          alignment: Alignment.bottomCenter,
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: context.canvasColor,
                          autoCloseDuration: const Duration(seconds: 3),
                          foregroundColor: Colors.white,
                          applyBlurEffect: true);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.sp),
                    width: context.width,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.sp),
                      border: Border.all(color: context.primaryColor, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Game URL  ',
                          style: GoogleFonts.bebasNeue(
                            color: context.primaryColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        Icon(
                          FontAwesome5.external_link_alt,
                          color: context.primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),
        Expanded(
          child: FadeInUp(
            delay: const Duration(milliseconds: 100),
            duration: duration,
            curve: Curves.easeOutQuart,
            child: Container(
              decoration: BoxDecoration(
                  color: context.canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.sp),
                      topRight: Radius.circular(10.sp))),
              padding: EdgeInsets.all(4.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: context.primaryColor,
                            borderRadius: BorderRadius.circular(10.sp)),
                        width: 50.sp,
                        height: 3.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 200),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: buildTitle('Description', context),
                  ),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 300),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: SizedBox(
                      height: 5.h,
                      child: SingleChildScrollView(
                          child: buildText(
                              widget.freetoPlay.shortDescription, context)),
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 400),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: buildTitle('Publisher', context),
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 500),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: SizedBox(
                      height: 5.h,
                      child: SingleChildScrollView(
                          child:
                              buildText(widget.freetoPlay.publisher, context)),
                    ),
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 600),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: buildTitle('Developer', context),
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 700),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: SizedBox(
                      height: 5.h,
                      child: SingleChildScrollView(
                          child:
                              buildText(widget.freetoPlay.developer, context)),
                    ),
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 800),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: buildTitle('Release Date', context),
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 900),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: SizedBox(
                      height: 10.h,
                      child: SingleChildScrollView(
                        child:
                            buildText(widget.freetoPlay.releaseDate, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget portraitUI() {
    return Column(
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
                                      color: context.primaryColor,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      color:
                                          context.primaryColor.withOpacity(0.2),
                                      border: Border.all(
                                        color: context.primaryColor[600]!,
                                        width: 1,
                                      ),
                                    ),
                                    width: 20.w,
                                    height: 11.h,
                                    child: Icon(
                                      FontAwesome.gamepad,
                                      color: context.primaryColor[600],
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
                              child: buildTitle('description', context),
                            ),
                            FadeInLeft(
                              delay: const Duration(milliseconds: 500),
                              duration: duration,
                              curve: Curves.easeOutQuart,
                              child: SizedBox(
                                child: SingleChildScrollView(
                                  child: buildText(
                                      widget.freetoPlay.shortDescription,
                                      context),
                                ),
                              ),
                            ),
                            const Spacer(),
                            FadeInRight(
                                delay: const Duration(milliseconds: 600),
                                duration: duration,
                                curve: Curves.easeOutQuart,
                                child: buildTitle('publisher', context)),
                            FadeInRight(
                              delay: const Duration(milliseconds: 700),
                              duration: duration,
                              curve: Curves.easeOutQuart,
                              child: SizedBox(
                                child: SingleChildScrollView(
                                  child: buildText(
                                      widget.freetoPlay.publisher, context),
                                ),
                              ),
                            ),
                            const Spacer(),
                            FadeInLeft(
                              delay: const Duration(milliseconds: 800),
                              duration: duration,
                              curve: Curves.easeOutQuart,
                              child: buildTitle('developer', context),
                            ),
                            FadeInLeft(
                              delay: const Duration(milliseconds: 900),
                              duration: duration,
                              curve: Curves.easeOutQuart,
                              child: SizedBox(
                                child: SingleChildScrollView(
                                  child: buildText(
                                      widget.freetoPlay.developer, context),
                                ),
                              ),
                            ),
                            const Spacer(),
                            FadeInRight(
                              delay: const Duration(milliseconds: 900),
                              duration: duration,
                              curve: Curves.easeOutQuart,
                              child: buildTitle('release date', context),
                            ),
                            FadeInRight(
                              delay: const Duration(milliseconds: 1000),
                              duration: duration,
                              curve: Curves.easeOutQuart,
                              child: SizedBox(
                                child: SingleChildScrollView(
                                    child: buildText(
                                        widget.freetoPlay.releaseDate,
                                        context)),
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
                                      color:
                                          context.primaryColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: context.primaryColor[600]!,
                                          width: 1)),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Game URL  ',
                                        style: GoogleFonts.bebasNeue(
                                          color: context.primaryColor[600],
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      Icon(
                                        FontAwesome5.external_link_alt,
                                        color: context.primaryColor[600],
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
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: context.primaryColor,
                ),
              ),
            ),
          ),
          actions: [
            BlocBuilder<FreetoPlayFavoritesCubit, FreetoPlayFavoritesState>(
              builder: (context, state) => FadeInRight(
                delay: const Duration(milliseconds: 200),
                duration: duration,
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    state.ids.contains(widget.freetoPlay.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ).bounce(
                    onPressed: () {
                      state.ids.contains(widget.freetoPlay.id)
                          ? BlocProvider.of<FreetoPlayFavoritesCubit>(context)
                              .removeFavorite(id: widget.freetoPlay.id)
                          : BlocProvider.of<FreetoPlayFavoritesCubit>(context)
                              .addFavorite(freetoplay: widget.freetoPlay);
                    },
                    duration: Duration(milliseconds: 100)),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: context.isTablet ? landscapeUI() : portraitUI());
  }
}
