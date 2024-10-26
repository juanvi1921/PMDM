import 'package:flutter/material.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int idMovie;

  const CastingCards({super.key, required this.idMovie});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Repartiment',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        FutureBuilder(
          future: moviesProvider.getMoviesCast(idMovie),
          builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final List<Cast> cast = snapshot.data!;

            return Container(
              width: double.infinity,
              height: 180,
              margin: const EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                  itemCount: cast.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return _CastCard(cast: cast[index]);
                  }),
            );
          },
        ),
      ],
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;

  const _CastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final moviesProvider =
            Provider.of<MoviesProvider>(context, listen: false);
        final actorDetails = await moviesProvider.getActorDetails(cast.id);

        Navigator.pushNamed(
          context,
          'actor_details',
          arguments: actorDetails,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 140,
                width: 100,
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(cast.fullProfilePath),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              cast.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
