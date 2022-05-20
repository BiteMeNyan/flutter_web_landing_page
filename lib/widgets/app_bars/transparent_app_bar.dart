import 'dart:ui';

import 'package:empat_landing/config/style.dart';
import 'package:empat_landing/cubit/main_cubit.dart';
import 'package:empat_landing/widgets/buttons/black_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TransparentAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.width * 0.15
                    : 10),
            height: MediaQuery.of(context).size.height * 0.2,
            color: Colors.transparent,
            child: body(context, state),
          ),
        ),
      );
    });
  }

  Row body(BuildContext context, MainState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: MediaQuery.of(context).size.width > 600
          ? [
              menuButton(context, state),
              title(state),
              contactButton(state),
            ]
          : [
              title(state),
              menuButton(context, state),
            ],
    );
  }

  Opacity contactButton(MainState state) {
    return Opacity(
      opacity: !state.showMenu ? 1 : 0,
      child: BlackButton(
        label: 'Contact Us',
        onTap: () {},
      ),
    );
  }

  Text title(MainState state) => Text(
        'empat',
        style: h2TextStyle.copyWith(
            color: !state.showMenu ? Colors.black : Colors.white,
            fontWeight: FontWeight.w900),
      );

  InkWell menuButton(BuildContext context, MainState state) {
    return InkWell(
      onTap: () {
        if (!state.showMenu) {
          context.read<MainCubit>().openMenu();
        } else {
          context.read<MainCubit>().closeMenu();
        }
      },
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: !state.showMenu ? 1 : 0,
            child: Icon(
              Icons.menu_sharp,
              color: !state.showMenu ? Colors.black : Colors.white,
              size: 50,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: state.showMenu ? 1 : 0,
            child: const Icon(
              Icons.cancel,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20);
}
