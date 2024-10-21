import 'package:flutter/material.dart';
import 'package:peliculas/widgets/card_swiper.dart';
import 'package:peliculas/widgets/movie_slider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines', style: TextStyle(color: Colors.white),),
        actions: const [Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Icon(Icons.search_outlined, color: Colors.white,),
        ),],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(),
            //Slider de peliculas 
            MovieSlider()],
        ),
      ),
    );
  }
}
