import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/supabase_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await SupabaseService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل تسجيل الدخول: $e'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _loginAsGuest() {
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: AppTheme.goldGradient,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.shopping_bag, size: 50, color: AppTheme.darkText),
                  ),
                ),
                const SizedBox(height: 32),
                const Text('مرحباً بك', textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('سجل دخول للمتابعة', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                const SizedBox(height: 40),
                CustomTextField(
                  label: 'البريد الإلكتروني أو رقم الهاتف',
                  hint: 'example@email.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v?.isEmpty == true ? 'يرجى إدخال البريد الإلكتروني' : null,
                ),
                const SizedBox(height: 20),
                PasswordTextField(
                  controller: _passwordController,
                  validator: (v) {
                    if (v?.isEmpty == true) return 'يرجى إدخال كلمة المرور';
                    if (v!.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('نسيت كلمة المرور؟', style: TextStyle(color: AppTheme.goldColor)),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(text: 'تسجيل الدخول', onPressed: _login, isLoading: _isLoading),
                const SizedBox(height: 16),
                CustomButton(text: 'الدخول كضيف', onPressed: _loginAsGuest, isOutlined: true),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('أو', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ليس لديك حساب؟', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      child: const Text('إنشاء حساب', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
