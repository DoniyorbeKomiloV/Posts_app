import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/src/config/router/app_routes.dart';
import 'package:posts_app/src/data/source/local_source.dart';
import 'package:posts_app/src/presentation/bloc/main/main_bloc.dart';
import 'package:posts_app/src/presentation/components/inputs/custom_text_field.dart';
import 'package:posts_app/src/presentation/components/loading_widgets/modal_progress_hud.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final LocalSource localSource = LocalSource();

  late final TextEditingController loginController;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    loginController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();

    loginController.text = localSource.login;
    nameController.text = localSource.fullName;
    passwordController.text = localSource.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          scrolledUnderElevation: 0,
        ),
        body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state.userStatus == UserStatus.loading,
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: AppUtils.kPaddingAll16,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Center(
                          child: ClipRect(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                width: 96,
                                height: 96,
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://sb.kaleidousercontent.com/67418/1920x1545/c5f15ac173/samuel-raita-ridxdghg7pw-unsplash.jpg',
                              ),
                            ),
                          ),
                        ),
                        AppUtils.kGap16,
                        CustomTextField(
                          titleText: 'Name',
                          controller: nameController,
                          fillColor: const Color(0xFFEDEFF2),
                          filled: true,
                          contentPadding: AppUtils.kPaddingHor14Ver16,
                          keyboardType: TextInputType.name,
                          prefixStyle: Theme.of(context).textTheme.titleMedium,
                          style: Theme.of(context).textTheme.titleMedium,
                          hintText: 'Name',
                        ),
                        AppUtils.kGap16,
                        CustomTextField(
                          titleText: 'Login',
                          controller: loginController,
                          fillColor: const Color(0xFFEDEFF2),
                          filled: true,
                          contentPadding: AppUtils.kPaddingHor14Ver16,
                          keyboardType: TextInputType.name,
                          prefixStyle: Theme.of(context).textTheme.titleMedium,
                          style: Theme.of(context).textTheme.titleMedium,
                          hintText: 'Login',
                        ),
                        AppUtils.kGap16,
                        CustomTextField(
                          titleText: 'Password',
                          controller: passwordController,
                          fillColor: const Color(0xFFEDEFF2),
                          filled: true,
                          contentPadding: AppUtils.kPaddingHor14Ver16,
                          keyboardType: TextInputType.name,
                          prefixStyle: Theme.of(context).textTheme.titleMedium,
                          style: Theme.of(context).textTheme.titleMedium,
                          hintText: 'Password',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<MainBloc>(context).add(SaveUserInfo(
                          name: nameController.text,
                          password: passwordController.text,
                          login: loginController.text,
                        ));
                      },
                      child: const Text('Save'))),
              AppUtils.kGap12,
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        context.pushReplacementNamed(Routes.auth);
                        localSource.setUser(
                            name: '', userId: '', password: '', login: '');
                      },
                      child: const Text('Log out'))),
            ],
          ),
        ),
      );
}
