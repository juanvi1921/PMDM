import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String ? url;
  const BackgroundImage(  this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
          width: double.infinity,
          height: 400,
          child: FadeInImage(
            placeholder: const AssetImage('assets/jar-loading.gif'),
            image: url != null ? NetworkImage(url!) : const AssetImage('assets/no-image.jpg'),
            fit: url != null ? BoxFit.contain : BoxFit.cover,
          )),
    );
  }
}
