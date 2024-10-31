import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelegramMessageScreen extends StatefulWidget {
  @override
  _TelegramMessageScreenState createState() => _TelegramMessageScreenState();
}

class _TelegramMessageScreenState extends State<TelegramMessageScreen> {
  final TextEditingController _controller = TextEditingController();
  final String _botToken = '7729343173:AAEbtmOByKxcq16ScoedM77Is84NfSlb-Qw';
  final String _chatId = '-4051266623'; //Este es el del grupo  '6577909150'Este es el mio

  // Función para enviar el mensaje
  Future<void> _sendMessage() async {
    final message = _controller.text;
    final url = 'https://api.telegram.org/bot$_botToken/sendMessage';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'chat_id': _chatId,
          'text': message,
        },
      );

      if (response.statusCode == 200) {
        // Mensaje enviado correctamente
        print('Mensaje enviado correctamente');
        _controller.clear();
      } else {
        // Error al enviar el mensaje
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al enviar el mensaje: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enviar mensaje a Telegram')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Escribe tu mensaje'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Enviar a Telegram'),
            ),
          ],
        ),
      ),
    );
  }
}
