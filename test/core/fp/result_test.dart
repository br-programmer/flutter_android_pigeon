import 'package:flutter_test/flutter_test.dart';
import 'package:qr_biometrics_app/core/core.dart';

void main() {
  group('Result', () {
    test('Success holds correct data', () {
      final result = Success<int, String>(42);
      expect(result, isA<Success<int, String>>());
      expect(result.data, 42);
    });

    test('Failure holds correct error', () {
      final result = Failure<int, String>('error');
      expect(result, isA<Failure<int, String>>());
      expect(result.error, 'error');
    });

    test('Success and Failure are distinct', () {
      final success = Success<int, String>(10);
      final failure = Failure<int, String>('fail');
      expect(success, isNot(isA<Failure<int, String>>()));
      expect(failure, isNot(isA<Success<int, String>>()));
    });

    test('FutureResult returns Success', () async {
      FutureResult<String, String> fetchSuccess() async {
        return Success<String, String>('ok');
      }

      final result = await fetchSuccess();
      expect(result, isA<Success<String, String>>());
      expect((result as Success).data, 'ok');
    });

    test('FutureVoidResult returns Failure', () async {
      FutureVoidResult<String> failAsync() async {
        return Failure<void, String>('fail');
      }

      final result = await failAsync();
      expect(result, isA<Failure<void, String>>());
      expect((result as Failure).error, 'fail');
    });
  });
}
