import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 100.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [_crearSlider(), Expanded(child: _crearImagen()), _crearCheckBox(), _crearSwitch()],
        ),
      ));
  }

  Widget _crearSlider() {
    return Slider(
      activeColor:  Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      divisions: 20,
      value: _valorSlider,
      min: 10.0,
      max: 300.0,
      onChanged: (_bloquearCheck) ? null : (valor) {
        setState(() {
          _valorSlider = valor;
        });
      });
  }

  Widget _crearImagen() {
    return Center(
      child: FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe3C2Jeezcab8jj2DaDK_ymq2zkaB_YYb0yQ&s"),
        fadeInDuration: Duration(milliseconds: 2),
        width: _valorSlider,
        fit: BoxFit.contain),
    );
  }

  Widget _crearCheckBox() {
    return CheckboxListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          _bloquearCheck = valor!;
        });
      });
  }
      
  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          _bloquearCheck = valor;
        });
      });
  }
}
