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
              return _CastCard(cast: cast[index]); // Pasar el objeto Cast completo
            }
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast; // Cambia esto para recibir el objeto Cast completo

  const _CastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Usa GestureDetector para manejar el toque
      onTap: () async {
        // Obtén el detalle del actor usando el id del cast
        final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
        final actorDetails = await moviesProvider.getActorDetails(cast.id); // Obtén ActorResponse aquí

        // Navegar a la pantalla de detalles del actor
        Navigator.pushNamed(
          context,
          'actor_details', // Asegúrate de que este nombre coincida con tu ruta
          arguments: actorDetails, // Pasa el objeto ActorResponse como argumento
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
                image: NetworkImage(cast.fullProfilePath), // Usa el método fullProfilePath
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
