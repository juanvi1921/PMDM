import 'package:flutter/material.dart';
import 'package:peliculas/models/actor_response.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/providers/movies_provider.dart';

class ActorCard extends StatelessWidget {
  final ActorResponse actor;

  const ActorCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la pantalla de detalles del actor
        Navigator.pushNamed(
          context,
          'actor_details', // Asegúrate de que este nombre coincida con tu ruta
          arguments: actor, // Pasa el actor como argumento
        );
      },
      child: Card(
        child: Column(
          children: [
            // Mostrar la imagen del actor
            FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              fit: BoxFit.cover,
            ),
            // Mostrar el nombre del actor
            Text(actor.name),
          ],
        ),
      ),
    );
  }
}

// Widget para mostrar las películas en las que ha participado el actor
class MoviesByActor extends StatelessWidget {
  final int actorId;
  final MoviesProvider moviesProvider;

  const MoviesByActor({super.key, required this.actorId, required this.moviesProvider});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: moviesProvider.getMoviesByActor(actorId),  // Llama a la función para obtener las películas
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());  // Muestra un loader mientras carga
        }

        final movies = snapshot.data!;  // Lista de películas

        if (movies.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Este actor no tiene películas disponibles.', textAlign: TextAlign.center),
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
              return MoviePoster(movie: movie);  // Muestra el poster de la película
            },
          ),
        );
      },
    );
  }
}

// Widget para mostrar el poster de la película
class MoviePoster extends StatelessWidget {
  final Movie movie;

  const MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Asigna el uniqueId antes de usarlo
    movie.uniqueId = '${movie.id}-poster'; // Esto es clave

    return GestureDetector(
      onTap: () {
        // Navegar a la pantalla de detalles de la película
        Navigator.pushNamed(
          context,
          'details', // Ruta de la pantalla de detalles de la película
          arguments: movie, // Pasa el objeto `Movie` como argumento
        );
      },
      child: Container(
        width: 130,
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,  // Alinea a la izquierda
          children: [
            Hero(
              tag: movie.uniqueId!, // Usa el uniqueId para el Hero
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  image: NetworkImage(movie.fullPosterImg),  // Asegúrate de que este método exista en Movie
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 140,  // Ajusta el alto del poster
                  width: 100,   // Ajusta el ancho del poster
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
                style: TextStyle(fontSize: 12),  // Ajusta el tamaño del texto si es necesario
              ),
            ),
          ],
        ),
      ),
    );
  }
}
