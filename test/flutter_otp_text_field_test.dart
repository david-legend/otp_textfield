import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

Finder get _fields => find.byType(TextField);

String _textAt(WidgetTester tester, int i) =>
    tester.widget<TextField>(_fields.at(i)).controller!.text;

bool _hasFocus(WidgetTester tester, int i) =>
    tester.widget<TextField>(_fields.at(i)).focusNode!.hasFocus;

void main() {
  group('rendering', () {
    testWidgets('defaults to 4 fields', (tester) async {
      await tester.pumpWidget(_wrap(OtpTextField()));
      expect(_fields, findsNWidgets(4));
    });

    testWidgets('renders numberOfFields fields', (tester) async {
      await tester.pumpWidget(_wrap(OtpTextField(numberOfFields: 6)));
      expect(_fields, findsNWidgets(6));
    });

    testWidgets('obscureText is passed to fields', (tester) async {
      await tester.pumpWidget(_wrap(OtpTextField(obscureText: true)));
      expect(tester.widget<TextField>(_fields.first).obscureText, isTrue);
    });

    test('asserts styles length matches numberOfFields', () {
      expect(
        () => OtpTextField(numberOfFields: 4, styles: const [TextStyle()]),
        throwsAssertionError,
      );
    });
  });

  group('typing', () {
    testWidgets('moves focus to next field after a digit', (tester) async {
      await tester.pumpWidget(_wrap(OtpTextField()));

      await tester.enterText(_fields.at(0), '1');
      await tester.pump();

      expect(_hasFocus(tester, 1), isTrue);
    });

    testWidgets('unfocuses after last field is filled', (tester) async {
      await tester.pumpWidget(_wrap(OtpTextField(numberOfFields: 2)));

      await tester.enterText(_fields.at(0), '1');
      await tester.pump();
      await tester.enterText(_fields.at(1), '2');
      await tester.pump();

      expect(_hasFocus(tester, 0), isFalse);
      expect(_hasFocus(tester, 1), isFalse);
    });

    testWidgets('onCodeChanged fires per entered digit', (tester) async {
      final changes = <String>[];
      await tester.pumpWidget(_wrap(OtpTextField(onCodeChanged: changes.add)));

      await tester.enterText(_fields.at(0), '7');
      await tester.pump();
      await tester.enterText(_fields.at(1), '8');
      await tester.pump();

      expect(changes, ['7', '8']);
    });

    testWidgets('onSubmit fires only when all fields are filled',
        (tester) async {
      final submitted = <String>[];
      await tester.pumpWidget(_wrap(OtpTextField(onSubmit: submitted.add)));

      for (var i = 0; i < 3; i++) {
        await tester.enterText(_fields.at(i), '${i + 1}');
        await tester.pump();
      }
      expect(submitted, isEmpty);

      await tester.enterText(_fields.at(3), '4');
      await tester.pump();
      expect(submitted, ['1234']);
    });
  });

  group('backspace', () {
    testWidgets('clearing a field moves focus to previous field',
        (tester) async {
      await tester.pumpWidget(_wrap(OtpTextField()));

      await tester.enterText(_fields.at(0), '1');
      await tester.pump();
      await tester.enterText(_fields.at(1), '2');
      await tester.pump();

      await tester.enterText(_fields.at(1), '');
      await tester.pump();

      expect(_hasFocus(tester, 0), isTrue);
    });

    testWidgets('clearing first field keeps focus there', (tester) async {
      await tester.pumpWidget(_wrap(OtpTextField()));

      await tester.enterText(_fields.at(0), '1');
      await tester.pump();
      await tester.tap(_fields.at(0));
      await tester.enterText(_fields.at(0), '');
      await tester.pump();

      expect(_hasFocus(tester, 0), isTrue);
    });

    testWidgets('onSubmit does not fire after a field is cleared',
        (tester) async {
      final submitted = <String>[];
      await tester.pumpWidget(
        _wrap(OtpTextField(numberOfFields: 2, onSubmit: submitted.add)),
      );

      await tester.enterText(_fields.at(0), '1');
      await tester.pump();
      await tester.enterText(_fields.at(0), '');
      await tester.pump();
      await tester.enterText(_fields.at(1), '2');
      await tester.pump();

      expect(submitted, isEmpty);
    });
  });

  group('paste / autofill', () {
    testWidgets('pasting full code into first field fills all fields',
        (tester) async {
      final submitted = <String>[];
      await tester.pumpWidget(_wrap(OtpTextField(onSubmit: submitted.add)));

      await tester.enterText(_fields.at(0), '1234');
      await tester.pump();

      expect([for (var i = 0; i < 4; i++) _textAt(tester, i)],
          ['1', '2', '3', '4']);
      expect(submitted.last, '1234');
    });

    testWidgets('pasting longer code is truncated to numberOfFields',
        (tester) async {
      final submitted = <String>[];
      await tester.pumpWidget(_wrap(OtpTextField(onSubmit: submitted.add)));

      await tester.enterText(_fields.at(0), '123456');
      await tester.pump();

      expect([for (var i = 0; i < 4; i++) _textAt(tester, i)],
          ['1', '2', '3', '4']);
      expect(submitted.last, '1234');
    });

    testWidgets('pasting into a middle field fills from that field onward',
        (tester) async {
      await tester.pumpWidget(_wrap(OtpTextField()));

      await tester.enterText(_fields.at(1), '987');
      await tester.pump();

      expect([for (var i = 0; i < 4; i++) _textAt(tester, i)],
          ['', '9', '8', '7']);
    });

    testWidgets('pasting partial code does not submit', (tester) async {
      final submitted = <String>[];
      await tester.pumpWidget(_wrap(OtpTextField(onSubmit: submitted.add)));

      await tester.enterText(_fields.at(0), '12');
      await tester.pump();

      expect([for (var i = 0; i < 4; i++) _textAt(tester, i)],
          ['1', '2', '', '']);
      expect(submitted, isEmpty);
    });
  });

  group('controllers & clearText', () {
    testWidgets('handleControllers exposes one controller per field',
        (tester) async {
      List<TextEditingController?>? controllers;
      await tester.pumpWidget(
        _wrap(OtpTextField(handleControllers: (c) => controllers = c)),
      );

      expect(controllers, hasLength(4));
      expect(controllers!.every((c) => c != null), isTrue);
    });

    testWidgets('clearText clears all fields', (tester) async {
      var clear = false;
      late StateSetter setOuter;

      await tester.pumpWidget(
        _wrap(StatefulBuilder(builder: (context, setState) {
          setOuter = setState;
          return OtpTextField(clearText: clear);
        })),
      );

      await tester.enterText(_fields.at(0), '1234');
      await tester.pump();
      expect(_textAt(tester, 3), '4');

      setOuter(() => clear = true);
      await tester.pump();

      expect([for (var i = 0; i < 4; i++) _textAt(tester, i)],
          ['', '', '', '']);
    });
  });
}
