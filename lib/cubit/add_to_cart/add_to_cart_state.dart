part of 'add_to_cart_cubit.dart';

@immutable
abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}
class AddToCartLoading extends AddToCartState {}
class AddToCartSucces extends AddToCartState {
  final String message;

  AddToCartSucces({required this.message});
}
class AddToCartFaild extends AddToCartState {
  final String message;

  AddToCartFaild({required this.message});
}


