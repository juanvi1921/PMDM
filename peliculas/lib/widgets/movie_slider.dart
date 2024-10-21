import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key, required this.movies, this.title});
  final List<Movie> movies;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 310,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(padding: EdgeInsets.all(10),
            child: Text(title!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
          ],
          Expanded(child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _MoviePoster(movie:movies[index]);
            },
            scrollDirection: Axis.horizontal,
          ))
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 
              'details',
              arguments: movie,);
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: FadeInImage(placeholder: const AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(movie.fullPosterImg))),
          ),
          const SizedBox(height: 5),
          Text(
          movie.title, 
          maxLines: 2, 
          overflow: TextOverflow.ellipsis, 
          textAlign: TextAlign.center,)
        ],
      )
      );
  }
}