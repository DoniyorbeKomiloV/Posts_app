part of 'package:posts_app/src/presentation/pages/auth/auth_page.dart';

mixin AuthMixin on State<AuthPage> {
  late final TextEditingController loginController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formkey;

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();
    formkey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
