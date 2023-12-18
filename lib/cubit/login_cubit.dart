
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final TextEditingController phone = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController adress = TextEditingController();
  Future<void> login(
      )async
  {
    if (FirebaseAuth.instance.currentUser != null)
    try {
 
      emit(loading());



         await FirebaseFirestore.instance.collection('user').add(
       {
         'name':name.text,
         'phone':phone.text,
         'adress':adress.text
       }
         );
         phone.clear();
         name.clear();
         adress.clear();

        emit(success());
    } on Exception catch (e) {
      emit(faild(message: e.toString()));

    }








  }

}
