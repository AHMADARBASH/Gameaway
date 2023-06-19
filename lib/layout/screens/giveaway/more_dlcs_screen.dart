import 'package:animate_do/animate_do.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameaway/blocs/DLCs/dlcs_cubit.dart';
import 'package:gameaway/blocs/DLCs/dlcs_states.dart';
import 'package:gameaway/layout/widgets/giveaway.dart';
import 'package:sizer/sizer.dart';

class MoreDLCsScreen extends StatefulWidget {
  static const String routeName = '/MoreDLCsScreen';
  final String platform;
  const MoreDLCsScreen({super.key, required this.platform});

  @override
  State<MoreDLCsScreen> createState() => _MoreDLCsScreenState();
}

class _MoreDLCsScreenState extends State<MoreDLCsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DLCsCubit, DLCsState>(
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
              '${widget.platform} DLCs',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20.sp),
            ),
          ),
          body: FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: ListView.builder(
              itemCount: state.dlcs.length,
              itemBuilder: (context, index) => GiveawayWidget(
                width: 95.w,
                giveaway: state.dlcs[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
