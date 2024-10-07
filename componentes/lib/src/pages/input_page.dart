import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _nombre = "";
  String _email = "";
  String _fecha = "";
  List<String> _hobbies = ['Leer', 'Ver series', 'Viajar', 'Deporte'];
  String _opcionSeleccionada = 'Leer';
  TextEditingController _inputFileDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inputs de texto'),
          backgroundColor: Colors.pink,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            _crearInput(),
            SizedBox(height: 20),
            _crearEmail(),
            SizedBox(height: 20),
            _crearPassword(),
            SizedBox(height: 20),
            _crearFecha(context),
            SizedBox(height: 20),
            _crearPersona(),
            SizedBox(height: 20),
            _crearDropdown()
          ],
        ));
  }

  Widget _crearDropdown() {
    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(width: 30),
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionada,
            items: getOpcionesDropdown(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionada = opt!;
              });
            },
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];

    _hobbies.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  Widget _crearInput() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0), //He añadido un poco de margen superior en el nombre.
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          counter: Text('Letras ${_nombre.length}'),
          hintText: 'Nombre de la persona',
          labelText: 'Nombre',
          helperText: 'Solo es el nombre',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onChanged: (valor) {
          setState(() {
            _nombre = valor;
          });
        },
      ),
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Mi nombre es: $_nombre'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('Email: $_email'),
        Text('Fecha de nacimiento: $_fecha')
      ],),
      contentPadding: EdgeInsets.all(0),
    );
  }

  Widget _crearEmail() {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Email',
            labelText: 'Email',
            suffixIcon: Icon(Icons.alternate_email),
            icon: Icon(Icons.email),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearPassword() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        onChanged: (valor) => setState(() {
            }));
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFileDateController,
      decoration: InputDecoration(
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          suffixIcon: Icon(Icons.calendar_today),
          icon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2026));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat('yyyy-MM-dd').format(picked);
        _inputFileDateController.text = _fecha;
      });
    }
  }
}
