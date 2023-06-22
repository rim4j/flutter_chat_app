import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/constants/constants.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          //loading state
          if (userState is UserLoading) {
            return const Center(
              child: SpinKitThreeBounce(
                color: AppColors.blueColor,
                size: 50,
              ),
            );
          }

          //success state
          if (userState is UserSuccess) {
            final List<UserEntity> users = userState.users;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                //show default image or profile image
                showImage() {
                  if (users[index].profileUrl == "") {
                    return IMAGES.profileDefault;
                  } else {
                    return users[index].profileUrl!;
                  }
                }

                final user = users[index];
                return ListTile(
                  title: Text(
                    user.name!,
                    style: fEncodeSansBold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    user.status!,
                    style: fEncodeSansMedium.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  leading: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        //check image url is empty show default image
                        imageUrl: showImage(),

                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.favorite,
                    color: AppColors.primaryColor,
                  ),
                );
              },
            );
          }

          //error state
          if (userState is UserFailed) {
            return Center(
              child: Text(
                "something went wrong",
                style: fEncodeSansBold.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
            );
          }

          //default value
          return Container();
        },
      ),
    );
  }
}
