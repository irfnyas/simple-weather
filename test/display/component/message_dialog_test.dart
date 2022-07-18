import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/display/component/message_dialog.dart';
import 'package:simple_weather/domain/util/constant.dart';

void main() {
  group('message dialog test', () {
    testWidgets('dialog has a title, a message and ok btn', (tester) async {
      const title = 'titleText';
      const content = 'contentText';

      await tester.pumpWidget(MaterialApp(
          home: Builder(
              builder: ((context) => MaterialButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const MessageDialog(
                          title: title, content: content)))))));

      final showDialogBtn = find.byType(MaterialButton);
      await tester.tap(showDialogBtn);
      await tester.pump();

      final titleText = find.text(title);
      final contentText = find.text(content);
      final okBtn = find.text(textOk);

      expect(titleText, findsOneWidget);
      expect(contentText, findsOneWidget);
      expect(okBtn, findsOneWidget);
    });

    testWidgets('dialog is closed when back btn clicked', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Builder(
              builder: ((context) => MaterialButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) =>
                          const MessageDialog(title: null, content: null)))))));

      final showDialogBtn = find.byType(MaterialButton);
      await tester.tap(showDialogBtn);
      await tester.pump();

      final okBtn = find.text(textOk);
      await tester.tap(okBtn);
      await tester.pump();

      expect(okBtn, findsNothing);
    });

    testWidgets('dialog is closed when outside area clicked', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Builder(
              builder: ((context) => MaterialButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) =>
                          const MessageDialog(title: null, content: null)))))));

      final showDialogBtn = find.byType(MaterialButton);
      await tester.tap(showDialogBtn);
      await tester.pump();

      await tester.tapAt(Offset.zero);
      await tester.pump();

      final okBtn = find.text(textOk);
      expect(okBtn, findsNothing);
    });
  });
}
