import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/layout/screens/freetoplay/freetoplay_details_screen.dart';
import 'package:gameaway/layout/screens/freetoplay/more_freetoplay_screen.dart';
import 'package:gameaway/layout/screens/giveaway/giveaway_deatail_screen.dart';
import 'package:gameaway/layout/screens/shared/home_screen.dart';
import 'package:gameaway/layout/screens/shared/image_preview_screen.dart';
import 'package:gameaway/layout/screens/giveaway/more_dlcs_screen.dart';
import 'package:gameaway/layout/screens/giveaway/more_giveaways_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class RouteGenerator {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case MoreGiveawaysScreen.routeName:
        Map<String, dynamic> routeData =
            settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MoreGiveawaysScreen(platform: routeData['platform']),
        );
      case MoreDLCsScreen.routeName:
        Map<String, dynamic> routeData =
            settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MoreDLCsScreen(platform: routeData['platform']),
        );
      case GiveawayDetailsScreen.routeName:
        Giveaway routeData = settings.arguments! as Giveaway;
        return MaterialPageRoute(
          builder: (_) => GiveawayDetailsScreen(giveaway: routeData),
        );
      case FreetoPlayDetailsScreen.routeName:
        FreetoPlay routeData = settings.arguments! as FreetoPlay;
        return MaterialPageRoute(
          builder: (_) => FreetoPlayDetailsScreen(freetoPlay: routeData),
        );
      case MoreFreetoPlayScreen.routeName:
        String routeData = settings.arguments! as String;
        return MaterialPageRoute(
          builder: (_) => MoreFreetoPlayScreen(genre: routeData),
        );
      case ImagePreviewScreen.routeName:
        Map<String, dynamic> routeData =
            settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ImagePreviewScreen(
            giveaway: routeData['giveaway'],
            freetoPlay: routeData['freetoplay'],
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return ColorfulSafeArea(
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Error Route',
                style:
                    GoogleFonts.bebasNeue(color: Colors.black, fontSize: 20.sp),
              )),
          body: const Center(child: Text('Error Route')),
        ),
      );
    });
  }
}
