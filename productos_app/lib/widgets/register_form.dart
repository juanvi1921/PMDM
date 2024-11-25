import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/register_btn.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _buildUsernameField(),
          const SizedBox(height: 20),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 20),
          _buildPhoneField(),
          const SizedBox(height: 20),
          _buildGenderField(),
          const SizedBox(height: 20),
          _buildBirthDateField(),
          const SizedBox(height: 30),
          RegisterBtn(formKey: _formKey),
        ],
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Nombre de usuario',
        icon: Icons.account_circle,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu nombre de usuario';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Correo electrónico',
        icon: Icons.email,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = RegExp(pattern);

        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu correo electrónico';
        } else if (!regExp.hasMatch(value)) {
          return 'Por favor ingresa un correo electrónico válido';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Contraseña',
        icon: Icons.lock_outline,
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu contraseña';
        } else if (value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Teléfono',
        icon: Icons.phone,
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        String pattern = r'^[0-9]{7,15}$';
        RegExp regExp = RegExp(pattern);

        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu número de teléfono';
        } else if (!regExp.hasMatch(value)) {
          return 'Por favor ingresa un número de teléfono válido (7-15 dígitos)';
        }
        return null;
      },
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Sexo',
        icon: Icons.person,
      ),
      items: ['Masculino', 'Femenino', 'Otro']
          .map((gender) => DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              ))
          .toList(),
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor selecciona tu sexo';
        }
        return null;
      },
    );
  }

  Widget _buildBirthDateField() {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Fecha de nacimiento',
        icon: Icons.calendar_today,
      ),
      keyboardType: TextInputType.datetime,
      validator: (value) {
        String pattern =
            r'^(0[1-9]|[12][0-9]|3[01])[-/](0[1-9]|1[0-2])[-/](\d{4})$';
        RegExp regExp = RegExp(pattern);

        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu fecha de nacimiento';
        } else if (!regExp.hasMatch(value)) {
          return 'Por favor ingresa una fecha válida (dd/mm/yyyy o dd-mm-yyyy)';
        }

        List<String> dateParts = value.split(RegExp(r'[-/]'));
        int day = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int year = int.parse(dateParts[2]);

        try {
          DateTime birthDate = DateTime(year, month, day);
          DateTime today = DateTime.now();
          int age = today.year - birthDate.year;
          if (today.month < birthDate.month ||
              (today.month == birthDate.month && today.day < birthDate.day)) {
            age--;
          }
          if (age < 18) {
            return 'Debes tener al menos 18 años';
          }
        } catch (e) {
          return 'Fecha inválida';
        }

        return null;
      },
    );
  }
}
