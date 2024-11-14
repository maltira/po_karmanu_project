import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:po_karmanu_project/models/carousel/carousel_item.dart';



class CarouselWidget extends StatelessWidget {
  CarouselWidget({super.key});
  final CarouselSliderController _controller = CarouselSliderController();

  final List<Widget> imgList = [
    CarouselItem(
        title: 'Cалаты на праздники',
        description: 'Порадуй близких полезными блюдами',
        imgHref: 'assets/img/onboarding/Carousel2.png'
    ),
    CarouselItem(
        title: 'Главные о выпечке',
        description: 'Научись выпекать как профессионал',
        imgHref: 'assets/img/onboarding/Carousel1.png'
    ),
    CarouselItem(
        title: 'Всё о тайском супе',
        description: 'Популярен во всем мире, но в чем особенность?',
        imgHref: 'assets/img/onboarding/Carousel3.png'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 370,
          autoPlay: true,
          aspectRatio: 2.0,
          initialPage: 1,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
        ),
        carouselController: _controller,
        items: imgList.map((item) => item).toList(),
      ),
    );
  }
}

