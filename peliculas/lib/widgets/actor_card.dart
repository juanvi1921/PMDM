import 'package:flutter/material.dart';
import 'package:peliculas/models/actor_response.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/providers/movies_provider.dart';

class ActorCard extends StatelessWidget {
  final ActorResponse actor;

  const ActorCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'actor_details',
          arguments: actor,
        );
      },
      child: Card(
        child: Column(
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              fit: BoxFit.cover,
            ),
            Text(actor.name),
          ],
        ),
      ),
    );
  }
}

class MoviesByActor extends StatelessWidget {
  final int actorId;
  final MoviesProvider moviesProvider;

  const MoviesByActor(
      {super.key, required this.actorId, required this.moviesProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Pel·lícules on ha actuat',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        FutureBuilder<List<Movie>>(
          future: moviesProvider.getMoviesByActor(actorId),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final movies = snapshot.data!;

            if (movies.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Este actor no tiene películas disponibles.',
                    textAlign: TextAlign.center),
              );
            }

            return Container(
              width: double.infinity,
              height: 180,
              margin: const EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final movie = movies[index];
                  return MoviePoster(movie: movie);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final Movie movie;

  const MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.uniqueId = '${movie.id}-poster';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'details',
          arguments: movie,
        );
      },
      child: Container(
        width: 130,
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: movie.uniqueId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  image: NetworkImage(movie.fullPosterImg),
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 140,
                  width: 100,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
