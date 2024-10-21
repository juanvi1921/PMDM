
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/now_playing_response.dart';

String _apikey = '69d07d4efbb3cd7fed209bc93c37aef8';
String _baseUrl = 'api.themoviedb.org';
String _language = 'ca-ES';

Future<String> _getJsonData(String endpoint, [int page = 1]) async {
  var url = Uri.https(_baseUrl, '3/movie/now_playing', {
    'api_key': _apikey,
    'language': _language,
    'page': '$page',
  });
  final response = await http.get(url);
  return response.body;
}

class MoviesProvider extends ChangeNotifier {
  int _popularPage = 0;
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  MoviesProvider() {
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing', 1);
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = NowPlayingResponse.fromJson(jsonData);
    
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  List<Movie> get movies => onDisplayMovies;
}