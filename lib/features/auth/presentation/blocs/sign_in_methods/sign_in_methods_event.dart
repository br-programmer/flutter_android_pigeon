part of 'sign_in_methods_bloc.dart';

abstract class SignInMethodsEvent {}

class SignInMethodsRequested implements SignInMethodsEvent {
  const SignInMethodsRequested();
}
