part of 'get_data_cubit.dart';

@immutable
abstract class GetDataState {}

class GetDataInitial extends GetDataState {}
class loading extends GetDataState {}
class success extends GetDataState {
  final List product;

  success({required this.product});
}





