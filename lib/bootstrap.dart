import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

/// The `bootstrap` function initializes the application, setting up error handling,
/// BLoC observers, and the root widget for the app.
///
/// This function performs the following actions:
/// - Sets a custom error handler to log Flutter errors using `FlutterError.onError`,
///   capturing both the exception and the stack trace.
/// - Assigns a custom BLoC observer (`AppBlocObserver`) to track state changes and
///   errors across all BLoC events.
/// - Starts the app by calling `runApp`, wrapping the `QrBiometricsApp` widget with
///   a `TranslationProvider` to handle localization and translations.
Future<void> bootstrap() async {
  // Set up a custom error handler to log exceptions and stack traces.
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Assign a custom BLoC observer to track state changes and errors.
  Bloc.observer = const AppBlocObserver();

  // Start the app with the `TranslationProvider` to handle localization.
  runApp(TranslationProvider(child: const QrBiometricsApp()));
}
