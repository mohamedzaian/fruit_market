part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}
class loading extends AddProductState {}
class success extends AddProductState {}
class faild extends AddProductState {
  final String message;

  faild({required this.message});
}
