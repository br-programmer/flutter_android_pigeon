import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_biometrics_app/core/core.dart';

void main() {
  testWidgets('MediaQueryX returns correct values', (tester) async {
    const testSize = Size(400, 800);
    const testPadding = EdgeInsets.all(16);

    late Size sizeFromExtension;
    late double heightFromExtension;
    late double widthFromExtension;
    late EdgeInsets paddingFromExtension;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: testSize, padding: testPadding),
        child: Builder(
          builder: (context) {
            sizeFromExtension = context.qrAppSize;
            heightFromExtension = context.height;
            widthFromExtension = context.width;
            paddingFromExtension = context.padding;
            return const MaterialApp();
          },
        ),
      ),
    );

    expect(sizeFromExtension, equals(testSize));
    expect(heightFromExtension, equals(testSize.height));
    expect(widthFromExtension, equals(testSize.width));
    expect(paddingFromExtension, equals(testPadding));
  });
}
