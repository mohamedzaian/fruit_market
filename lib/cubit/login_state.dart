part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class loading extends LoginState {}
class success extends LoginState {

}
class faild extends LoginState {
  final String message;

  faild({required this.message});
}
