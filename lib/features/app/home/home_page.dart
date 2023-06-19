import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/blocs/tab_bar_cubit.dart/tab_bar_cubit.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/core/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/auth/auth_cubit.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();

  List<Widget> pages = [
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backGroundColorBottomNav,
        title: Text(
          "Group chat",
          style: fEncodeSansBold.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          const Icon(Icons.search),
          sizeHor(15),
          PopupMenuButton(
            child: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).logout();
                  },
                  child: Text("Logout"),
                ),
              ];
            },
          ),
          sizeHor(15)
        ],
      ),
      body: Column(
        children: [
          CustomTabBar(
            controller: pageController,
          ),
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                BlocProvider.of<TabBarCubit>(context)
                    .changeSelectedIndex(index);
              },
              controller: pageController,
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}
