import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:flutter_chat_app/features/group/presentation/cubit/group/group_cubit.dart';
import 'package:flutter_chat_app/features/injection_container.dart';
import 'package:flutter_chat_app/features/storage/domain/use_cases/upload_group_image_usecase.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/core/utils/custom_toast.dart';
import 'package:flutter_chat_app/core/widgets/custom_button.dart';
import 'package:flutter_chat_app/features/user/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_chat_app/features/user/presentation/widgets/form_container_widget.dart';

import '../../../../config/theme/app_styles.dart';

class CreateGroupPage extends StatefulWidget {
  final String uid;
  const CreateGroupPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  File? _groupImage;
  bool _loading = false;

  final TextEditingController _groupController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _groupController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: customAppBar(title: "create group"),
      body: _bodyWidget(),
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
          _groupImage = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast(message: "error $e");
      print(e);
    }
  }

  Widget _bodyWidget() {
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
              child: _groupImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        _groupImage!.absolute,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CachedNetworkImage(
                      //check image url is empty show default image
                      imageUrl: IMAGES.profileDefault,

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
            'Add group image',
            style: fEncodeSansMedium.copyWith(
                color: AppColors.blueColor, fontSize: 16),
          ),
          sizeVer(15),
          FormContainerWidget(
            hintText: "Group",
            prefixIcon: const Icon(Icons.group),
            controller: _groupController,
          ),
          sizeVer(30),
          CustomButton(
            title: "Create group",
            loading: _loading,
            onTap: () {
              _loading ? () {} : _createGroup();
            },
          )
        ],
      ),
    );
  }

  void _createGroup() {
    if (_groupController.text.isEmpty) {
      toast(message: 'Enter Group name', backGroundColor: Colors.red);
      return;
    }
    if (_groupImage == null) {
      toast(message: 'Please select an image', backGroundColor: Colors.red);
      return;
    }

    if (_groupImage != null) {
      setState(() {
        _loading = true;
      });
      toast(message: "Please wait...");

      locator<UploadGroupImageUseCase>()
          .call(file: _groupImage!)
          .then((imageUrl) {
        BlocProvider.of<GroupCubit>(context)
            .getCreateGroup(
          groupEntity: GroupEntity(
            createAt: Timestamp.now(),
            lastMessage: "",
            groupName: _groupController.text,
            uid: widget.uid,
            groupProfileImage: imageUrl,
          ),
        )
            .then((value) {
          toast(
              message: "Group created successfully",
              backGroundColor: Colors.green);

          _clear();
          Navigator.pop(context);
        });
      });
    }
  }

  void _clear() {
    setState(() {
      _groupController.clear();
      _groupImage = null;
      _loading = false;
    });
  }
}
