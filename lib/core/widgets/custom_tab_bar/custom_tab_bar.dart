import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/blocs/tab_bar_cubit.dart/tab_bar_cubit.dart';
import 'package:flutter_chat_app/core/widgets/custom_tab_bar/custom_tab_bar_item.dart';

class CustomTabBar extends StatelessWidget {
  final PageController controller;

  const CustomTabBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, int>(
      builder: (context, index) {
        return Container(
          height: 50,
          decoration: const BoxDecoration(
            color: AppColors.backGroundColorBottomNav,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTabBarItem(
                  width: 50,
                  text: "Groups",
                  textColor: index == 0
                      ? AppColors.blueColor
                      : AppColors.secondaryColor,
                  borderColor:
                      index == 0 ? AppColors.blueColor : Colors.transparent,
                  onTap: () {
                    BlocProvider.of<TabBarCubit>(context)
                        .changeSelectedIndex(0);
                    controller.jumpToPage(0);
                  },
                ),
              ),
              Expanded(
                child: CustomTabBarItem(
                  text: "Users",
                  textColor: index == 1
                      ? AppColors.blueColor
                      : AppColors.secondaryColor,
                  borderColor:
                      index == 1 ? AppColors.blueColor : Colors.transparent,
                  onTap: () {
                    BlocProvider.of<TabBarCubit>(context)
                        .changeSelectedIndex(1);
                    controller.jumpToPage(1);
                  },
                ),
              ),
              Expanded(
                child: CustomTabBarItem(
                  text: "Profile",
                  textColor: index == 2
                      ? AppColors.blueColor
                      : AppColors.secondaryColor,
                  borderColor:
                      index == 2 ? AppColors.blueColor : Colors.transparent,
                  onTap: () {
                    BlocProvider.of<TabBarCubit>(context)
                        .changeSelectedIndex(2);
                    controller.jumpToPage(2);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
