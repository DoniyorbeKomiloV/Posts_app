import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/main/home/home_bloc.dart';
import '../../bloc/main/main_bloc.dart';

import 'home/home_page.dart';
import 'profile/profile_page.dart';
import 'widgets/custom_bottom_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocSelector<MainBloc, MainState, BottomMenu>(
        selector: (state) => state.bottomMenu,
        builder: (_, bottomMenu) => Scaffold(
          body: IndexedStack(
            index: bottomMenu.index,
            children: const [
              HomePage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: CustomBottomBar(
            currentIndex: bottomMenu.index,
            onTap: (index) {
              if (index == bottomMenu.index) {
                context.read<HomeBloc>().add(
                      const HomeScroll(isScrollingTop: true),
                    );
                return;
              }
              context
                  .read<MainBloc>()
                  .add(MainEventChanged(BottomMenu.values[index]));
            },
            onScanTap: () {},
          ),
        ),
      );
}
