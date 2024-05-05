import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/theme/theme_cubit.dart';
import 'package:gameaway/blocs/theme/theme_state.dart';
import 'package:gameaway/data/Dataproviders/helpers/cached_data.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = CachedData.getData(key: 'theme') == 'darkTheme';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: context.isTablet ? 15.sp : 20.sp),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.sp,
          ),
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
                    .copyWith(fontSize: context.isTablet ? 12.sp : 15.sp),
              ),
              trailing: Switch(
                onChanged: (value) {
                  if (value == true) {
                    BlocProvider.of<ThemeCubit>(context).changeTheme(
                      themeName: 'darkTheme',
                    );
                    _isDarkTheme = value;
                    setState(() {});
                  } else {
                    BlocProvider.of<ThemeCubit>(context)
                        .changeTheme(themeName: 'whiteTheme');
                    _isDarkTheme = false;
                  }
                },
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveThumbColor: Colors.grey,
                value: _isDarkTheme ||
                        CachedData.getData(key: 'theme') == 'darkTheme'
                    ? true
                    : false,
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.sp,
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: context.isTablet ? 10.sp : 12.sp),
                              ))
                        ],
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        content: Text(
                          'all rights resreved to Aplus Technologis\nfor any concern please contact at:\nAPlus.Technologies779@gmail.com',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: context.isTablet ? 12.sp : 15.sp,
                                  fontWeight: FontWeight.normal),
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
                  .copyWith(fontSize: context.isTablet ? 12.sp : 15.sp),
            ),
          )
        ],
      ),
    );
  }
}
