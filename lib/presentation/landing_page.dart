import 'package:carousel_slider/carousel_slider.dart';
import 'package:empat_landing/config/my_colors.dart';
import 'package:empat_landing/config/style.dart';
import 'package:empat_landing/cubit/main_cubit.dart';
import 'package:empat_landing/widgets/buttons/black_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../data/consts.dart';
import '../widgets/app_bars/transparent_app_bar.dart';
import '../widgets/cursors/show_case_cursor.dart';
import 'menu_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Offset pointer = const Offset(0, 0); //is used to save cursor position
  bool isCarouselHovered = false; //is used to slow carousel
  double scrollPosition = 0;
  bool isScrollDown =
      true; // to control scroll direction and run animation correctly

  //animation
  Duration animationDuration = const Duration(milliseconds: 300);
  late double servicesHeaderOpacity;
  List<double> servicesOpacity = [];
  List<Alignment> servicesAlignment = [];
  List<double> partnersHeaderOpacity = [];
  List<double> partnersOpacity = [];
  List<Alignment> partnersAlignment = [];

  @override
  void initState() {
    setInitialOpacityAndPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const TransparentAppBar(),
        body: Stack(
          children: [
            NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (scrollPosition <= notification.metrics.pixels) {
                  scrollPosition = notification.metrics.pixels;
                  isScrollDown = true;
                } else {
                  scrollPosition = notification.metrics.pixels;
                  isScrollDown = false;
                }
                return true;
              },
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      headerText(size),
                      carousel(size),
                      services(size),
                      partners(size),
                      footer(size),
                    ],
                  ),
                ),
              ),
            ),
            //show menu if it is opened
            state.showMenu ? const MenuScreen() : const SizedBox(),
          ],
        ),
      );
    });
  }

  Widget headerText(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.06 + kToolbarHeight + 20),
        SizedBox(
          width: size.width > 700 ? size.width * 0.6 : size.width * 0.9,
          child: Text(
            'It-products development.'.toUpperCase(),
            style: h1TextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: size.width > 600 ? size.width * 0.6 : size.width * 0.9,
          child: Text(
            'With empathy.'.toUpperCase(),
            style: h1TextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          width: size.width * 0.6,
          child: Text(
            'Build your digital ecosystem for business empowerment'
                .toUpperCase(),
            style: h3TextStyle.copyWith(color: MyColors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget carousel(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.08),
        Stack(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.none,
              onExit: (eve) {
                //hide cursor
                onEndHover();
              },
              onHover: (eve) {
                //save cursor position
                onHover(eve);
              },
              child: CarouselSlider(
                options: carouselOptions(size),
                items: carouselItems.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return carouselItem(item);
                    },
                  );
                }).toList(),
              ),
            ),
            //show custom cursor
            AnimatedPositioned(
              duration: const Duration(milliseconds: 10),
              left: pointer.dx,
              top: pointer.dy - 300,
              child: const ShowCaseCursor(),
            ),
          ],
        ),
        // see all cases button
        SizedBox(height: size.height * 0.03),
        BlackButton(label: 'See all cases', onTap: () {}),
        SizedBox(height: size.height * 0.065),
      ],
    );
  }

  Widget carouselItem(String item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: const BoxDecoration(color: Colors.amber),
      child: Image.asset(
        'assets/$item.png',
        fit: BoxFit.fill,
      ),
    );
  }

  CarouselOptions carouselOptions(Size size) {
    return CarouselOptions(
      aspectRatio: 1,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      viewportFraction: size.width > 800
          ? 0.4
          : size.width > 650 && size.width <= 800
              ? 0.7
              : 1,
      height: size.height * 0.6,
      autoPlay: true,
      autoPlayCurve: Curves.linear,
      autoPlayInterval: const Duration(milliseconds: 100),
      autoPlayAnimationDuration: isCarouselHovered
          ? const Duration(seconds: 6)
          : const Duration(seconds: 4),
    );
  }

  Widget services(Size size) {
    return Container(
      width: size.width,
      color: MyColors.lightGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          servicesHeader(size),
          SizedBox(
            width: size.width * 0.7 + 40,
            child: Wrap(
              children: List.generate(servicesTiles.length, (index) {
                String delay = '${index}00';
                return VisibilityDetector(
                  onVisibilityChanged: (VisibilityInfo info) {
                    Future.delayed(Duration(milliseconds: int.parse(delay)),
                        () {
                      if (info.visibleFraction > 0.2) {
                        setState(() {
                          servicesOpacity[index] = 1;
                          servicesAlignment[index] = Alignment.topCenter;
                        });
                      } else {
                        if (!isScrollDown) {
                          setState(() {
                            servicesOpacity[index] = 0;
                            servicesAlignment[index] = Alignment.bottomCenter;
                          });
                        }
                      }
                    });
                  },
                  key: Key('service_tile$index'),
                  child: SizedBox(
                    width: size.width * 0.35,
                    height: size.height * 0.55,
                    child: AnimatedAlign(
                      duration: animationDuration,
                      alignment: servicesAlignment[index],
                      child: AnimatedOpacity(
                        opacity: servicesOpacity[index],
                        duration: animationDuration,
                        child: servicesTiles[index],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // see all services button
          SizedBox(height: size.height * 0.01),
          BlackButton(label: 'See all services', onTap: () {}),
          SizedBox(height: size.height * 0.06),
        ],
      ),
    );
  }

  Widget footer(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.1, horizontal: size.width * 0.2),
      width: size.width,
      color: MyColors.lightGrey,
      child: size.width > 950
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: aboutUsText[index],
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    2,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: aboutUsText[index + 4],
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: aboutUsText[index + 6],
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    2,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: aboutUsText[index + 10],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: List.generate(
                aboutUsText.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: aboutUsText[index],
                ),
              ),
            ),
    );
  }

  Widget partners(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      width: size.width,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.08,
          ),
          //achievements
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(achievements.length, (index) {
              String delay = '${index}00';
              return VisibilityDetector(
                onVisibilityChanged: (VisibilityInfo info) {
                  Future.delayed(Duration(milliseconds: int.parse(delay)), () {
                    if (info.visibleFraction > 0.2) {
                      setState(() {
                        partnersHeaderOpacity[index] = 1;
                      });
                    } else {
                      if (!isScrollDown) {
                        setState(() {
                          partnersHeaderOpacity[index] = 0;
                        });
                      }
                    }
                  });
                },
                key: Key('achievement$index'),
                child: AnimatedOpacity(
                  duration: animationDuration,
                  opacity: partnersHeaderOpacity[index],
                  child: SizedBox(
                    child: achievements[index],
                    width: size.width * 0.25,
                  ),
                ),
              );
            }),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
          // partners
          Wrap(
            spacing: 50,
            runSpacing: 30,
            children: List.generate(9, (index) {
              String delay = '${index}00';
              return VisibilityDetector(
                onVisibilityChanged: (VisibilityInfo info) {
                  Future.delayed(Duration(milliseconds: int.parse(delay)), () {
                    if (info.visibleFraction > 0.2) {
                      setState(() {
                        partnersOpacity[index] = 1;
                        partnersAlignment[index] = Alignment.topCenter;
                      });
                    } else {
                      if (!isScrollDown) {
                        setState(() {
                          partnersOpacity[index] = 0;
                          partnersAlignment[index] = Alignment.bottomCenter;
                        });
                      }
                    }
                  });
                },
                key: Key('partner$index'),
                child: SizedBox(
                  height: size.height * 0.15,
                  width: 300,
                  child: AnimatedAlign(
                    duration: animationDuration,
                    alignment: partnersAlignment[index],
                    child: AnimatedOpacity(
                      duration: animationDuration,
                      opacity: partnersOpacity[index],
                      child: Image.asset('assets/partners/${index + 1}.png'),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(
            height: size.height * 0.15,
          ),
        ],
      ),
    );
  }

  Widget servicesHeader(Size size) {
    return VisibilityDetector(
      onVisibilityChanged: (visibilityInfo) {
        var visibleFraction = visibilityInfo.visibleFraction;
        if (visibleFraction > 0.2) {
          setState(() {
            servicesHeaderOpacity = 1;
          });
        } else {
          if (!isScrollDown) {
            setState(() {
              servicesHeaderOpacity = 0;
            });
          }
        }
      },
      key: const Key('services_header'),
      child: SizedBox(
        height: size.width > 900 ? size.height * 0.33 : size.height * 0.4,
        child: AnimatedOpacity(
          duration: animationDuration,
          opacity: servicesHeaderOpacity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.065),
              SizedBox(
                width: size.width > 800 ? size.width * 0.7 : size.width - 10,
                child: const Text(
                  'From the ground up',
                  style: h2TextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: size.width > 800 ? size.width * 0.6 : size.width - 10,
                child: Text(
                  'Digitize existing products and create new ones just from scratch. We use R&D, innovation, design, development and marketing to execute digital transformation.'
                      .toUpperCase(),
                  style: h3TextStyle.copyWith(color: MyColors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  void onEndHover() {
    setState(() {
      pointer = const Offset(0, 0);
      isCarouselHovered = false;
    });
  }

  void onHover(PointerHoverEvent eve) {
    setState(() {
      pointer = eve.position;
      if (!isCarouselHovered) {
        isCarouselHovered = true;
      }
    });
  }

  setInitialOpacityAndPosition() {
    animationDuration = const Duration(milliseconds: 300);
    servicesHeaderOpacity = 0;
    servicesOpacity = [0, 0, 0, 0];
    servicesAlignment = [
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter
    ];
    partnersHeaderOpacity = [0, 0, 0];
    partnersOpacity = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    partnersAlignment = [
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter,
      Alignment.bottomCenter
    ];
  }
}
