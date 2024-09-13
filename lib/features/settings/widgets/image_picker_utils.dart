import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/features/settings/logic/settings_cubit.dart';

void selectImage(BuildContext context, Function(Uint8List) onImageSelected) async {
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
                  if (img != null) {
                    onImageSelected(img);
                  }
                },
                splashColor: Colors.transparent,
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  Uint8List img = await pickImage(ImageSource.gallery);
                  if (img != null) {
                    onImageSelected(img);
                  }
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
    return null;
  }