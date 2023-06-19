// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/freetoplay/freetoplay_cubit.dart';
import 'package:gameaway/blocs/freetoplay/freetoplay_states.dart';
import 'package:gameaway/layout/widgets/freetoplay.dart';
import 'package:sizer/sizer.dart';

class MoreFreetoPlayScreen extends StatefulWidget {
  static const String routeName = '/MoreFreetoPlayScreen';
  String genre;
  MoreFreetoPlayScreen({super.key, required this.genre});

  @override
  State<MoreFreetoPlayScreen> createState() => _MoreFreetoPlayScreenState();
}

class _MoreFreetoPlayScreenState extends State<MoreFreetoPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FreetoPlayCubit, FreetoPlayState>(
      builder: (context, state) => ColorfulSafeArea(
        color: Theme.of(context).appBarTheme.backgroundColor!,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                )),
            title: Text(
              '${widget.genre} Free to play',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20.sp),
            ),
          ),
          body: FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: ListView.builder(
              itemCount: state.freetoplay.length,
              itemBuilder: (context, index) => FreetoPlayWidget(
                width: 95.w,
                freetoPlay: state.freetoplay[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
