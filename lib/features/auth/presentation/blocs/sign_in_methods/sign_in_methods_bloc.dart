import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

part 'sign_in_methods_event.dart';
part 'sign_in_methods_state.dart';

/// A BLoC that manages the state of the authentication methods in the app.
///
/// This BLoC listens for events related to fetching and handling authentication
/// methods. It communicates with the [IAuthRepository] to get the available
/// authentication methods and emits different states based on the result.
///
/// The BLoC can emit the following states:
/// - [SignInMethodsLoading]: Emitted while the authentication methods are being fetched.
/// - [SignInMethodsLoaded]: Emitted when the authentication methods are successfully loaded.
/// - [SignInMethodsError]: Emitted when there is an error while fetching the authentication methods.
class SignInMethodsBloc extends Bloc<SignInMethodsEvent, SignInMethodsState> {
  SignInMethodsBloc(
    super.initialState, {
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository {
    on<SignInMethodsRequested>(_signInMethodsRequestedToState);
  }

  final IAuthRepository _authRepository;

  /// Handles the [SignInMethodsRequested] event, which requests the available authentication methods.
  ///
  /// This method fetches the available authentication methods from the [IAuthRepository]
  /// and emits either [SignInMethodsLoaded] if the methods are fetched successfully,
  /// or [SignInMethodsError] if there is an error during the fetching process.
  ///
  /// - Emits [SignInMethodsLoading] before attempting to fetch the methods.
  /// - Emits [SignInMethodsLoaded] with the list of available methods on success.
  /// - Emits [SignInMethodsError] with the error on failure.
  Future<void> _signInMethodsRequestedToState(
    SignInMethodsRequested event,
    Emitter<SignInMethodsState> emit,
  ) async {
    emit(const SignInMethodsLoading());
    final result = await _authRepository.getAvailableMethods();
    final state = switch (result) {
      Success(:final data) => SignInMethodsLoaded(data),
      Failure(:final error) => SignInMethodsError(error),
    };
    emit(state);
  }
}
