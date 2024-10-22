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

    return FutureBuilder(
      future: moviesProvider.getMoviesCast(idMovie),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(),);
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
              return _CastCard(
                actorName: cast[index].name,
                profilePath: cast[index].profilePath,
              );
            }),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final String actorName;
  final String? profilePath;
  const _CastCard({super.key, required this.actorName, this.profilePath});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              placeholder: const AssetImage('assets/no-image.jpg') , 
              image: NetworkImage(profilePath != null
              ? 'https://image.tmdb.org/t/p/w500$profilePath'
              : 'https://fakeimg.pl/150x300'
              ),
              fit: BoxFit.cover),),
          //SizedBox(height: 5,),
          Text(actorName, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,) 
        ],
      ),
    );
  }
}