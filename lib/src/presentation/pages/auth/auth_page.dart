import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';
import 'package:posts_app/src/presentation/components/snack/snack.dart';
import '../../../config/router/app_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../components/buttons/bottom_navigation_button.dart';
import '../../components/inputs/custom_text_field.dart';
import '../../components/loading_widgets/modal_progress_hud.dart';

part 'mixin/auth_mixin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with AuthMixin {
  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthSuccessState) {
            context
              ..canPop()
              ..pushReplacementNamed(Routes.main);
          }
          if (state is AuthLoginState) {
            context.pushNamed(Routes.register);
          }
          if (state is AuthErrorState) {
            showSnackBar(context, state.error);
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: AppUtils.kPaddingHor16Ver12,
                    child: Text(
                      'Enter your login and password',
                    ),
                  ),
                ),
              ),
            ),
            body: BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) =>
                  previous is AuthLoadingState != current is AuthLoadingState,
              builder: (_, state) => ModalProgressHUD(
                inAsyncCall: state is AuthLoadingState,
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppUtils.kGap20,
                      Padding(
                        padding: AppUtils.kPaddingHorizontal16,
                        child: CustomTextField(
                          controller: loginController,
                          autofocus: true,
                          fillColor: const Color(0xFFEDEFF2),
                          filled: true,
                          contentPadding: AppUtils.kPaddingHor14Ver16,
                          keyboardType: TextInputType.name,
                          prefixStyle: Theme.of(context).textTheme.titleMedium,
                          style: Theme.of(context).textTheme.titleMedium,
                          hintText: 'Login',
                          validator: (value) {
                            if ((value ?? '').length < 4) {
                              return 'minimum 4 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      AppUtils.kGap20,
                      Padding(
                        padding: AppUtils.kPaddingHorizontal16,
                        child: CustomTextField(
                          controller: passwordController,
                          autofocus: true,
                          fillColor: const Color(0xFFEDEFF2),
                          filled: true,
                          contentPadding: AppUtils.kPaddingHor14Ver16,
                          keyboardType: TextInputType.name,
                          prefixStyle: Theme.of(context).textTheme.titleMedium,
                          style: Theme.of(context).textTheme.titleMedium,
                          hintText: 'Password',
                          validator: (value) {
                            if ((value ?? '').length < 8) {
                              return 'minimum 8 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationButton(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final isValidate = formkey.currentState!.validate();
                      if (isValidate) {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                login: loginController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () => context.pushNamed(Routes.register),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          );
        }),
      );
}
