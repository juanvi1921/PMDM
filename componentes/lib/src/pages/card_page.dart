import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
        backgroundColor: Colors.pink,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[_cardTipo1(), _cardTipo2()],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue),
            title: Text('Soy el titulo de la tarjeta'),
            subtitle: Text(
                'Esta es una prueba para ver lo que ocurre con una tarjeta'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(child: Text('Cancelar'), onPressed: () {}),
              TextButton(child: Text('OK'), onPressed: () {})
            ],
          )
        ],
      ),
    );
  }

  Widget _cardTipo2() {
    final card = Container(
      child: Column(
        children: [
          const FadeInImage(
            image: NetworkImage(
                'https://st5.depositphotos.com/10440072/65939/i/450/depositphotos_659390638-stock-photo-awesome-nature-landscape-beautiful-scene.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 10),
            height: 250,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Prueba de que funciona la imagen'),
          )
        ],
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(2, 10))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: card,
        ));
  }
}
