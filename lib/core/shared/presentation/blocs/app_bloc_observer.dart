import 'dart:developer';

import 'package:bloc/bloc.dart';

/// A custom observer for tracking changes and errors in BLoC events.
///
/// This class extends `BlocObserver` and overrides the `onChange` and `onError`
/// methods to log events and errors that occur in the BLoC. It is used for debugging
/// and monitoring the state transitions and errors in the app's BLoCs.
///
/// - `onChange`: Logs every change in the BLoC's state with information about the
///   BLoC's runtime type and the change that occurred.
/// - `onError`: Logs errors that occur in the BLoC with details about the error
///   and the associated stack trace. This helps in identifying issues in the BLoC
///   during development and debugging.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  /// Logs the change in the BLoC's state.
  ///
  /// This method is called whenever there is a state change in any BLoC. It
  /// logs the BLoC's runtime type and the state change details.
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log(
      'onChange(${bloc.runtimeType}, $change)',
      name: 'BLOC-OBSERVER',
    );
  }

  /// Logs any errors that occur in the BLoC.
  ///
  /// This method is called whenever there is an error in the BLoC. It logs the
  /// BLoC's runtime type, the error, and the stack trace for easier debugging.
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log(
      'onError(${bloc.runtimeType}, $error, $stackTrace)',
      name: 'BLOC-OBSERVER',
    );
    super.onError(bloc, error, stackTrace);
  }
}
