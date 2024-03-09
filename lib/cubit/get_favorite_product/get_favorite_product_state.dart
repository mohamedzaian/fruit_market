part of 'get_favorite_product_cubit.dart';

@immutable
abstract class GetFavoriteProductState {}

class GetFavoriteProductInitial extends GetFavoriteProductState {}
class Loading extends GetFavoriteProductState {

}
class GetFavoriteSuccess extends GetFavoriteProductState {
  final List listOfFavotire;

  GetFavoriteSuccess({required this.listOfFavotire});
}
class FavoriteIsEmpty extends GetFavoriteProductState {
  final List listOfFavotire;

  FavoriteIsEmpty({required this.listOfFavotire});
}
