import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:takvim_mobile/main.dart';

void main() {
  testWidgets('Takvim+ ana ekranı açılıyor', (tester) async {
    await tester.pumpWidget(const TakvimApp());

    // Uygulama başlığı
    expect(find.text('Takvim+'), findsOneWidget);

    // Bugün butonu
    expect(find.widgetWithText(TextButton, 'Bugün'), findsOneWidget);

    // Ay değiştirme butonları
    expect(find.byIcon(Icons.chevron_left_rounded), findsOneWidget);

    expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
  });
}
