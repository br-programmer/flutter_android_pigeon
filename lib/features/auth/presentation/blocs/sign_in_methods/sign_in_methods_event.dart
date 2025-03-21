part of 'sign_in_methods_bloc.dart';

/// Base class for events related to the authentication methods.
///
/// This abstract class is the parent of all events that the `SignInMethodsBloc`
/// can receive. It defines the structure for events that trigger changes in the
/// authentication methods state.
abstract class SignInMethodsEvent {}

/// Event to request the authentication methods.
///
/// This event is triggered when the app needs to fetch the available authentication
/// methods, such as Face ID, fingerprint, etc. It initiates the process of loading
/// the authentication methods.
class SignInMethodsRequested implements SignInMethodsEvent {
  const SignInMethodsRequested();
}
