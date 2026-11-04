
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:takvim_mobile/screens/auth_screen.dart';

void main() {
  testWidgets('Takvim+ giriş ekranı gösteriliyor',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthScreen(
          onAuthenticated: () {},
        ),
      ),
    );

    expect(find.text('Takvim+'), findsOneWidget);
    expect(find.text('Giriş Yap'), findsOneWidget);
    expect(
      find.text('Hesabın yok mu? Kayıt ol'),
      findsOneWidget,
    );
  });

  testWidgets('Kayıt ekranına geçiş çalışıyor',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthScreen(
          onAuthenticated: () {},
        ),
      ),
    );

    await tester.tap(find.text('Hesabın yok mu? Kayıt ol'));
    await tester.pumpAndSettle();

    expect(find.text('Hesap Oluştur'), findsOneWidget);
    expect(find.text('Ad Soyad'), findsOneWidget);
  });
}
