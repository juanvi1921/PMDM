import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/card_swiper.dart';
import 'package:peliculas/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    print(moviesProvider.onDisplayMovies);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pel·lícules en cinemes', style: TextStyle(color: Colors.white),),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: const Icon(Icons.search_outlined, color: Colors.white,),
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDelegate());
            },
        ),)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Slider de peliculas 
            MovieSlider(
              movies: moviesProvider.getPopularMoviesList, 
              title: 'Populars',
              onNextPage: () => moviesProvider.getPopularMovies(),)],
        ),
      ),
    );
  }
}
