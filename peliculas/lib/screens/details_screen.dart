import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomappBar(movie: movie),
          SliverList(delegate: SliverChildListDelegate([
            Padding(padding: const EdgeInsets.all(10),
            child: Text(
              movie.title,
              style: textTheme.headlineSmall)),
          _PosterAndTitle(movie: movie),
          _Overview(overview: movie.overview),
          CastingCards(idMovie: movie.id,)
          ]))
        ],
      ),
    );
  }
}

class _CustomappBar extends StatelessWidget {
  final Movie movie;
  const _CustomappBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(movie.title, style: const TextStyle(color: Colors.white),),
          )),
        background: FadeInImage(
          placeholder:  const AssetImage('assets/no-image.jpg'), 
          image: NetworkImage(movie.fullBackdropPath), 
          fit: BoxFit.cover,),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(children: [
        Hero(
          tag: movie.uniqueId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(movie.fullPosterImg), 
              height: 150,
              width: 102,
              ),
          ),
        ),
        const SizedBox(width: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.width - 190),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.originalTitle,
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outline_outlined, size: 15, color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: textTheme.bodySmall,)
                  ],
                )
            ],
          ),
        )
      ],),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;
  const _Overview({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(overview, textAlign: TextAlign.justify, style: textTheme.bodySmall,),
    );
  }
}
