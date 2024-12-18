import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/actor_response.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/movie.dart';

class ActorProvider extends ChangeNotifier {
  final String _apikey = '69d07d4efbb3cd7fed209bc93c37aef8';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'ca-ES';

  ActorResponse? actorDetails;
  List<Movie> actorMovies = [];

  final StreamController<ActorResponse> _actorStreamController =
      StreamController.broadcast();

  Stream<ActorResponse> get actorStream => _actorStreamController.stream;

  Future<void> getActorDetails(int actorId) async {
    final url = Uri.https(_baseUrl, '3/person/$actorId', {
      'api_key': _apikey,
      'language': _language,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      actorDetails = ActorResponse.fromJson(response.body);
      _actorStreamController.add(actorDetails!);
      notifyListeners();
    } else {
      throw Exception('Error al cargar los detalles del actor');
    }
  }

  Future<void> getActorMovies(int actorId) async {
    final url = Uri.https(_baseUrl, '3/person/$actorId/movie_credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final creditsResponse = CreditsResponse.fromJson(response.body);
      actorMovies = creditsResponse.cast.cast<Movie>();
      notifyListeners();
    } else {
      throw Exception('Error al cargar la filmografía del actor');
    }
  }

  void dispose() {
    _actorStreamController.close();
    super.dispose();
  }
}
