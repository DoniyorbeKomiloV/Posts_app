import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:posts_app/src/presentation/components/buttons/bottom_navigation_button.dart';
import 'package:posts_app/src/presentation/components/loading_widgets/modal_progress_hud.dart';
import 'package:posts_app/src/presentation/components/snack/snack.dart';
import '../../../../config/router/app_routes.dart';
import '../../../../config/themes/themes.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';
import '../../../components/inputs/custom_text_field.dart';

part 'package:posts_app/src/presentation/pages/auth/register/mixin/register_mixin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterMixin {
  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
        bloc: _bloc,
        listener: (_, state) {
          if (state is UserRegisterSuccessState) {
            context.pushReplacementNamed(Routes.auth);
          }
          if (state is AuthErrorState) {
            showSnackBar(context, state.error);
          }
        },
        builder: (_, state) => Builder(builder: (context) {
          return Scaffold(
            backgroundColor: colorLightScheme.background,
            appBar: AppBar(
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight - 12),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Register'),
                  ),
                ),
              ),
            ),
            body: ModalProgressHUD(
              inAsyncCall: state is AuthLoadingState,
              child: Form(
                key: formkey,
                child: SafeArea(
                  minimum: AppUtils.kPaddingAll16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppUtils.kGap4,
                      CustomTextField(
                        fillColor: const Color(0xFFEDEFF2),
                        filled: true,
                        controller: _fullNameController,
                        hintText: 'Name',
                        validator: null,
                      ),
                      AppUtils.kGap12,
                      CustomTextField(
                        fillColor: const Color(0xFFEDEFF2),
                        filled: true,
                        controller: _loginController,
                        hintText: 'Login',
                        validator: (value) {
                          if ((value ?? '').length < 4) {
                            return 'minimum 4 characters';
                          }
                          return null;
                        },
                      ),
                      AppUtils.kGap12,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              fillColor: const Color(0xFFEDEFF2),
                              filled: true,
                              controller: _passwordController,
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
                      context.read<AuthBloc>().add(
                            RegisterEvent(
                              login: _loginController.text,
                              password: _passwordController.text,
                              name: _fullNameController.text,
                            ),
                          );
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          );
        }),
      );
}
