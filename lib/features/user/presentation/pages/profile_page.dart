import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/core/utils/custom_toast.dart';
import 'package:flutter_chat_app/core/widgets/custom_button.dart';
import 'package:flutter_chat_app/features/injection_container.dart';
import 'package:flutter_chat_app/features/storage/domain/use_cases/upload_profile_image_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/widgets/form_container_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  bool _loading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _statusController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: BlocBuilder<SingleUserCubit, SingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is SingleUserLoading) {
            return const Center(
              child: SpinKitThreeBounce(
                color: AppColors.blueColor,
                size: 40,
              ),
            );
          }

          if (singleUserState is SingleUserSuccess) {
            return _bodyWidget(singleUserState.currentUser);
          }

          if (singleUserState is SingleUserFailed) {
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
      ),
    );
  }

  Future getImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          return;
        }
      });
    } catch (e) {
      toast(message: "error $e");
    }
  }

  Widget _bodyWidget(UserEntity currentUser) {
    _nameController.value = TextEditingValue(text: "${currentUser.name}");
    _emailController.value = TextEditingValue(text: "${currentUser.email}");
    _statusController.value = TextEditingValue(text: "${currentUser.status}");

    showImage() {
      if (currentUser.profileUrl == "") {
        return IMAGES.profileDefault;
      } else {
        return currentUser.profileUrl!;
      }
    }

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () {
                getImage();
              },
              //select image
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        _image!.absolute,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CachedNetworkImage(
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
          sizeVer(15),
          Text(
            'Remove profile photo',
            style: fEncodeSansMedium.copyWith(
                color: AppColors.blueColor, fontSize: 16),
          ),
          sizeVer(15),
          FormContainerWidget(
            hintText: "Username",
            prefixIcon: const Icon(Icons.person),
            controller: _nameController,
          ),
          sizeVer(15),
          FormContainerWidget(
            hintText: "Email",
            prefixIcon: const Icon(Icons.email),
            controller: _emailController,
          ),
          sizeVer(15),
          FormContainerWidget(
            hintText: "Status",
            prefixIcon: const Icon(Icons.data_array),
            controller: _statusController,
          ),
          sizeVer(30),
          CustomButton(
            title: "Update",
            loading: _loading,
            onTap: () {
              _loading ? () {} : _updateProfile(currentUser.uid!);
            },
          )
        ],
      ),
    );
  }

  void _updateProfile(String uid) {
    if (_image != null) {
      setState(() {
        _loading = true;
      });

      locator<UploadImageProfileUseCase>().call(file: _image!).then(
        (imageUrl) {
          BlocProvider.of<UserCubit>(context)
              .getUpdateUser(
            user: UserEntity(
              uid: uid,
              name: _nameController.text,
              status: _statusController.text,
              profileUrl: imageUrl,
            ),
          )
              .then((value) {
            toast(message: "updated profile", backGroundColor: Colors.green);
            setState(() {
              _loading = false;
              _image = null;
            });
          });
        },
      );
    } else {
      setState(() {
        _loading = true;
      });
      BlocProvider.of<UserCubit>(context).getUpdateUser(
        user: UserEntity(
          uid: uid,
          name: _nameController.text,
          status: _statusController.text,
        ),
      );
      toast(message: "updated profile", backGroundColor: Colors.green);
      setState(() {
        _loading = false;
      });
    }
  }
}
