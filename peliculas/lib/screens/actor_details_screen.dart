import 'package:flutter/material.dart';
import 'package:peliculas/models/actor_response.dart';
import 'package:peliculas/providers/movies_provider.dart';  // Para acceder a MoviesProvider
import 'package:provider/provider.dart';  // Para el manejo del Provider
import 'package:peliculas/widgets/actor_card.dart'; // Asegúrate de importar el nuevo archivo

class ActorDetailsScreen extends StatelessWidget {
  const ActorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ActorResponse actor = ModalRoute.of(context)!.settings.arguments as ActorResponse;
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(actor: actor),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(actor: actor),
                _Biography(biography: actor.biography),
                const SizedBox(height: 20),  // Espacio para separar
                MoviesByActor(actorId: actor.id, moviesProvider: moviesProvider),  // Ahora usas el nuevo widget
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final ActorResponse actor;
  const _CustomAppBar({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(actor.name, style: const TextStyle(color: Colors.white)),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(actor.fullProfilePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final ActorResponse actor;
  const _PosterAndTitle({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            actor.name,
            style: textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star_outline_outlined, size: 15, color: Colors.grey),
              const SizedBox(width: 5),
              Text('${actor.popularity}', style: textTheme.bodySmall),
            ],
          ),
          if (actor.placeOfBirth != null)
            Text(
              'Lugar de nacimiento: ${actor.placeOfBirth}',
              style: textTheme.bodySmall,
            ),
          Text(
            'Cumpleaños: ${actor.birthday.toLocal().toString().split(' ')[0]}',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _Biography extends StatelessWidget {
  final String biography;
  const _Biography({super.key, required this.biography});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        biography.isNotEmpty ? biography : 'No hay biografía disponible.',
        textAlign: TextAlign.justify,
        style: textTheme.bodySmall,
      ),
    );
  }
}
