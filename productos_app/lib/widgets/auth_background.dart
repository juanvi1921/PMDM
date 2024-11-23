import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required SingleChildScrollView child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: const Stack(
        children: [
          PurpleBox(),
        ],
      ),
    );
  }
}

class PurpleBox extends StatelessWidget {
  const PurpleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4, // 40% of screen height
      decoration: _purpleBackgorund(),
      child: Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            child: _Circle(),
          ),
          Positioned(
            top: -40,
            right: -30,
            child: _Circle(),
          ),
          Positioned(
            bottom: -50,
            left: -10,
            child: _Circle(),
          ),
          const Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Icon(
              Icons.person_pin,
              color: Colors.white,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackgorund() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1.0), // Purple
          Color.fromRGBO(90, 70, 178, 1.0), // Light Purple
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.05),
        shape: BoxShape.circle,
      ),
    );
  }
}