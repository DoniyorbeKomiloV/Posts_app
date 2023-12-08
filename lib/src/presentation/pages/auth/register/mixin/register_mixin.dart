part of 'package:posts_app/src/presentation/pages/auth/register/register_page.dart';

mixin RegisterMixin on State<RegisterPage> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _loginController;
  late final AuthBloc _bloc = context.read<AuthBloc>();
  late final GlobalKey<FormState> formkey;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _passwordController = TextEditingController();
    _loginController = TextEditingController();
    formkey = GlobalKey<FormState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    unawaited(_bloc.close());
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _fullNameController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
  }
}
