import 'package:flutter/material.dart';
import 'package:test_taskk/cubit/loader_cubit.dart';
import 'package:test_taskk/shared_widgets/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  final AppBarWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const PageLayout({
    super.key,
    required this.child,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: appBar,
      body: Stack(
        children: [
          BlocBuilder<LoaderCubit, LoaderState>(
            builder: (context, state) {
              if (state.loader > 0) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
              }

              return const SizedBox();
            },
          ),
          child,
        ],
      ),
    );
  }
}
