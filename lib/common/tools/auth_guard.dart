import 'package:flutter/material.dart';
import '../tools/constants.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';

/// 🔒 AuthGuard: ويدجت لحماية الصفحات اللي تتطلب تسجيل دخول.
/// لو المستخدم مش عامل تسجيل دخول، بيرجع تلقائيًا لصفحة Login.
class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();

    // لو المستخدم لسه بيتحمّل أو بيجري تحقق
    if (userModel.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    // لو المستخدم غير مسجل دخول → نوجهه إلى صفحة تسجيل الدخول
    if (!userModel.loggedIn) {
      // إعادة التوجيه لصفحة تسجيل الدخول
      Future.microtask(() {
        Navigator.of(context).pushReplacementNamed(AppConstants.routeLogin);
      });

      // // مؤقتًا نعرض دايرة تحميل أثناء الانتقال
      // return const Scaffold(
      //   body: Center(child: CircularProgressIndicator()),
      // );

      return const SizedBox.shrink(); // نرجع Widget فاضي مؤقتًا
      
    }

    // المستخدم داخل فعلاً
    return child;
  }
}
