import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:to_do_project/controllers/task_controller.dart';

void main() {
  testWidgets('Test adding item', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  Provider.of<TaskController>(context, listen: false)
                      .addTask('New Task', 'New Task Description');
                },
                child: const Text('Add Item'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add Item'));
    await tester.pump();

    expect(find.text('New Task'), findsOneWidget);
    expect(find.text('New Task Description'), findsOneWidget);
  });
}
