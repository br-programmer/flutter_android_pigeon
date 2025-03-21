import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  runApp(TranslationProvider(child: const QrBiometricsApp()));
}
