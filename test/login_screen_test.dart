import 'package:flutter_test/flutter_test.dart';
import 'package:math_go/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:math_go/screens/map_view.dart';

void main() {
  dotenv.testLoad(fileInput: '''MAPBOX_URL = ""
  MAPBOX_API_KEY = ""
  ''');
  group(
      'Login Flow',
      () => testWidgets('with existing account', (WidgetTester tester) async {
            // Build our app and trigger a frame.
            await tester.pumpWidget(const MyApp());

            // Find the existing account button
            final existingAccountBtn = find.text('Existing Account');
            expect(existingAccountBtn, findsOneWidget);

            // Login with an existing account
            await tester.tap(existingAccountBtn);
            await tester.pump();
            await tester.pump();

            // Verify that we have reached the map view screen
            expect(find.byType(MapViewScreen), findsOneWidget);
          }));
}
