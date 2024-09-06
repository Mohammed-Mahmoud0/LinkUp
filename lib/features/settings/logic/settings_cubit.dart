import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/core/models/user_model.dart';
import 'package:link_up/features/settings/logic/settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() async {
    emit(SettingsLoadingState());
    try {
      emit(SettingsLoadingState());
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> userData =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userData.exists) {
        userModel = UserModel.fromJson(userData.data()!);
        emit(GetUserDataSuccessState());
      } else {
        emit(GetUserDataErrorState('User data not found'));
      }
    } catch (e) {
      emit(GetUserDataErrorState(e.toString()));
    }
  }
}
