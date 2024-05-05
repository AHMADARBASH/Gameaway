import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_states.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/layout/screens/shared/image_preview_screen.dart';
import 'package:gameaway/layout/widgets/mini_platform.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:gameaway/utilities/widget_extenstion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

final Map<String, dynamic> _platforms = {
  "PC": {
    "name": "PC",
    "value": "pc",
    "logo": "assets/images/PC.png",
    "color": Colors.blue,
    "index": 1
  },
  "Steam": {
    "name": "Steam",
    "value": "steam",
    "logo": "assets/images/Steam.png",
    "color": const Color(0xff0A1B48),
    "index": 2
  },
  "DRM-Free": {
    "name": "DRM-Free",
    "value": "DRM-Free",
    "logo": "assets/images/DRM.png",
    "color": const Color(0xff0A1B48),
    "index": 2
  },
  "Epic Games Store": {
    "name": "Epic Games",
    "value": "epic-games-store",
    "logo": "assets/images/epic-games.png",
    "index": 3,
    "color": Colors.grey,
  },
  "ubisoft": {
    "name": "ubisoft",
    "value": "ubisoft",
    "logo": "assets/images/ubisoft.png",
    "color": const Color(0xff91AED8),
    "index": 4
  },
  "GOG": {
    "name": "gog",
    "value": "gog",
    "logo": "assets/images/gog.png",
    "index": 5,
  },
  "Itch.io": {
    "name": "itchio",
    "value": "itchio",
    "logo": "assets/images/itchio.png",
    "index": 6
  },
  "Playstation 4": {
    "name": "PS4",
    "value": "ps4",
    "logo": "assets/images/PS4.png",
    "color": const Color(0xff003791),
    "index": 7
  },
  "Playstation 5": {
    "name": "PS5",
    "value": "ps5",
    "logo": "assets/images/PS5.png",
    "color": const Color(0xff003791),
    "index": 8
  },
  "Xbox One": {
    "name": "Xbox one",
    "value": "xbox-one",
    "logo": "assets/images/XBOX-one.png",
    "color": const Color(0xff107C10),
    "index": 9
  },
  "Xbox Series X|S": {
    "name": "Xbox series xs",
    "value": "xbox-series-xs",
    "logo": "assets/images/Xbox_Series_X.png",
    "color": const Color(0xff107C10),
    "index": 10
  },
  "Xbox 360": {
    "name": "Xbox 360",
    "value": "Xbox 360",
    "logo": "assets/images/xbox360.png",
    "color": const Color(0xff107C10),
    "index": 10
  },
  "steam": {
    "name": "Xbox 360",
    "value": "xbox-360",
    "logo": "assets/images/xbox360.png",
    "color": const Color(0xff107C10),
    "index": 11
  },
  "Nintendo Switch": {
    "name": "Switch",
    "value": "switch",
    "logo": "assets/images/switch.png",
    "index": 12
  },
  "Android": {
    "name": "android",
    "value": "android",
    "logo": "assets/images/android.png",
    "color": const Color(0xff32DE84),
    "index": 13
  },
  "iOS": {
    "name": "IOS",
    "value": "ios",
    "logo": "assets/images/ios.png",
    "color": Colors.black,
    "index": 14
  },
  "VR": {
    "name": "VR",
    "value": "vr",
    "logo": "assets/images/vr.png",
    "index": 15,
  },
  "Battelnet": {
    "name": "Battelnet",
    "value": "battlenet",
    "logo": "assets/images/battelnet.png",
    "index": 16
  },
  "Origin": {
    "name": "Origin",
    "value": "origin",
    "logo": "assets/images/origin.png",
    "index": 17
  },
  "Ubisoft Connect": {
    "name": "ubisoft",
    "value": "ubisoft",
    "logo": "assets/images/ubisoft.png",
    "color": const Color(0xff91AED8),
    "index": 18
  }
};

class GiveawayDetailsScreen extends StatefulWidget {
  static const String routeName = '/GiveawayDetailsScreen';
  final Giveaway giveaway;

  const GiveawayDetailsScreen({super.key, required this.giveaway});

  @override
  State<GiveawayDetailsScreen> createState() => _GiveawayDetailsScreenState();
}

class _GiveawayDetailsScreenState extends State<GiveawayDetailsScreen> {
  late List<String> stringList;
  final duration = const Duration(milliseconds: 800);

  @override
  void initState() {
    stringList =
        widget.giveaway.platforms.split(", ").map((e) => e.trim()).toList();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey.withOpacity(0.2)));
    super.dispose();
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('coudn\'t open the URL');
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
                      'giveaway': widget.giveaway,
                      'freetoplay': null,
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.sp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),
                      child: Hero(
                        tag: widget.giveaway.id,
                        child: SizedBox(
                          height: 32.h,
                          width: context.width / 0.75,
                          child: Image(
                              image: CachedNetworkImageProvider(
                                widget.giveaway.image,
                              ),
                              fit: BoxFit.fitHeight),
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
                              widget.giveaway.title,
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
                      width: 30.sp,
                      height: 30.sp,
                      child: Icon(
                        widget.giveaway.type == "DLC"
                            ? Icons.extension
                            : FontAwesome.gamepad,
                        color: context.primaryColor,
                        size: 15.sp,
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
                      await _launchUrl(Uri.parse(widget.giveaway.openGiveaway));
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
                          'Claim now  ',
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
          child: SlideInUp(
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
                    height: 30.sp,
                  ),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 400),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: buildTitle('Description', context),
                  ),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 500),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: SizedBox(
                      height: 10.h,
                      child: SingleChildScrollView(
                          child:
                              buildText(widget.giveaway.description, context)),
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 600),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: buildTitle('Instructions', context),
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 700),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: SizedBox(
                      height: 10.h,
                      child: SingleChildScrollView(
                          child:
                              buildText(widget.giveaway.instructions, context)),
                    ),
                  ),
                  const Spacer(),
                  FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      duration: duration,
                      curve: Curves.easeOutQuart,
                      child: buildTitle('Platforms', context)),
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    duration: duration,
                    curve: Curves.easeOutQuart,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: SizedBox(
                        height: 25.sp,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: stringList.length,
                          itemBuilder: (context, index) => MiniPlatform(
                            logo: _platforms[stringList[index]]['logo'],
                            platformName:
                                ' ${_platforms[stringList[index]]['name']}',
                            logoColor: _platforms[stringList[index]]['color'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
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
                  'giveaway': widget.giveaway,
                  'freetoplay': null,
                });
              },
              child: FadeInUp(
                duration: duration,
                curve: Curves.easeOutQuart,
                child: Hero(
                  tag: widget.giveaway.id,
                  child: SizedBox(
                    height: 22.h,
                    width: double.infinity,
                    child: Image(
                      image: CachedNetworkImageProvider(
                        widget.giveaway.image,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 18.h,
                ),
                SlideInUp(
                  delay: const Duration(milliseconds: 100),
                  duration: duration,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: context.width,
                    decoration: BoxDecoration(
                      color: context.canvasColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp),
                      ),
                    ),
                    child: SizedBox(
                      height: context.height * 0.80,
                      width: context.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FadeIn(
                              duration: duration,
                              delay: duration,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: context.primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 6,
                                width: 15.w,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Expanded(
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FadeInUp(
                                                delay: const Duration(
                                                    milliseconds: 300),
                                                duration: duration,
                                                curve: Curves.easeOutQuart,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, left: 10),
                                                  child: SizedBox(
                                                    width: 60.w,
                                                    child: Text(
                                                      widget.giveaway.title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 20.sp),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              FadeInUp(
                                                delay: const Duration(
                                                    milliseconds: 200),
                                                duration: duration,
                                                curve: Curves.easeOutQuart,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.sp),
                                                    color: context.primaryColor
                                                        .withOpacity(0.2),
                                                    border: Border.all(
                                                      color:
                                                          context.primaryColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  width: 20.w,
                                                  height: 20.w,
                                                  child: Icon(
                                                    widget.giveaway.type ==
                                                            "DLC"
                                                        ? Icons.extension
                                                        : FontAwesome.gamepad,
                                                    color: context.primaryColor,
                                                    size: 30.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          SizedBox(
                                            width: context.width * 0.9,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FadeInLeft(
                                                  delay: const Duration(
                                                      milliseconds: 400),
                                                  duration: duration,
                                                  curve: Curves.easeOutQuart,
                                                  child: buildTitle(
                                                      'description', context),
                                                ),
                                                FadeInLeft(
                                                  delay: const Duration(
                                                      milliseconds: 500),
                                                  duration: duration,
                                                  curve: Curves.easeOutQuart,
                                                  child: SizedBox(
                                                    height: 10.h,
                                                    child: SingleChildScrollView(
                                                        child: buildText(
                                                            widget.giveaway
                                                                .description,
                                                            context)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          FadeInRight(
                                              delay: const Duration(
                                                  milliseconds: 600),
                                              duration: duration,
                                              curve: Curves.easeOutQuart,
                                              child: buildTitle(
                                                  'instructions', context)),
                                          FadeInRight(
                                            delay: const Duration(
                                                milliseconds: 700),
                                            duration: duration,
                                            curve: Curves.easeOutQuart,
                                            child: SizedBox(
                                              height: 10.h,
                                              child: SingleChildScrollView(
                                                  child: buildText(
                                                      widget.giveaway
                                                          .instructions,
                                                      context)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          FadeInUp(
                                            delay: duration,
                                            duration: duration,
                                            curve: Curves.easeOutQuart,
                                            child: buildTitle(
                                                'platforms', context),
                                          ),
                                          FadeInUp(
                                            delay: const Duration(
                                                milliseconds: 800),
                                            duration: duration,
                                            curve: Curves.easeOutQuart,
                                            child: SizedBox(
                                              height: 60,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: stringList.length,
                                                itemBuilder: (context, index) =>
                                                    MiniPlatform(
                                                  logo: _platforms[
                                                          stringList[index]]
                                                      ['logo'],
                                                  platformName:
                                                      ' ${_platforms[stringList[index]]['name']}',
                                                  logoColor: _platforms[
                                                          stringList[index]]
                                                      ['color'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      FadeInUp(
                                        delay:
                                            const Duration(milliseconds: 1000),
                                        duration: duration,
                                        curve: Curves.easeOutQuart,
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              await _launchUrl(Uri.parse(widget
                                                  .giveaway.openGiveaway));
                                            } catch (_) {
                                              toastification.show(
                                                  title: Text(
                                                    'unable to open URL',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 15.sp),
                                                  ),
                                                  showProgressBar: true,
                                                  type:
                                                      ToastificationType.error,
                                                  style: ToastificationStyle
                                                      .flatColored,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  animationDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  backgroundColor:
                                                      context.canvasColor,
                                                  autoCloseDuration:
                                                      const Duration(
                                                          seconds: 3),
                                                  foregroundColor: Colors.white,
                                                  applyBlurEffect: true);
                                            }
                                          },
                                          child: Container(
                                            width: context.width,
                                            height: 6.h,
                                            decoration: BoxDecoration(
                                              color: context.primaryColor
                                                  .withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(20.sp),
                                              border: Border.all(
                                                  color: context.primaryColor,
                                                  width: 1),
                                            ),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Claim now  ',
                                                  style: GoogleFonts.bebasNeue(
                                                    color: context.primaryColor,
                                                    fontSize: 20.sp,
                                                  ),
                                                ),
                                                Icon(
                                                  FontAwesome5
                                                      .external_link_alt,
                                                  color: context.primaryColor,
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
                color: context.secondaryColor,
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
            BlocBuilder<GiveawayFavoritesCubit, GiveawayFavoritesState>(
              builder: (context, state) => FadeInRight(
                delay: const Duration(milliseconds: 200),
                duration: duration,
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: context.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    state.ids.contains(widget.giveaway.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: context.primaryColor,
                  ),
                ).bounce(
                  onPressed: () {
                    state.ids.contains(widget.giveaway.id)
                        ? BlocProvider.of<GiveawayFavoritesCubit>(context)
                            .removeFavorite(id: widget.giveaway.id)
                        : BlocProvider.of<GiveawayFavoritesCubit>(context)
                            .addFavorite(giveaway: widget.giveaway);
                  },
                  duration: Duration(milliseconds: 100),
                ),
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
