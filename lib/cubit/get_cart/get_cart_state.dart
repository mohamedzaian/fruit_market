part of 'get_cart_cubit.dart';

@immutable
abstract class GetCartState {}

class GetCartInitial extends GetCartState {}
class GetCartLoading extends GetCartState {}
class CartEmpty extends GetCartState {
  final List items ;

  CartEmpty({required this.items});

}


class GetCartSucces extends GetCartState {
  final List listOfItems;
  // final double total;


  GetCartSucces(   {
    // required this.total,
    required this.listOfItems});
}
