import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/src/config/router/app_routes.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';
import 'package:posts_app/src/data/source/local_source.dart';
import 'package:posts_app/src/presentation/components/inputs/custom_text_field.dart';
import 'package:posts_app/src/presentation/components/loading_widgets/modal_progress_hud.dart';
import '../../../bloc/main/home/home_bloc.dart';

import 'widgets/home_appbar.dart';

part 'mixin/home_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, HomeMixin {
  LocalSource localSource = LocalSource();
  @override
  Widget build(BuildContext context) => BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) async {
          if (state.postDeleteStatus == PostsStatus.succes) {
            bloc.add(const GetPostsEvent());
          }
          if (state.postRequestStatus == PostsStatus.succes) {
            if (!mounted) return;
            context.pop();

            bloc.add(const GetPostsEvent());
          }
        },
        builder: (context, state) => Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: state.getPostsStatus == PostsStatus.loading ||
                state.postRequestStatus == PostsStatus.loading ||
                state.postDeleteStatus == PostsStatus.loading,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                HomeAppBar(innerBoxIsScrolled: innerBoxIsScrolled),
              ],
              body: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverList.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        context.pushNamed(Routes.postDetail,
                           extra: state.posts[index]); 
                      },
                      title: Text(
                        state.posts[index].title,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        state.posts[index].name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: state.posts[index].creatorId ==
                              localSource.userId
                          ? IconButton(
                              onPressed: () {
                                bloc.add(
                                    DeletePostEvent(id: state.posts[index].id));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                          : null,
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showBottomSheet(
                  enableDrag: true,
                  backgroundColor: Colors.grey[50],
                  context: context,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              controller: titleController,
                              autofocus: true,
                              fillColor: const Color(0xFFEDEFF2),
                              filled: true,
                              contentPadding: AppUtils.kPaddingHor14Ver16,
                              keyboardType: TextInputType.name,
                              prefixStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              style: Theme.of(context).textTheme.titleMedium,
                              hintText: 'Title',
                            ),
                            const Gap(16),
                            CustomTextField(
                              controller: bodyController,
                              autofocus: true,
                              fillColor: const Color(0xFFEDEFF2),
                              filled: true,
                              contentPadding: AppUtils.kPaddingHor14Ver16,
                              keyboardType: TextInputType.name,
                              prefixStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              style: Theme.of(context).textTheme.titleMedium,
                              hintText: 'Body',
                            ),
                            const Gap(28),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: post, child: const Text('Post')),
                            )
                          ],
                        ),
                      ));
            },
            child: const Icon(Icons.add),
          ),
        ),
      );
}
