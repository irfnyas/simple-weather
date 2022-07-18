import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/display/component/profile_form_field.dart';

void main() {
  group('profile form field test', () {
    testWidgets('has focus if value is empty', (tester) async {
      const _labelText = 'Label';
      final _formKey = GlobalKey<FormState>();
      final _focusNode = FocusNode();
      final _fieldController = TextEditingController();

      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: Form(
                  key: _formKey,
                  child: ProfileFormField(
                      controller: _fieldController,
                      node: _focusNode,
                      label: _labelText)))));

      final _isValid = _formKey.currentState?.validate() ?? false;
      !_isValid ? _focusNode.requestFocus() : _focusNode.unfocus();

      await tester.pump();

      expect(true, _focusNode.hasFocus);
    });

    testWidgets('no focus if has value', (tester) async {
      const _labelText = 'Label';
      final _formKey = GlobalKey<FormState>();
      final _focusNode = FocusNode();
      final _fieldController = TextEditingController();
      final _field = find.byType(TextFormField);

      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: Form(
                  key: _formKey,
                  child: ProfileFormField(
                      controller: _fieldController,
                      node: _focusNode,
                      label: _labelText)))));

      await tester.enterText(_field, 'weather');
      await tester.pump();

      final _isValid = _formKey.currentState?.validate() ?? false;
      if (!_isValid) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }

      await tester.pump();

      expect(false, _focusNode.hasFocus);
    });
  });
}
