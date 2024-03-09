import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/screen/complete_info_screen.dart';
import 'package:fruit_market/utils/firestore_key.dart';

import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  Future<void> login(
      String name,
      String phone,
      String address,


      ) async {
    if (FirebaseAuth.instance.currentUser != null)
      try {
        emit(loading());
        {


          await FirebaseFirestore.instance.collection(FireStoreKey().userCollection).add(
              {'name': name, 'phone': phone, 'adress': address});
        }
        emit(success());
      } on Exception catch (e) {
        emit(faild(message: e.toString()));
      }
  }
}
