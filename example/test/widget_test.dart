import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('home lists the examples', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('OTP TextField Example 1'), findsOneWidget);
    expect(find.text('OTP TextField Example 2'), findsOneWidget);
  });

  testWidgets('OtpTextField calls onSubmit when all fields are filled',
      (WidgetTester tester) async {
    String? submitted;
    final changes = <String>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpTextField(
            numberOfFields: 4,
            onCodeChanged: changes.add,
            onSubmit: (code) => submitted = code,
          ),
        ),
      ),
    );

    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(4));

    for (var i = 0; i < 4; i++) {
      await tester.enterText(fields.at(i), '${i + 1}');
      await tester.pump();
    }

    expect(submitted, '1234');
    expect(changes, isNotEmpty);
  });
}
