import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fruit_market/utils/firestore_key.dart';
import 'package:meta/meta.dart';

part 'get_favorite_product_state.dart';

class GetFavoriteProductCubit extends Cubit<GetFavoriteProductState> {

  GetFavoriteProductCubit() : super(GetFavoriteProductInitial());
  Future getFavoriteProduct()async{

    emit(Loading());

    final uid=FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection(FireStoreKey().favoriteCollection).where('userid',isEqualTo: uid).get();
    final List favoriteProduct=[];
    querySnapshot.docs.forEach((docs) {
      Map<String,dynamic> data=
    {
      'name':docs['name'],
      'price':docs['price'],
      'image':docs['image'],
      'id':docs['id'],


    };
      favoriteProduct.add(data);
      emit(GetFavoriteSuccess(listOfFavotire: favoriteProduct));

    });
    if (favoriteProduct.isEmpty)
      emit (FavoriteIsEmpty(listOfFavotire: favoriteProduct));








  }

}
