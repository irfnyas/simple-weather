import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/display/component/exit_dialog.dart';
import 'package:simple_weather/domain/util/constant.dart';

void main() {
  group('exit dialog test', () {
    testWidgets('dialog has an exit title, back btn and exit btn',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Builder(
              builder: ((context) => MaterialButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const ExitDialog()))))));

      final showDialogBtn = find.byType(MaterialButton);
      await tester.tap(showDialogBtn);
      await tester.pump();

      final exitTitle = find.text(textExitTitle);
      final exitBtn = find.text(textExit);
      final backBtn = find.text(textBack);

      expect(exitTitle, findsOneWidget);
      expect(exitBtn, findsOneWidget);
      expect(backBtn, findsOneWidget);
    });

    testWidgets('dialog is closed when back btn clicked', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Builder(
              builder: ((context) => MaterialButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const ExitDialog()))))));

      final showDialogBtn = find.byType(MaterialButton);
      await tester.tap(showDialogBtn);
      await tester.pump();

      final backBtn = find.text(textBack);
      await tester.tap(backBtn);
      await tester.pump();

      expect(backBtn, findsNothing);
    });

    testWidgets('dialog is closed when outside area clicked', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Builder(
              builder: ((context) => MaterialButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const ExitDialog()))))));

      final showDialogBtn = find.byType(MaterialButton);
      await tester.tap(showDialogBtn);
      await tester.pump();

      await tester.tapAt(Offset.zero);
      await tester.pump();

      final exitTitle = find.text(textExitTitle);
      expect(exitTitle, findsNothing);
    });
  });
}
