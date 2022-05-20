import 'package:empat_landing/config/my_colors.dart';
import 'package:empat_landing/config/style.dart';
import 'package:empat_landing/data/consts.dart';
import 'package:empat_landing/widgets/buttons/black_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main_cubit.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  double height = 0;
  double textOpacity = 0;
  double footerOpacity = 0;
  List<double> socialMediaIconOpacity = [0, 0, 0];
  List<Alignment> socialMediaIconsAlignment = [
    Alignment.bottomCenter,
    Alignment.bottomCenter,
    Alignment.bottomCenter
  ];
  double contactUsOpacity = 0;
  Alignment contactUsAlignment = Alignment.bottomCenter;
  double projectsOpacity = 1;
  Alignment projectsAlignment = Alignment.center;
  double projectsOpacity2 = 0;
  Alignment projectsAlignment2 = Alignment.bottomCenter;
  double companyOpacity = 1;
  Alignment companyAlignment = Alignment.center;
  double companyOpacity2 = 0;
  Alignment companyAlignment2 = Alignment.bottomCenter;
  double footerHeight = 240;
  Color bottomColor = MyColors.electric;
  Color topColor = MyColors.lightBlue;
  Alignment gradientBegin = Alignment.bottomLeft;
  Alignment gradientEnd = Alignment.topRight;
  int index = 0;

  Duration animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    beginAnimate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<MainCubit, MainState>(listener: (context, state) {
      if (state.beginCloseMenu) {
        endAnimation();
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedContainer(
          curve: Curves.easeInCubic,
          duration: const Duration(milliseconds: 500),
          width: size.width,
          height: height,
          child: AnimatedContainer(
            duration: const Duration(seconds: 3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: gradientBegin,
                end: gradientEnd,
                colors: [bottomColor, topColor],
              ),
            ),
            onEnd: () {
              animateGradient();
            },
            child: body(context, state, size),
          ),
        ),
      );
    });
  }

  SingleChildScrollView body(
          BuildContext context, MainState state, Size size) =>
      SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: MediaQuery.of(context).size.width > 600
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    textHeader(size),
                    MediaQuery.of(context).size.height > 800
                        ? footer(size)
                        : const SizedBox(),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textAdaptiveHeader(size),
                  ],
                ),
        ),
      );

  AnimatedOpacity footer(Size size) {
    return AnimatedOpacity(
      duration: animationDuration,
      opacity: footerOpacity,
      child: Row(
        children: [
          socialMediaFooter(size),
          contactUsFooter(size),
        ],
      ),
    );
  }

  AnimatedContainer contactUsFooter(Size size) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(vertical: footerHeight / 4),
      duration: animationDuration,
      height: footerHeight,
      width: size.width * 0.6,
      color: Colors.white,
      child: AnimatedAlign(
        duration: animationDuration,
        alignment: contactUsAlignment,
        child: AnimatedOpacity(
          duration: animationDuration,
          opacity: contactUsOpacity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'A project with empat?',
                style: h2TextStyle,
              ),
              const SizedBox(
                width: 25,
              ),
              BlackButton(label: 'Contact us', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer socialMediaFooter(Size size) {
    return AnimatedContainer(
      duration: animationDuration,
      height: footerHeight,
      width: size.width * 0.4,
      color: Colors.black,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          socialMediaIcons.length,
          (index) => SizedBox(
            height: 100,
            child: AnimatedAlign(
              duration: animationDuration,
              alignment: socialMediaIconsAlignment[index],
              child: AnimatedOpacity(
                opacity: socialMediaIconOpacity[index],
                duration: animationDuration,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: socialMediaIcons[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox textHeader(Size size) {
    return SizedBox(
      width: size.width * 0.6,
      child: AnimatedOpacity(
        duration: animationDuration,
        opacity: textOpacity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            projectsServicesText(),
            SizedBox(
              height: size.height * 0.02,
            ),
            companyBlogText(),
            SizedBox(
              height: size.height * 0.15,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox textAdaptiveHeader(Size size) {
    return SizedBox(
      width: size.width * 0.6,
      child: AnimatedOpacity(
        duration: animationDuration,
        opacity: textOpacity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'projects'.toUpperCase(),
              style: h6TextStyle.copyWith(color: Colors.white),
            ),
            Text(
              'services'.toUpperCase(),
              style: h6TextStyle.copyWith(color: Colors.white),
            ),
            Text(
              'company'.toUpperCase(),
              style: h6TextStyle.copyWith(color: Colors.white),
            ),
            Text(
              'blog'.toUpperCase(),
              style: h6TextStyle.copyWith(color: Colors.white),
            ),
            BlackButton(label: 'Contact Us'.toUpperCase(), onTap: () {}),
          ],
        ),
      ),
    );
  }

  MouseRegion projectsServicesText() {
    return MouseRegion(
      onHover: (eve) {
        setState(() {
          projectsAlignment = Alignment.topCenter;
          projectsAlignment2 = Alignment.center;
          projectsOpacity = 0;
          projectsOpacity2 = 1;
        });
      },
      onExit: (eve) {
        setState(() {
          projectsAlignment = Alignment.center;
          projectsAlignment2 = Alignment.bottomCenter;
          projectsOpacity = 1;
          projectsOpacity2 = 0;
        });
      },
      child: Stack(
        children: [
          duoText(
              text: 'Projects - services',
              opacity: projectsOpacity2,
              alignment: projectsAlignment2),
          duoText(
              text: 'Projects - services',
              opacity: projectsOpacity,
              alignment: projectsAlignment),
        ],
      ),
    );
  }

  MouseRegion companyBlogText() {
    return MouseRegion(
      onHover: (eve) {
        setState(() {
          companyAlignment = Alignment.topCenter;
          companyAlignment2 = Alignment.center;
          companyOpacity = 0;
          companyOpacity2 = 1;
        });
      },
      onExit: (eve) {
        setState(() {
          companyAlignment = Alignment.center;
          companyAlignment2 = Alignment.bottomCenter;
          companyOpacity = 1;
          companyOpacity2 = 0;
        });
      },
      child: Stack(
        children: [
          duoText(
              text: 'Company - blog',
              opacity: companyOpacity2,
              alignment: companyAlignment2),
          duoText(
              text: 'Company - Blog',
              opacity: companyOpacity,
              alignment: companyAlignment),
        ],
      ),
    );
  }

  Container duoText(
      {required String text,
      required double opacity,
      required Alignment alignment}) {
    return Container(
      height: 150,
      color: Colors.transparent,
      child: AnimatedAlign(
        duration: animationDuration,
        alignment: alignment,
        child: AnimatedOpacity(
          duration: animationDuration,
          opacity: opacity,
          child: Text(
            text.toUpperCase(),
            style: h6TextStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void animateGradient() {
    if (mounted) {
      setState(() {
        index = index + 1;
        // animate the color
        bottomColor = gradientColorList[index % gradientColorList.length];
        topColor = gradientColorList[(index + 1) % gradientColorList.length];
        // animate the alignment
        gradientBegin =
            menuGradientAlignmentList[index % menuGradientAlignmentList.length];
        gradientEnd = menuGradientAlignmentList[
            (index + 2) % menuGradientAlignmentList.length];
      });
    }
  }

  void beginAnimate() {
    Future.delayed(const Duration(milliseconds: 10), () {
      if (mounted) {
        setState(() {
          bottomColor = MyColors.lightElectric;
          height = MediaQuery.of(context).size.height;
        });
      }
      animateBody();
    });
  }

  animateSocialMediaIcons() async {
    for (int i = 0; i < socialMediaIconsAlignment.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200), () {
        //animate contact us line
        setState(() {
          socialMediaIconOpacity[i] = 1;
          socialMediaIconsAlignment[i] = Alignment.center;
        });
      });
    }
    animateContactUs();
  }

  animateContactUs() {
    Future.delayed(const Duration(milliseconds: 200), () {
      //animate contact us line
      if (mounted) {
        setState(() {
          contactUsAlignment = Alignment.center;
          contactUsOpacity = 1;
        });
      }
    });
  }

  animateFooter() {
    Future.delayed(const Duration(milliseconds: 200), () {
      // animate footer block
      if (mounted) {
        setState(() {
          footerOpacity = 1;
          footerHeight = 250;
        });
        animateSocialMediaIcons();
      }
    });
  }

  animateBody() {
    Future.delayed(const Duration(milliseconds: 600), () {
      //animate header text
      if (mounted) {
        setState(() {
          textOpacity = 1;
        });
      }
      animateFooter();
    });
  }

  endAnimation() {
    //hide all elements
    if (mounted) {
      setState(() {
        height = 0;
        footerOpacity = 0;
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            textOpacity = 0;
          });
        });
      });
    }
  }
}
