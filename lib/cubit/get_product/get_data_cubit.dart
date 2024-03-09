import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_market/models/product_model.dart';
import 'package:meta/meta.dart';

import '../../utils/firestore_key.dart';
import 'package:hive/hive.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(GetDataInitial());
  Future<void> getOrganicFruits() async {
    emit(loading());
    List<Productmodel> productOrganicFruits = [];
    final querySnapshot = await FirebaseFirestore.instance
        .collection(FireStoreKey().productCollection)
        .where('category', isEqualTo: 'Organic Fruits')
        .get();
    querySnapshot.docs.forEach((product) async {
      final productModel = Productmodel.fromJson(product.data());
      productOrganicFruits.add(productModel);
    });
    await Hive.openBox('features123');
    late Box myBox;
    myBox = Hive.box('features123');

    myBox.addAll(productOrganicFruits);
    final list = myBox.values.toList();
    final listoffruit = list.toSet().toList();

    (emit(success(product: listoffruit)));
  }
}
