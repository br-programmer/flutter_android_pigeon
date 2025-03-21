part of 'sign_in_methods_bloc.dart';

/// Base class for the authentication methods state.
///
/// This sealed class represents the different states that the `SignInMethodsBloc`
/// can emit during the authentication method loading process. It serves as the
/// foundation for tracking the current state of the authentication methods request.
///
/// - [SignInMethodsInitial]: Initial state when the authentication methods have not been requested.
/// - [SignInMethodsLoading]: State when the authentication methods are being fetched.
/// - [SignInMethodsLoaded]: State when the authentication methods have been successfully loaded.
/// - [SignInMethodsError]: State when an error occurs while fetching authentication methods.
sealed class SignInMethodsState extends Equatable {
  const SignInMethodsState();

  @override
  List<Object?> get props => [];
}

/// State indicating that the authentication methods have not been requested yet.
///
/// This is the initial state when the `SignInMethodsBloc` is first created and before any
/// authentication methods are loaded.
class SignInMethodsInitial extends SignInMethodsState {
  const SignInMethodsInitial();
}

/// State representing that the authentication methods are being loaded.
///
/// This state is emitted when the app is fetching available authentication methods.
class SignInMethodsLoading extends SignInMethodsState {
  const SignInMethodsLoading();
}

/// State representing that the authentication methods have been successfully loaded.
///
/// This state contains the list of available authentication methods and is emitted when
/// the methods are successfully fetched from the repository.
///
/// - `methods`: A list of available authentication methods.
class SignInMethodsLoaded extends SignInMethodsState {
  const SignInMethodsLoaded(this.methods);
  final List<AuthMethod> methods;

  @override
  List<Object?> get props => [methods];
}

/// State representing an error occurred while loading authentication methods.
///
/// This state is emitted if there was an error in fetching the authentication methods,
/// containing an [AuthFailure] object with details about the error.
///
/// - `failure`: An [AuthFailure] instance representing the error that occurred.
class SignInMethodsError extends SignInMethodsState {
  const SignInMethodsError(this.failure);
  final AuthFailure failure;

  @override
  List<Object?> get props => [failure];
}
