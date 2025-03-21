part of 'sign_in_methods_bloc.dart';

sealed class SignInMethodsState extends Equatable {
  const SignInMethodsState();
  @override
  List<Object?> get props => [];
}

class SignInMethodsInitial extends SignInMethodsState {
  const SignInMethodsInitial();
}

class SignInMethodsLoading extends SignInMethodsState {
  const SignInMethodsLoading();
}

class SignInMethodsLoaded extends SignInMethodsState {
  const SignInMethodsLoaded(this.methods);
  final List<AuthMethod> methods;

  @override
  List<Object?> get props => [methods];
}

class SignInMethodsError extends SignInMethodsState {
  const SignInMethodsError(this.failure);
  final AuthFailure failure;

  @override
  List<Object?> get props => [failure];
}
