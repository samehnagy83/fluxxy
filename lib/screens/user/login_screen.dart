import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/config/theme_config.dart';
import '../../common/widgets/app_logo.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../common/widgets/primary_button.dart';
import '../../common/widgets/divider_line.dart';
import '../../common/widgets/social_button.dart';
import '../../models/user_model.dart';
import '../../common/tools/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final userModel = context.read<UserModel>();

    final success = await userModel.login(
      context, // ✅ نمرر الـ context علشان نقدر نعرض الرسائل من UIFeedback
      _emailCtrl.text.trim(),
      _passwordCtrl.text.trim(),
    );

    setState(() => _loading = false);

    if (success && mounted) {
      Navigator.of(context).pushReplacementNamed(AppConstants.routeHome);
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
                const SizedBox(height: 20),
                const AppLogo(title: 'Welcome Back!'),
                const SizedBox(height: 30),

                /// 📧 Email field
                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Enter your email' : null,
                ),

                /// 🔒 Password field
                CustomTextField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  icon: Icons.lock_outline,
                  controller: _passwordCtrl,
                  obscureText: true,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Enter your password' : null,
                ),

                /// Forgot password link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(AppConstants.routeForgotPassword);
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: ThemeConfig.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Login button
                PrimaryButton(
                  text: 'Login',
                  loading: _loading,
                  onPressed: _onLoginPressed,
                ),

                const SizedBox(height: 20),

                /// Divider
                const DividerLine('OR continue with'),
                const SizedBox(height: 20),

                /// Social login buttons
                SocialButton(
                  type: SocialType.google,
                  onPressed: () {
                    // TODO: Implement Google sign-in
                  },
                ),
                const SizedBox(height: 10),
                SocialButton(
                  type: SocialType.apple,
                  onPressed: () {
                    // TODO: Implement Apple sign-in
                  },
                ),
                const SizedBox(height: 10),
                SocialButton(
                  type: SocialType.phone,
                  onPressed: () {
                    // TODO: Implement phone sign-in
                  },
                ),

                const SizedBox(height: 24),

                /// Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account? ',
                      style: TextStyle(color: ThemeConfig.textColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppConstants.routeRegister);
                      },
                      child: const Text(
                        'Sign up',
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
