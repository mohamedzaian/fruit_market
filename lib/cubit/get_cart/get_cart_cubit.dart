import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_market/utils/firestore_key.dart';
import 'package:meta/meta.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit() : super(GetCartInitial());
  Future getCart() async {
    final List cart = [];


    emit (GetCartLoading ()
    );

    final uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FireStoreKey().cartCollection)
        .where(FireStoreKey().userid, isEqualTo: uid)
        .get();

    querySnapshot.docs.forEach((docs) {
    Map<String, dynamic> data = {
    'name': docs['name'],
    'price': docs['price'],
    'image': docs['image'],
    'id': docs['id'],
    'count': 1,
    'date': docs['date'],
    'hour': docs['hour'],
    };

    cart.add(data);

    emit(GetCartSucces(listOfItems: cart));

    });
  if (cart.isEmpty)

    emit(CartEmpty(items: cart));
  }


}
