import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const PurpleBox(),
          const _HeaderIcon(),
          child,
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
      height: size.height * 0.4,
      decoration: _purpleBackground(),
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
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0),
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

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
