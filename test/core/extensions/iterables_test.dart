import 'package:flutter_test/flutter_test.dart';
import 'package:qr_biometrics_app/core/extensions/extensions.dart';

void main() {
  group('IterableX.mapList', () {
    test('should map elements and return a list of results', () {
      final numbers = [1, 2, 3];
      final result = numbers.mapList((n) => n * n);

      expect(result, equals([1, 4, 9]));
    });

    test('should return an empty list when input is empty', () {
      final emptyList = <int>[];
      final result = emptyList.mapList((n) => n * 2);

      expect(result, isEmpty);
    });

    test('should handle different types correctly', () {
      final words = ['a', 'bb', 'ccc'];
      final lengths = words.mapList((w) => w.length);

      expect(lengths, equals([1, 2, 3]));
    });
  });
}
