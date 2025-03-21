import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/gen/assets.gen.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

class AuthMethodLoaded extends StatelessWidget {
  const AuthMethodLoaded({super.key, required this.methods});
  final List<AuthMethod> methods;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.svgs.faceId.svg(
                width: context.qrAppSize.width * .15,
              ),
              gap16,
              Text(
                context.texts.auth.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              gap4,
              Text(
                context.texts.auth.description,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CupertinoButton(
              onPressed: () => context.read<SignInBloc>().add(
                    AuthenticateRequested(
                      title: context.texts.auth.loginRequest.title,
                      subTitle: context.texts.auth.loginRequest.subtitle,
                      cancel: context.texts.misc.cancel,
                      methods: methods,
                    ),
                  ),
              child: Text(
                context.texts.auth.login,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ),
        gap20,
      ],
    );
  }
}
