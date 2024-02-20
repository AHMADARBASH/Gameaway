import 'package:gameaway/utilities/exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class BaseRepository {
  Future<dynamic> getDatafromAPI({required String customURL}) async {
    final response = await http.get(Uri.parse(customURL)).timeout(
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
    return json.decode(response.body);
  }
}
