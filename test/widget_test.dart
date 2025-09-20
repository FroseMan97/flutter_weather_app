import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/main.dart';

void main() {
  testWidgets('Weather app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app shows the weather page
          expect(find.text('Приложение Погоды'), findsOneWidget);
          expect(find.text('Поиск города'), findsOneWidget);
          expect(find.text('Выберите город для просмотра погоды'), findsOneWidget);
  });
}