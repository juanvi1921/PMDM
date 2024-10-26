import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/actor_response.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/movie_credits_response.dart';
import 'package:peliculas/models/now_playing_response.dart';
import 'package:peliculas/models/popular_response.dart';
import 'package:peliculas/models/search_response.dart';

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

  if (response.statusCode != 200) {
    throw Exception(
        'Error en la conexión con el servidor: ${response.statusCode}');
  }

  return response.body;
}

class MoviesProvider extends ChangeNotifier {
  int _popularPage = 0;
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> searchedMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  final StreamController<List<Movie>> _sugestionsStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._sugestionsStreamController.stream;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

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
    if (moviesCast.containsKey(idMovie)) {
      print('El cast ya está almacenado, no se hace nueva petición');
      return moviesCast[idMovie]!;
    }

    print('Pidiendo info al servidor');
    final jsonData = await _getJsonData('3/movie/$idMovie/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final searchResponse = SearchResponse.fromJson(response.body);
      return searchResponse.results;
    } else {
      throw Exception('Error al buscar películas');
    }
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      print('Tenemos valor a buscar: $value');
      final results = await this.searchMovies(value);
      this._sugestionsStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  Future<ActorResponse> getActorDetails(int actorId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/$actorId?api_key=$_apikey'));

    if (response.statusCode == 200) {
      return ActorResponse.fromJson(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Error al cargar detalles del actor');
    }
  }

  Future<List<Movie>> getMoviesByActor(int actorId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/$actorId/movie_credits?api_key=$_apikey&language=$_language'));

    if (response.statusCode == 200) {
      final movieCreditsResponse = MovieCreditsResponse.fromJson(response.body);
      return movieCreditsResponse.cast;
    } else {
      throw Exception('Error al cargar películas del actor');
    }
  }

  List<Movie> get movies => onDisplayMovies;
  List<Movie> get getPopularMoviesList => popularMovies;
  List<Movie> get getSearchedMovies => searchedMovies;
}
