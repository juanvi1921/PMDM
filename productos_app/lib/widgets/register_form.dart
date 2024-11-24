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
          // Campo para el nombre de usuario
          _buildUsernameField(),
          const SizedBox(height: 20),

          // Campo para el correo electrónico
          _buildEmailField(),
          const SizedBox(height: 20),

          // Campo para la contraseña
          _buildPasswordField(),
          const SizedBox(height: 20),

          // Campo para el teléfono
          _buildPhoneField(),
          const SizedBox(height: 20),

          // Campo para el sexo
          _buildGenderField(),
          const SizedBox(height: 20),

          // Campo para la fecha de nacimiento
          _buildBirthDateField(),
          const SizedBox(height: 30),

          // Botón de registro
          RegisterBtn(formKey: _formKey),
        ],
      ),
    );
  }

  // Campo para el nombre de usuario
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

  // Campo para el correo electrónico
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

  // Campo para la contraseña
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

  // Campo para el teléfono
  Widget _buildPhoneField() {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Teléfono',
        icon: Icons.phone,
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu número de teléfono';
        }
        return null;
      },
    );
  }

  // Campo para el sexo
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

  // Campo para la fecha de nacimiento
  Widget _buildBirthDateField() {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Fecha de nacimiento',
        icon: Icons.calendar_today,
      ),
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu fecha de nacimiento';
        }
        return null;
      },
    );
  }
}
