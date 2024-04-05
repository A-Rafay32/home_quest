import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/screens/widgets/app_bar_white.dart';
import 'package:real_estate_app/features/home/screens/widgets/home_screen_app_bar.dart';

final List<Widget> appBars = [
  const HomeScreenAppBar(),
  CustomAppBar(
    enableBackButton: false,
    onPressed: () {},
    text: "Explore Estates",
  ),
  CustomAppBar(
    enableBackButton: false,
    onPressed: () {},
    text: "Explore",
  ),
  CustomAppBar(
    enableBackButton: false,
    onPressed: () {},
    text: "Profile",
  ),
];
