import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar Page'),
        backgroundColor: Colors.pink,
        actions: [
          Container(
            padding: const EdgeInsets.all(6.5),
            child: const CircleAvatar(
              backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZXP7xop6r0hx19a8Fosfq8KQ8po3WiZRh-w&s"),
              radius: 25,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const CircleAvatar(
              child:Text('AA'),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),
      body: const Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStGXMjv9ulRyha_wEpFqXK1bl3kUgeZT_pfw&s"),
          fadeInDuration: Duration(milliseconds: 2),
        )
      )
    );
  }
}