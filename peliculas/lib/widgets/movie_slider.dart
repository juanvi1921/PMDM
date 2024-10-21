import 'package:flutter/material.dart';
class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 45),
      width: double.infinity,
      height: 295,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(10),
          child: Text("Populares", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Expanded(child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return const _MoviePoster();
            },
            scrollDirection: Axis.horizontal,
          ))
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({super.key});

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
              arguments: '',);
            },
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: FadeInImage(placeholder: AssetImage('assets/no-image.jpg'), image: NetworkImage('https://fakeimg.pl/300x400'))),
          ),
          const SizedBox(height: 5),
          const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do', 
          maxLines: 2, 
          overflow: TextOverflow.ellipsis, 
          textAlign: TextAlign.center,)
        ],
      )
      );
  }
}