// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';

class ProfileImageWidget extends StatefulWidget {
  ProfileImageWidget({
    super.key,
  });

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  Uint8List? image;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image != null
            ? CircleAvatar(
                backgroundColor: ColorsManager.dark,
                backgroundImage: MemoryImage(image!),
                radius: 64.r,
              )
            : CircleAvatar(
                backgroundColor: ColorsManager.dark,
                radius: 64.r,
                child: Icon(
                  IconBroken.Profile,
                  size: 64.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
        Positioned(
          bottom: -5,
          right: -5,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => selectImage(context),
            icon: Icon(
              Icons.add_circle,
            ),
          ),
        ),
      ],
    );
  }

  selectImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.backgroundDark,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a photo'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  Uint8List img = await pickImage(ImageSource.camera);
                  setState(() {
                    image = img;
                    saveImage();
                  });
                },
                splashColor: Colors.transparent,
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  Uint8List img = await pickImage(ImageSource.gallery);
                  setState(() {
                    image = img;
                    saveImage();
                  });
                },
                splashColor: Colors.transparent,
              ),
            ],
          ),
        );
      },
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    XFile? file = await picker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    }
    log('no file selected');
  }

  void saveImage() async {
    String resp = await saveData(image: image!);
  }

  Future<String> saveData({required Uint8List image}) async {
    try {
      String imageUrl = await uploadImage('profileImage', image);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profileImage': imageUrl,
      });
      log('********************************');
      log('image uploaded successfully');
      log('********************************');
      return 'Image uploaded successfully';
    } on Exception catch (e) {
      log('********************************');
      log(e.toString());
      log('********************************');
      return e.toString();
    }
  }

  Future<String> uploadImage(String name, Uint8List image) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    Reference ref = storage.ref().child(name).child(uid);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
