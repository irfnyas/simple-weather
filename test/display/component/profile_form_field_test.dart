import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/display/component/profile_form_field.dart';

void main() {
  group('profile form field test', () {
    testWidgets('has focus if value is empty', (tester) async {
      const labelText = 'Label';
      final formKey = GlobalKey<FormState>();
      final focusNode = FocusNode();
      final fieldController = TextEditingController();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: ProfileFormField(
              controller: fieldController,
              node: focusNode,
              label: labelText,
            ),
          ),
        ),
      ));

      final isValid = formKey.currentState?.validate() ?? false;
      !isValid ? focusNode.requestFocus() : focusNode.unfocus();

      await tester.pump();

      expect(true, focusNode.hasFocus);
    });

    testWidgets('no focus if has value', (tester) async {
      const labelText = 'Label';
      final formKey = GlobalKey<FormState>();
      final focusNode = FocusNode();
      final fieldController = TextEditingController();
      final field = find.byType(TextFormField);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: ProfileFormField(
              controller: fieldController,
              node: focusNode,
              label: labelText,
            ),
          ),
        ),
      ));

      await tester.enterText(field, 'weather');
      await tester.pump();

      final isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) {
        focusNode.requestFocus();
      } else {
        focusNode.unfocus();
      }

      await tester.pump();

      expect(false, focusNode.hasFocus);
    });
  });
}
