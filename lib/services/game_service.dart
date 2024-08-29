import 'dart:convert';

import 'package:learn_riverpod/models/game_model.dart';
import 'package:http/http.dart' as http;

class GameService {
  static Future<List<GameModel>?> getLiveGames() async {
    try {
      String baseUrl = "https://www.freetogame.com/api/games";
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        return list.map((e) => GameModel.fromJson(Map.from(e))).toList();
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
}
