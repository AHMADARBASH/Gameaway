import 'package:gameaway/data/Models/freetoplay.dart';
import 'package:gameaway/data/Models/giveaway.dart';
import 'package:gameaway/data/Models/news.dart';
import 'package:gameaway/utilities/exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class BaseRepository {
  Future<List<Giveaway>> getGiveaways({required String customeUrl}) async {
    final url = Uri.parse(customeUrl);
    final response = await http.get(url).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw HTTPException(message: 'Time out');
      },
    );
    if (response.statusCode != 200) {
      if (response.statusCode == 201) {
        throw EmptyException(
            message: json.decode(response.body)['status_message']);
      } else {
        throw HTTPException(message: 'Server Error');
      }
    }
    final responseData = json.decode(response.body);
    List<Giveaway> giveawaysList = [];
    for (int i = 0; i < responseData.length; i++) {
      giveawaysList.add(Giveaway.fromJson(responseData[i]));
    }
    return giveawaysList;
  }

  Future<List<FreetoPlay>> getfreetoplay({required String customeUrl}) async {
    final url = Uri.parse('https://www.freetogame.com/api/games');
    final response = await http.get(url).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw HTTPException(message: 'Time out');
      },
    );
    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        throw EmptyException(message: 'not found');
      } else {
        throw HTTPException(message: 'Server Error');
      }
    }
    final responseData = json.decode(response.body);
    List<FreetoPlay> freetoplayList = [];
    for (int i = 0; i < responseData.length; i++) {
      freetoplayList.add(FreetoPlay.fromJson(responseData[i]));
    }
    return freetoplayList;
  }

  Future<List<News>> getNews({required String cutsomeUrl}) async {
    final url = Uri.parse(cutsomeUrl);
    final response = await http.get(url).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw HTTPException(message: 'Time out');
      },
    );
    if (response.statusCode != 200) {
      if (response.statusCode == 201) {
        throw EmptyException(
            message: json.decode(response.body)['status_message']);
      } else {
        throw HTTPException(message: 'Server Error');
      }
    }
    final data = json.decode(response.body);
    List<News> news = [];
    for (int i = 0; i < data.length; i++) {
      news.add(News.fromJson(data[i]));
    }
    return news;
  }
}
