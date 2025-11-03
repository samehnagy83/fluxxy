import 'package:flutter/material.dart';
import '../../common/config/theme_config.dart';
import '../../common/widgets/app_logo.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../common/widgets/primary_button.dart';
import '../../common/tools/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _onSendPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    await Future.delayed(const Duration(seconds: 2)); // محاكاة API call

    setState(() => _loading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link has been sent to your email.'),
        ),
      );
      Navigator.of(context).pushReplacementNamed(AppConstants.routeLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const AppLogo(title: 'Forgot Password'),
                const SizedBox(height: 30),

                Text(
                  'Enter your email address to reset your password.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ThemeConfig.hintColor,
                    fontSize: 15,
                    fontFamily: ThemeConfig.fontFamily,
                  ),
                ),
                const SizedBox(height: 30),

                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Enter your email' : null,
                ),

                const SizedBox(height: 20),

                PrimaryButton(
                  text: 'Send reset link',
                  loading: _loading,
                  onPressed: _onSendPressed,
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remember your password? ',
                      style: TextStyle(color: ThemeConfig.textColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppConstants.routeLogin);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: ThemeConfig.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
