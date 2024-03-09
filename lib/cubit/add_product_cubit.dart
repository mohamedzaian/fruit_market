import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruit_market/utils/firestore_key.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';
TextEditingController name = TextEditingController();
TextEditingController price = TextEditingController();
TextEditingController category = TextEditingController();
TextEditingController image = TextEditingController();

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  addProduct(

      TextEditingController name,
      TextEditingController price,
     String category,
      TextEditingController image,

      ) async
  {
    try {
      emit(loading());
      final id = await FirebaseFirestore.instance.collection(FireStoreKey().productCollection).doc().id;

      await FirebaseFirestore.instance.collection(FireStoreKey().productCollection).doc(id).set(
        {
          'name':name.text,
          'price':price.text,
          'category':category,
          'image':image.text,
          'id':id,

        }

      );
      emit(success());
      name.clear();
      price.clear();
      image.clear();
    } on Exception catch (e) {
  emit(faild(message: e.toString()));
    }

  }
}

