

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_market/models/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

import '../../utils/firestore_key.dart';

part 'get_stone_fruit_state.dart';

class GetStoneFruitCubit extends Cubit<GetStoneFruitState> {
  GetStoneFruitCubit() : super(GetStoneFruitInitial());
  Future<void> getStoneFruite(

      ) async
  {

    emit(GetStoneLoadin());
    List<Productmodel> productOrganicFruits = [];
    final querySnapshot = await FirebaseFirestore.instance
        .collection(FireStoreKey().productCollection)
        .where('category', isEqualTo: 'Stone Fruits')
        .get();
    querySnapshot.docs.forEach((product) async {
      final productModel = Productmodel.fromJson(product.data());
      productOrganicFruits.add(productModel);
    });
    await Hive.openBox('stone1223');
    late Box myBox;
    myBox = Hive.box('stone1223');

    myBox.addAll(productOrganicFruits);
    final list = myBox.values.toList();
    final listoffruit = list.toSet().toList();

    (emit(GetStoneSuccess(product: listoffruit)));
  }
}
