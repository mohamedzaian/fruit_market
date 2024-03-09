

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_market/cubit/get_favorite_product/get_favorite_product_cubit.dart';
import 'package:fruit_market/utils/firestore_key.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());

  Future addToCart (
      String name,
      double price,
      String image,

      )async
  {
    final uid =  FirebaseAuth.instance.currentUser!.uid;
    final id = FirebaseFirestore.instance.collection(FireStoreKey().cartCollection).doc().id;
    try {
      emit(AddToCartLoading());
     await FirebaseFirestore.instance.collection(FireStoreKey().cartCollection).doc(id).set({
        'name': name,
        'price': price,
        FireStoreKey().userid:uid,
        'image': image,
       'id':id,
       'date':DateFormat.yMEd('en_US').format(DateTime.now()),
       'hour':DateFormat.Hm('en_US').format(DateTime.now()),

      });
      emit(AddToCartSucces(message: 'it is added to cart'));
    } on Exception catch (e) {

      emit(AddToCartFaild(message: e.toString()));
    }




  }

}
