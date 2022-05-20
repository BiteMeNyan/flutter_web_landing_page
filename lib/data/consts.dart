import 'package:empat_landing/config/my_colors.dart';
import 'package:flutter/material.dart';

import '../config/style.dart';
import '../widgets/tiles/service_tile.dart';

List<Widget> servicesTiles = [
  const Padding(
    padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
    child: ServiceTile(
      label: 'Mobile app development',
      description: 'IOS, Android, cross-platform dev',
      color: MyColors.lightBlue,
    ),
  ),
  const Padding(
    padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
    child: ServiceTile(
      label: 'Web development',
      description: 'Corporate websites, marketplaces, e-commerce, platforms',
      color: Colors.greenAccent,
    ),
  ),
  const Padding(
    padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
    child: ServiceTile(
      label: 'Design',
      description:
          'UI/UX Design, product design, logo, wiferfaming, prototyping',
      color: Colors.greenAccent,
    ),
  ),
  const Padding(
    padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
    child: ServiceTile(
      label: 'Startup studio',
      description:
          'Product from scratch = design thinking, idea validation, discovery phase',
      color: MyColors.lightBlue,
    ),
  )
];

List<String> carouselItems = [
  'monster_fighters',
  'obimy',
  'dental',
  'powerful',
  'monster_fighters2'
];

List<Alignment> menuGradientAlignmentList = [
  Alignment.bottomLeft,
  Alignment.bottomRight,
  Alignment.topRight,
  Alignment.topLeft,
];

List<Color> gradientColorList = [
  MyColors.electric,
  MyColors.lightElectric,
  MyColors.blue,
  MyColors.lightBlue,
];

List<Widget> socialMediaIcons = [
  Image.asset(
    'assets/icons/facebook.png',
    color: Colors.white,
    height: 30,
  ),
  Image.asset(
    'assets/icons/linkedin.png',
    color: Colors.white,
    height: 30,
  ),
  Image.asset(
    'assets/icons/instagram.png',
    color: Colors.white,
    height: 30,
  ),
];

List aboutUsText = [
  Text(
    'Clients',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'About',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'News',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'Contacts',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'Projects',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'Core values',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'Facebook',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'LinkedIn',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'Instagram',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'DOU',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    '45/2 Pushkinska str.',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
  Text(
    'Kyiv, Ukraine',
    style: h3TextStyle.copyWith(color: MyColors.grey),
  ),
];

List<Widget> achievements = [
  Column(
    children: [
      Text(
        '300+',
        style: h2TextStyle.copyWith(color: Colors.white),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        'projects'.toUpperCase(),
        style: h3TextStyle.copyWith(color: MyColors.grey),
      ),
    ],
  ),
  Column(
    children: [
      Text(
        '6+',
        style: h2TextStyle.copyWith(color: Colors.white),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        'markets'.toUpperCase(),
        style: h3TextStyle.copyWith(color: MyColors.grey),
      ),
    ],
  ),
  Column(
    children: [
      Text(
        '8+',
        style: h2TextStyle.copyWith(color: Colors.white),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        'years of experience'.toUpperCase(),
        style: h3TextStyle.copyWith(color: MyColors.grey),
      ),
    ],
  ),
];
