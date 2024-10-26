import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  String get searchFieldLabel => 'Cercar pel·lícula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          print('Boton de vuelta');
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder<List<Movie>>(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _emptyContainer();
        }

        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder<List<Movie>>(
        stream: moviesProvider.suggestionStream,
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data!;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: ((context, index) =>
                  _MovieItem(movie: movies[index])),
            );
          } else {
            return _emptyContainer();
          }
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.uniqueId = '${movie.id}-search';
    return SizedBox(
      height: 70,
      width: 100,
      child: ListTile(
        leading: Hero(
          tag: movie.uniqueId!,
          child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              width: 50,
              fit: BoxFit.contain),
        ),
        title: Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          movie.originalTitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            'details',
            arguments: movie,
          );
        },
      ),
    );
  }
}

class _emptyContainer extends StatelessWidget {
  const _emptyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }
}
