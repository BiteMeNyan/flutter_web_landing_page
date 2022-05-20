import 'dart:ui';

import 'package:empat_landing/config/style.dart';
import 'package:flutter/material.dart';

import '../../config/my_colors.dart';

class ServiceTile extends StatefulWidget {
  const ServiceTile({
    Key? key,
    required this.label,
    required this.description,
    required this.color,
  }) : super(key: key);

  final String label;
  final String description;
  final Color color;

  @override
  _ServiceTileState createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  final ScrollController _scrollController = ScrollController();
  int speedFactor = 40; //speed of animation (text scroll)
  bool isHovered = false; //detect whether widget is hovered

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MouseRegion(
      onEnter: (eve) {
        startScrolling();
      },
      onExit: (eve) {
        endScrolling();
      },
      child: Container(
        width: size.width * 0.35,
        height: size.height * 0.55,
        color: Colors.white,
        child: Stack(
          children: [
            if (isHovered) blurredBg(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  animatedText(size),
                  footer(size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center blurredBg() {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: widget.color,
            ),
          ),
          //blur
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30.0,
                sigmaY: 30.0,
              ),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding footer(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.label.toUpperCase(),
            style: h3TextStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          size.width > 900
              ? Text(
                  widget.description,
                  style: h3TextStyle.copyWith(color: MyColors.grey),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  SizedBox animatedText(Size size) {
    return SizedBox(
      height: size.height * 0.25,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                widget.label,
                style: h1TextStyle.copyWith(
                    color: MyColors.lightGrey,
                    letterSpacing: 10,
                    fontSize: 180),
              ),
            ),
          ),
        ),
      ),
    );
  }

  startScrolling() {
    setState(() {
      isHovered = true;
    });
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear);
  }

  endScrolling() {
    setState(() {
      isHovered = false;
    });
    _scrollController.animateTo(_scrollController.offset,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }
}
