import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  bool showCard = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
        backgroundColor: Colors.pink,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [if (showCard)_buildCardWithMargin(_cardTipo1()),_buildCardWithMargin(_cardTipo2()),_buildCardWithMargin(_cardTipo3()), _buildCardWithMargin(_cardTipo4())],
      ),
    );
  }

  Widget _buildCardWithMargin(Widget card) {
    return Container(
      margin: EdgeInsets.only(bottom: 20), // Margen inferior entre tarjetas
      child: card,
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
            title: Text('Paisajes'),
            subtitle: Text(
                'Presento unas cuantas tarjetas de paisajes.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(child: Text('Cancelar'), onPressed: () {
                Navigator.pop(context);
              }),
              TextButton(child: Text('OK'), onPressed: () {
                showCard = false;
                setState(() {
                });
              })
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
            child: Text('Canada'),
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

  Widget _cardTipo3() {
    final card = Container(
      child: Column(
        children: [
          const FadeInImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfqfnWVWFzvFCRW6dX2MB6Cnho6uaLjltLNQ&s'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 10),
            height: 250,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Francia'),
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

  Widget _cardTipo4() {
    final card = Container(
      child: Column(
        children: [
          const FadeInImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6jgeJSFd4x8FBpAoCoiVvryBHB64H93YKhQ&s'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 10),
            height: 250,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('España'),
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
