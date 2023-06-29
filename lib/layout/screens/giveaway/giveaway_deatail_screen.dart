import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_cubit.dart';
import 'package:gameaway/blocs/favorites/giveaway/giveaways_favorites_states.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/layout/screens/shared/image_preview_screen.dart';
import 'package:gameaway/layout/widgets/mini_platform.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
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

  final ftoast = FToast();
  @override
  void initState() {
    ftoast.init(context);
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
    ftoast.removeCustomToast();
    super.dispose();
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('coudn\'t open the URL');
    }
  }

  Widget buildTitle(String text) => Text(
        text,
        style: GoogleFonts.bebasNeue(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      );
  Widget buildText(String text) => Text(
        text,
        style: GoogleFonts.bebasNeue(fontSize: 15.sp),
      );

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
          BlocBuilder<GiveawayFavoritesCubit, GiveawayFavoritesState>(
            builder: (context, state) => FadeInRight(
              delay: const Duration(milliseconds: 200),
              duration: duration,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    state.ids.contains(widget.giveaway.id)
                        ? BlocProvider.of<GiveawayFavoritesCubit>(context)
                            .removeFavorite(id: widget.giveaway.id)
                        : BlocProvider.of<GiveawayFavoritesCubit>(context)
                            .addFavorite(giveaway: widget.giveaway);
                  },
                  icon: Icon(
                    state.ids.contains(widget.giveaway.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.blue,
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
                      height: 25.h,
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
                  SizedBox(
                    height: 22.h,
                  ),
                  SlideInUp(
                    delay: const Duration(milliseconds: 100),
                    duration: duration,
                    child: Container(
                      alignment: Alignment.topCenter,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeIn(
                                duration: duration,
                                delay: duration,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                                  child: ListView(
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
                                                            10),
                                                    color: Colors.blue
                                                        .withOpacity(0.2),
                                                    border: Border.all(
                                                      color: Colors.blue[600]!,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  width: 20.w,
                                                  height: 11.h,
                                                  child: Icon(
                                                    widget.giveaway.type ==
                                                            "DLC"
                                                        ? Icons.extension
                                                        : FontAwesome.gamepad,
                                                    color: Colors.blue[600],
                                                    size: 30.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          FadeInLeft(
                                            delay: const Duration(
                                                milliseconds: 400),
                                            duration: duration,
                                            curve: Curves.easeOutQuart,
                                            child: buildTitle('description'),
                                          ),
                                          FadeInLeft(
                                            delay: const Duration(
                                                milliseconds: 500),
                                            duration: duration,
                                            curve: Curves.easeOutQuart,
                                            child: SizedBox(
                                              height: 10.h,
                                              child: SingleChildScrollView(
                                                  child: buildText(widget
                                                      .giveaway.description)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          FadeInRight(
                                              delay: const Duration(
                                                  milliseconds: 600),
                                              duration: duration,
                                              curve: Curves.easeOutQuart,
                                              child:
                                                  buildTitle('instructions')),
                                          FadeInRight(
                                            delay: const Duration(
                                                milliseconds: 700),
                                            duration: duration,
                                            curve: Curves.easeOutQuart,
                                            child: SizedBox(
                                              height: 10.h,
                                              child: SingleChildScrollView(
                                                  child: buildText(
                                                widget.giveaway.instructions,
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          FadeInUp(
                                            delay: duration,
                                            duration: duration,
                                            curve: Curves.easeOutQuart,
                                            child: buildTitle('platforms'),
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
                                          FadeInUp(
                                            delay: const Duration(
                                                milliseconds: 1000),
                                            duration: duration,
                                            curve: Curves.easeOutQuart,
                                            child: InkWell(
                                              onTap: () async {
                                                try {
                                                  await _launchUrl(Uri.parse(
                                                      widget.giveaway
                                                          .openGiveaway));
                                                } catch (_) {
                                                  ftoast.showToast(
                                                      toastDuration:
                                                          const Duration(
                                                              seconds: 2),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20,
                                                                vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'unable to open URL',
                                                              style: GoogleFonts
                                                                  .bebasNeue(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                        color:
                                                            Colors.blue[600]!,
                                                        width: 1)),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Claim now  ',
                                                      style:
                                                          GoogleFonts.bebasNeue(
                                                        color: Colors.blue[600],
                                                        fontSize: 20.sp,
                                                      ),
                                                    ),
                                                    Icon(
                                                      FontAwesome5
                                                          .external_link_alt,
                                                      color: Colors.blue[600],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
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
      ),
    );
  }
}