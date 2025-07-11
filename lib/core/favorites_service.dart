import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/apod.dart';

class FavoritesService {
  static const _apodKey = 'favorite_apods';

  Future<List<Apod>> getFavoriteApods() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_apodKey) ?? [];
    return list.map((s) => Apod.fromJson(json.decode(s))).toList();
  }

  Future<bool> isApodFavorite(Apod apod) async {
    final favs = await getFavoriteApods();
    return favs.any((a) => a.date == apod.date);
  }

  Future<void> addApod(Apod apod) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_apodKey) ?? [];
    list.add(json.encode({
      'title': apod.title,
      'explanation': apod.explanation,
      'url': apod.url,
      'date': apod.date,
    }));
    await prefs.setStringList(_apodKey, list);
  }

  Future<void> removeApod(Apod apod) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_apodKey) ?? [];
    list.removeWhere((s) => Apod.fromJson(json.decode(s)).date == apod.date);
    await prefs.setStringList(_apodKey, list);
  }
}
