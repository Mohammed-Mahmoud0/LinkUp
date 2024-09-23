import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/features/settings/logic/settings_cubit.dart';

void selectImage(
    BuildContext context, Function(Uint8List) onImageSelected) async {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorsManager.backgroundDark,
    showDragHandle: true,
    builder: (BuildContext ctx) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(IconBroken.Camera),
              title: Text('Take a photo'),
              onTap: () async {
                Navigator.of(ctx).pop();
                Uint8List img = await pickImage(ImageSource.camera);
                onImageSelected(img);
              },
            ),
            ListTile(
              leading: Icon(IconBroken.Image),
              title: Text('Choose from gallery'),
              onTap: () async {
                Navigator.of(ctx).pop();
                Uint8List img = await pickImage(ImageSource.gallery);
                onImageSelected(img);
              },
            ),
            ListTile(
              leading: Icon(IconBroken.Delete),
              title: Text('Remove Photo'),
              onTap: () async {
                Navigator.of(ctx).pop();
                BlocProvider.of<SettingsCubit>(context).deleteProfileImage();
              },
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
  return null;
}
