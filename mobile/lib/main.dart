import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/calendar_screen.dart';
import 'services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TakvimApp());
}

class TakvimApp extends StatelessWidget {
  const TakvimApp({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6655D9);

    return MaterialApp(
      title: 'Takvim+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7FC),
        colorScheme: ColorScheme.fromSeed(seedColor: purple, primary: purple),
      ),
      home: const SessionGate(),
    );
  }
}

class SessionGate extends StatefulWidget {
  const SessionGate({super.key});

  @override
  State<SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<SessionGate> {
  final auth = AuthService();

  bool loading = true;
  bool loggedIn = false;
  String? error;

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  Future<void> checkSession() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final valid = await auth.hasValidSession();

      if (!mounted) return;
      setState(() {
        loggedIn = valid;
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        loading = false;
        error = 'API bağlantısı kurulamadı.';
      });
    }
  }

  Future<void> logout() async {
    await auth.logout();
    if (!mounted) return;

    setState(() {
      loggedIn = false;
    });
  }

  void loginCompleted() {
    setState(() {
      loggedIn = true;
      error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(error!),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: checkSession,
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }

    if (loggedIn) {
      return CalendarScreen(onLogout: logout);
    }

    return AuthScreen(onAuthenticated: loginCompleted);
  }
}
