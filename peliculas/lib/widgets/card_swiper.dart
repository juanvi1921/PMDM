import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: size.height *0.6,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 
              'details',
              arguments: '',);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg') , 
                image: NetworkImage('https://fakeimg.pl/300x400'),
                fit: BoxFit.fill
                ),
            ),
          );
        },
      ),
    );
  }
}