import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      margin: const EdgeInsets.only(bottom: 30),
      child: ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _CastCard();
      },
    ),);
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: const Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: FadeInImage(
              height: 140,
              width: 100,
              placeholder: AssetImage('assets/no-image.jpg') , 
              image: NetworkImage('https://fakeimg.pl/150x300'),
              fit: BoxFit.cover),),
          //SizedBox(height: 5,),
          Text('actor.name sasasas asas', maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,) 
        ],
      ),
    );
  }
}