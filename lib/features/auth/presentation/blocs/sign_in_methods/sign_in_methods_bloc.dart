import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

part 'sign_in_methods_event.dart';
part 'sign_in_methods_state.dart';

class SignInMethodsBloc extends Bloc<SignInMethodsEvent, SignInMethodsState> {
  SignInMethodsBloc(
    super.initialState, {
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository {
    on<SignInMethodsRequested>(_signInMethodsRequestedToState);
  }

  final IAuthRepository _authRepository;

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
