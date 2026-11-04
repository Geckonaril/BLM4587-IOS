import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  final bool isRegister;
  final VoidCallback onAuthenticated;

  const AuthScreen({
    super.key,
    this.isRegister = false,
    required this.onAuthenticated,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final authService = AuthService();

  bool isLoading = false;
  bool hidePassword = true;
  late bool isRegister;

  @override
  void initState() {
  super.initState();
  isRegister = widget.isRegister;
}
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      if (isRegister) {
        await authService.register(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
        );
      } else {
        await authService.login(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
      }

      if (!mounted) return;
      widget.onAuthenticated();
    } catch (error) {
      if (!mounted) return;

      final message = error.toString().replaceFirst('Exception: ', '');

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void switchScreen() {
  formKey.currentState?.reset();

  nameController.clear();
  emailController.clear();
  passwordController.clear();

  setState(() {
    isRegister = !isRegister;
    hidePassword = true;
  });
}

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6655D9);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 68,
                      color: purple,
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Takvim+',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: purple,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      isRegister
                          ? 'Planlarını düzenlemeye başla'
                          : 'Takvimine yeniden hoş geldin',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 36),

                    if (isRegister) ...[
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Ad Soyad',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final name = value?.trim() ?? '';
                          if (name.length < 2) {
                            return 'En az 2 karakter gir.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-posta',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(email)) {
                          return 'Geçerli e-posta gir.';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Parola',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Parola gerekli.';
                        }
                        if (isRegister && value.length < 10) {
                          return 'En az 10 karakter kullan.';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    FilledButton(
                      onPressed: isLoading ? null : submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: purple,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              isRegister ? 'Hesap Oluştur' : 'Giriş Yap',
                            ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: isLoading ? null : switchScreen,
                      child: Text(
                        isRegister
                            ? 'Hesabın var mı? Giriş yap'
                            : 'Hesabın yok mu? Kayıt ol',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
