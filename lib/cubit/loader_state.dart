part of 'loader_cubit.dart';

class LoaderState {
  final int loader;
  LoaderState({
    required this.loader,
  });

  LoaderState copyWith({
    int? loader,
  }) {
    return LoaderState(
      loader: loader ?? this.loader,
    );
  }
}
