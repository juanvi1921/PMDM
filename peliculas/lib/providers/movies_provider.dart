
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/now_playing_response.dart';
import 'package:peliculas/models/popular_response.dart';

String _apikey = '69d07d4efbb3cd7fed209bc93c37aef8';
String _baseUrl = 'api.themoviedb.org';
String _language = 'ca-ES';
//String _language = 'es-ES';

Future<String> _getJsonData(String endpoint, [int page = 1]) async {
  var url = Uri.https(_baseUrl, endpoint, {
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
  Map<int, List<Cast>> moviesCast = {};
  MoviesProvider() {
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
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
    final popularResponse = PopularResponse.fromJson(jsonData);
    
    popularMovies = [...popularMovies, ...popularResponse.movies];
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int idMovie) async {
    if(moviesCast.containsKey(idMovie)) {
      print('El cast ya esta almacenado, no se hace nueva peticion');
      return moviesCast[idMovie]!;
    }
    
    print('Pidiendo info al server');
    final jsonData = await _getJsonData('3/movie/$idMovie/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  List<Movie> get movies => onDisplayMovies;
  List<Movie> get getPopularMoviesList => popularMovies;
}