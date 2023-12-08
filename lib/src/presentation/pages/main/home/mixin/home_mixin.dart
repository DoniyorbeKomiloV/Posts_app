part of 'package:posts_app/src/presentation/pages/main/home/home_page.dart';

mixin HomeMixin on State<HomePage> {
  late final HomeBloc bloc = context.read<HomeBloc>();

  late final TextEditingController titleController = TextEditingController();
  late final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(const GetPostsEvent());
  }

  Future<void> listener(BuildContext context, HomeState state) async {}

  void post() {
    bloc.add(
      PostEvent(
        title: titleController.text,
        body: bodyController.text,
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}
