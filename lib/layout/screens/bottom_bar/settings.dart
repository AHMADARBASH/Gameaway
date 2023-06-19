import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/theme/theme_cubit.dart';
import 'package:gameaway/blocs/theme/theme_state.dart';
import 'package:gameaway/data/helpers/local_data.dart';
import 'package:gameaway/utilities/themes.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = LocalData.getData(key: 'theme') == 'darkTheme';
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: Theme.of(context),
      duration: const Duration(milliseconds: 300),
      child: ThemeSwitchingArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20.sp),
            ),
          ),
          body: Column(
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) => ListTile(
                  leading: Icon(
                    Icons.nightlight_round_sharp,
                    size: 20.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "Dark Theme",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15.sp),
                  ),
                  trailing: ThemeSwitcher(
                    builder: (context) => Switch(
                      onChanged: (value) {
                        if (value == true) {
                          ThemeSwitcher.of(context)
                              .changeTheme(theme: themes['darkTheme']);
                          BlocProvider.of<ThemeCubit>(context).changeTheme(
                            themeName: 'darkTheme',
                          );
                          _isDarkTheme = value;
                          setState(() {});
                        } else {
                          ThemeSwitcher.of(context).changeTheme(
                              theme: themes['whiteTheme'], isReversed: true);
                          BlocProvider.of<ThemeCubit>(context)
                              .changeTheme(themeName: 'whiteTheme');
                          _isDarkTheme = false;
                        }
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: _isDarkTheme ||
                              LocalData.getData(key: 'theme') == 'darkTheme'
                          ? true
                          : false,
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            title: Text(
                              'about the app',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 15.sp),
                            ),
                            content: Text(
                              'all rights resreved to Aplus Technologis\nfor any concern please contact at:\nAPlus.Technologies779@gmail.com',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 13.sp),
                            ),
                          ));
                },
                leading: Icon(
                  Icons.info_outline,
                  size: 20.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'About the app',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
