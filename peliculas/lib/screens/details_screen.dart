import 'package:flutter/material.dart';
import 'package:peliculas/widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomappBar(),
          SliverList(delegate: SliverChildListDelegate([
            Padding(padding: const EdgeInsets.all(10),
            child: Text(movie,
            style: textTheme.headlineSmall)),
          const _PosterAndTitle(),
          const _Overview(),
          const _Overview(),
          const CastingCards()
          ]))
        ],
      ),
    );
  }
}

class _CustomappBar extends StatelessWidget {
  const _CustomappBar({super.key});

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
          child: const Text('movie.title', style: TextStyle(color: Colors.white),)),
        background: const FadeInImage(
          placeholder:  AssetImage('assets/no-image.jpg'), 
          image: NetworkImage('https://fakeimg.pl/500x300'), 
          fit: BoxFit.cover,),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'), 
            image: NetworkImage('https://fakeimg.pl/200x300'), 
            height: 150),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Text movie',
              style: textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              'movie.originalTitle',
              style: textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              ),
              Row(
                children: [
                  const Icon(Icons.star_outline_outlined, size: 15, color: Colors.grey,),
                  const SizedBox(width: 5,),
                  Text('Movie.voteAverage', style: textTheme.bodySmall,)
                ],
              )
          ],
        )
      ],),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text('Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.', textAlign: TextAlign.justify, style: textTheme.bodySmall,),
    );
  }
}
