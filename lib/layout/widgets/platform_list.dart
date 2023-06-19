import 'package:flutter/material.dart';

Map<int, dynamic> _platforms = {
  1: {'name': 'pc', 'colors': Colors.blue, 'image': 'assets/images/PC.png'},
  2: {
    'name': 'steam',
    'colors': Colors.blue[900],
    'image': 'assets/images/Steam.png'
  },
  3: {'name': 'ps4', 'colors': Colors.blue, 'image': 'assets/images/PS4.png'},
  4: {'name': 'ps5', 'colors': Colors.blue, 'image': 'assets/images/PS5.png'},
  5: {
    'name': 'ubisoft',
    'colors': Colors.blue[100],
    'image': 'assets/images/ubisoft.png'
  },
  6: {
    'name': 'epic-games-store',
    'colors': Colors.white,
    'image': 'assets/images/epic-games.png'
  },
  7: {
    'name': 'switch',
    'colors': Colors.red[400],
    'image': 'assets/images/switch.png'
  },
  8: {
    'name': 'xbox-one',
    'colors': Colors.green,
    'image': 'assets/images/XBOX-one.png'
  },
  9: {
    'name': 'xbox-series-xs',
    'colors': Colors.green,
    'image': 'assets/images/Xbox_Series_X.png'
  },
  10: {
    'name': 'android',
    'colors': Colors.greenAccent,
    'image': 'assets/images/android.png'
  },
  11: {'name': 'ios', 'colors': Colors.white, 'image': 'assets/images/ios.png'},
  12: {
    'name': 'xbox360',
    'colors': Colors.green,
    'image': 'assets/images/xbox360.png'
  }
};

class PlatformsList extends StatelessWidget {
  final List<String?> words;
  const PlatformsList({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            words.contains('PC') || words.contains(' PC')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[1]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[1]['image'],
                          color: _platforms[1]['colors']),
                    ))
                : const SizedBox(),
            words.contains('Steam') || words.contains(' Steam')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[2]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[2]['image'],
                          color: _platforms[2]['colors']),
                    ))
                : const SizedBox(),
            words.contains('Epic Games Store') ||
                    words.contains(' Epic Games Store')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[6]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[6]['image'],
                          color: _platforms[6]['colors']),
                    ))
                : const SizedBox(),
            words.contains('Playstation 4') || words.contains(' Playstation 4')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[3]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[3]['image'],
                          color: _platforms[3]['colors']),
                    ))
                : const SizedBox(),
            words.contains('Playstation 5') || words.contains(' Playstation 5')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[4]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(
                        _platforms[4]['image'],
                        color: _platforms[4]['colors'],
                      ),
                    ))
                : const SizedBox(),
            words.contains('Xbox One') || words.contains(' Xbox One')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[8]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[8]['image'],
                          color: _platforms[8]['colors']),
                    ))
                : const SizedBox(),
            words.contains('Xbox Series X|S') ||
                    words.contains(' Xbox Series X|S')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[9]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[9]['image'],
                          color: _platforms[9]['colors']),
                    ))
                : const SizedBox(),
            words.contains('Xbox 360') || words.contains(' Xbox 360')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[12]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[12]['image'],
                          color: _platforms[12]['colors']),
                    ))
                : const SizedBox(),
            words.contains('Nintendo Switch') ||
                    words.contains(' Nintendo Switch')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[7]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[7]['image'],
                          color: _platforms[7]['colors']),
                    ))
                : const SizedBox(),
            words.contains('Android') || words.contains(' Android')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[10]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[10]['image'],
                          color: _platforms[10]['colors']),
                    ))
                : const SizedBox(),
            words.contains('iOS') || words.contains(' iOS')
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: _platforms[11]['colors']),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      child: Image.asset(_platforms[11]['image'],
                          color: _platforms[11]['colors']),
                    ))
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
