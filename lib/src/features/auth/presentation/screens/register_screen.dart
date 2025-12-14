import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    ref.read(authControllerProvider.notifier).register(
          email: _email.text,
          name: _name.text,
          password: _password.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    ref.listen<AuthState>(authControllerProvider, (prev, next) {
      if (next.error != null && next.error != prev?.error && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error!)));
      }
      if (next.isAuthenticated && prev?.isAuthenticated != true && mounted) {
        context.go('/sleep');
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (_) => ref.read(authControllerProvider.notifier).clearError(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Имя'),
              onChanged: (_) => ref.read(authControllerProvider.notifier).clearError(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Пароль',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              onSubmitted: (_) => _submit(),
              onChanged: (_) => ref.read(authControllerProvider.notifier).clearError(),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: state.isLoading ? null : _submit,
              child: state.isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Создать аккаунт'),
            ),
          ],
        ),
      ),
    );
  }
}
