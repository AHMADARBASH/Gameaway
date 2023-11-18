import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gameaway/blocs/news/news_cubit.dart';
import 'package:gameaway/blocs/news/news_states.dart';
import 'package:gameaway/layout/widgets/news.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    if (BlocProvider.of<NewsCubit>(context).isInit == false) {
      BlocProvider.of<NewsCubit>(context).getNews();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'News',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: context.isTablet ? 15.sp : 20.sp),
        ),
      ),
      body: FadeInUp(
        duration: const Duration(milliseconds: 1000),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsErrorState) {
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/error.png',
                      width: 70.w,
                      height: 30.h,
                    ),
                    Text(
                      state.errorMessage,
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<NewsCubit>(context).getNews();
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              );
            } else if (state is NewsLoadingState) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    const SpinKitFadingCircle(
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              );
            } else if (state is NewsEmptyState) {
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/void.png',
                      width: 70.w,
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'no news available',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.news.length,
                itemBuilder: (context, index) => NewsWidget(
                  width: context.width,
                  news: state.news[index],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
