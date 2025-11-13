import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../shared/di/locator.dart';
import 'domain/password_repository.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _submit() {
    if (_controller.text.length != 4 || _loading) return;
    setState(() => _loading = true);
    final ok = getIt<PasswordRepository>().verifyPin(_controller.text);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ok ? 'Вход выполнен' : 'Неверный пароль')),
      );
      if (ok) {
        context.pushReplacement("/sleep");
      }
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = _controller.text.length == 4 && !_loading;
    return Scaffold(
      appBar: AppBar(title: const Text('Вход по PIN')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                focusNode: _focus,
                obscureText: _obscure,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: 4,
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _submit(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: InputDecoration(
                  hintText: 'Введите 4 цифры',
                  counterText: '',
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: canSubmit ? _submit : null,
                  child: _loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Войти'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
