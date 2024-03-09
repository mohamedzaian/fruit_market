part of 'get_stone_fruit_cubit.dart';

@immutable
abstract class GetStoneFruitState {}

class GetStoneFruitInitial extends GetStoneFruitState {}
class GetStoneLoadin extends GetStoneFruitState {}
class GetStoneSuccess extends GetStoneFruitState {
  final List product;

  GetStoneSuccess({required this.product});
}