import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:flutter_chat_app/features/group/domain/entities/single_chat_entity.dart';
import 'package:flutter_chat_app/features/group/presentation/cubit/group/group_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GroupPage extends StatefulWidget {
  final String uid;

  const GroupPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.group),
        onPressed: () {
          Navigator.pushNamed(context, PageConst.createGroup,
              arguments: widget.uid);
        },
      ),
      body: BlocBuilder<SingleUserCubit, SingleUserState>(
          builder: (context, singleUserState) {
        if (singleUserState is SingleUserSuccess) {
          final currentUser = singleUserState.currentUser;
          return BlocBuilder<GroupCubit, GroupState>(
            builder: (context, groupState) {
              if (groupState is GroupLoading) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.blueColor,
                    size: 50,
                  ),
                );
              }

              if (groupState is GroupSuccess) {
                final List<GroupEntity> groups = groupState.groups;

                if (groups.isEmpty) {
                  return Center(
                    child: Text(
                      "No groups have been created !",
                      style: fEncodeSansBold.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final groupInfo = groups[index];
                    //show default image or profile image

                    showImage() {
                      if (groups[index].groupProfileImage == "") {
                        return IMAGES.profileDefault;
                      } else {
                        return groups[index].groupProfileImage!;
                      }
                    }

                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PageConst.singleChat,
                          arguments: SingleChatEntity(
                            groupId: groupInfo.groupId!,
                            groupName: groupInfo.groupName!,
                            uid: currentUser.uid!,
                            username: currentUser.name!,
                          ),
                        );
                      },
                      title: Text(
                        groupInfo.groupName!,
                        style: fEncodeSansBold.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      subtitle: Text(
                        "${groupInfo.lastMessage}",
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
                    );
                  },
                );
              }

              if (groupState is GroupFailed) {
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

              return Container();
            },
          );
        }

        return const Center(
          child: SpinKitThreeBounce(
            color: AppColors.blueColor,
            size: 50,
          ),
        );
      }),
    );
  }
}
