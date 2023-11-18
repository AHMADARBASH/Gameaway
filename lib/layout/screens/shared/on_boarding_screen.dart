import 'package:flutter/material.dart';
import 'package:gameaway/data/helpers/local_data.dart';
import 'package:gameaway/layout/screens/shared/home_screen.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:sizer/sizer.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<OnboardingPage> _data = [
    const OnboardingPage(
      title: 'Hello Gamers',
      subtitle: 'Welcom onboard, this is a Gameaway',
      image: 'assets/images/gaming.png',
    ),
    const OnboardingPage(
      title: 'Claim your gifts',
      subtitle: 'Explore new and worth video games giveaways',
      image: 'assets/images/gift.png',
    ),
    const OnboardingPage(
      title: 'Tell your friends',
      subtitle: 'share the app with your friend and have fun together',
      image: 'assets/images/share.png',
    ),
    const OnboardingPage(
      title: 'Let\'s get started',
      subtitle: '',
      image: 'assets/images/complete.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _data,
            ),
          ),
          Row(
            children: [
              TextButton(
                child: Text(
                  'SKIP',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: context.isTablet ? 10.sp : 15.sp),
                ),
                onPressed: () {
                  LocalData.saveData(key: 'opened', data: 'opened');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeScreen(),
                    ),
                  );
                },
              ),
              const Spacer(),
              ...List.generate(
                  _data.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: DotIndicator(
                          isActive: index == _currentPage,
                        ),
                      )),
              const Spacer(),
              TextButton(
                child: Text(
                  _currentPage == 3 ? 'START' : 'NEXT',
                  style: TextStyle(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.bold,
                      fontSize: context.isTablet ? 10.sp : 15.sp),
                ),
                onPressed: () {
                  if (_currentPage == 3) {
                    LocalData.saveData(key: 'opened', data: 'opened');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                    );
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: context.height * 0.4,
          ),
          const SizedBox(height: 32.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;
  const DotIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      width: isActive ? 24 : 6,
      height: 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isActive ? Colors.blue : Colors.grey),
    );
  }
}
