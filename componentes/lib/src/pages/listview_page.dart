import 'dart:async';

import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  ScrollController _scrollController = new ScrollController();

  List<int> _listaNumeros = [];
  int _lastItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _agregar10();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
        backgroundColor: Colors.pink,
      ),
      body: Stack(children: [_crearLista(), _crearLoading()]),
    );
  }

  Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listaNumeros.length,
        itemBuilder: (BuildContext context, int index) {
          final imagen = _listaNumeros[index];

          return FadeInImage(
            fit: BoxFit.cover,
            height: 250,
            image: NetworkImage('https://picsum.photos/500/300?image=$imagen'),
            placeholder: AssetImage('assets/jar-loading.gif'),
          );
        },
      )
    );
  }

  void _agregar10() {
    for (int i = 1; i < 10; i++) {
      _lastItem++;
      _listaNumeros.add(_lastItem);
    }

    setState(() {});
  }

  Future fetchData() async {
    _isLoading = true;
    setState(() {});

    final duration = new Duration(seconds: 2);
    return new Timer(duration, responseHTTP);
  }

  void responseHTTP() {
    _isLoading = false;

    _scrollController.animateTo(_scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));

    _agregar10();
  }

  Widget _crearLoading() {
    if (_isLoading) {
      return const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
          SizedBox(height: 15.0)
        ],
      );
    } else {
      return Container();
    }
  }

  Future<Null> obtenerPagina1() async {
    final duration = new Duration(seconds: 2);
    setState(() {
      new Timer(duration, () {
        _listaNumeros.clear();
        _lastItem++;
        _agregar10();
      });
    });
  }
}