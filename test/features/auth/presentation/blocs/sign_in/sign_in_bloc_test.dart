import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockRepository;

  const biometricStrong = AuthMethod.biometricStrong;
  const deviceCredential = AuthMethod.deviceCredential;

  const event = AuthenticateRequested(
    title: 'Title',
    subTitle: 'Subtitle',
    cancel: 'Cancel',
    methods: [biometricStrong, deviceCredential],
  );

  setUpAll(() {
    mockRepository = MockAuthRepository();
    registerFallbackValue(biometricStrong);
  });

  group('SignInBloc', () {
    blocTest<SignInBloc, SignInState>(
      'emits [Loading, Unavailable] when canAuthenticate fails for biometric',
      build: () {
        when(() => mockRepository.canAuthenticate(any()))
            .thenAnswer((_) async => Failure(const AuthenticationFailed()));
        return SignInBloc(
          const SignInInitial(),
          authRepository: mockRepository,
        );
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const SignInLoading(),
        isA<SignInUnavailable>().having(
          (s) => s.failure,
          'failure',
          isA<AuthenticationFailed>(),
        ),
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [Loading, Success] when biometric authentication succeeds',
      build: () {
        when(() => mockRepository.canAuthenticate(biometricStrong))
            .thenAnswer((_) async => Success(true));
        when(
          () => mockRepository.authenticate(
            method: biometricStrong,
            title: event.title,
            subtitle: event.subTitle,
            cancel: event.cancel,
          ),
        ).thenAnswer((_) async => Success(null));

        return SignInBloc(
          const SignInInitial(),
          authRepository: mockRepository,
        );
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const SignInLoading(),
        const SignInSuccess(),
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [Loading, Success] when biometric fails and deviceCredential succeeds',
      build: () {
        when(() => mockRepository.canAuthenticate(biometricStrong))
            .thenAnswer((_) async => Success(true));
        when(
          () => mockRepository.authenticate(
            method: biometricStrong,
            title: event.title,
            subtitle: event.subTitle,
            cancel: event.cancel,
          ),
        ).thenAnswer((_) async => Failure(const AuthenticationFailed()));
        when(() => mockRepository.canAuthenticate(deviceCredential))
            .thenAnswer((_) async => Success(true));
        when(
          () => mockRepository.authenticate(
            method: deviceCredential,
            title: event.title,
            subtitle: event.subTitle,
          ),
        ).thenAnswer((_) async => Success(null));

        return SignInBloc(
          const SignInInitial(),
          authRepository: mockRepository,
        );
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const SignInLoading(),
        const SignInSuccess(),
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [Loading, Error] when biometric and deviceCredential both fail',
      build: () {
        when(() => mockRepository.canAuthenticate(biometricStrong))
            .thenAnswer((_) async => Success(true));
        when(
          () => mockRepository.authenticate(
            method: biometricStrong,
            title: event.title,
            subtitle: event.subTitle,
            cancel: event.cancel,
          ),
        ).thenAnswer((_) async => Failure(const AuthenticationFailed()));
        when(() => mockRepository.canAuthenticate(deviceCredential))
            .thenAnswer((_) async => Success(true));
        when(
          () => mockRepository.authenticate(
            method: deviceCredential,
            title: event.title,
            subtitle: event.subTitle,
          ),
        ).thenAnswer((_) async => Failure(const BiometricUnavailable()));

        return SignInBloc(
          const SignInInitial(),
          authRepository: mockRepository,
        );
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const SignInLoading(),
        isA<SignInError>().having(
          (s) => s.failure,
          'failure',
          isA<BiometricUnavailable>(),
        ),
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [Loading, Unavailable] when deviceCredential canAuthenticate fails',
      build: () {
        when(() => mockRepository.canAuthenticate(biometricStrong))
            .thenAnswer((_) async => Success(false));
        when(() => mockRepository.canAuthenticate(deviceCredential))
            .thenAnswer((_) async => Failure(const AuthenticationError()));

        return SignInBloc(
          const SignInInitial(),
          authRepository: mockRepository,
        );
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const SignInLoading(),
        isA<SignInUnavailable>().having(
          (s) => s.failure,
          'failure',
          isA<AuthenticationError>(),
        ),
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [Loading, Error] when no methods are available',
      build: () {
        return SignInBloc(
          const SignInInitial(),
          authRepository: mockRepository,
        );
      },
      act: (bloc) => bloc.add(
        const AuthenticateRequested(
          title: 'Title',
          subTitle: 'Subtitle',
          methods: [],
        ),
      ),
      expect: () => [
        const SignInLoading(),
        isA<SignInError>().having(
          (s) => s.failure.code,
          'code',
          'no_method_available',
        ),
      ],
    );
  });
}
