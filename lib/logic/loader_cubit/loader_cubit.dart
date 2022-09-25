import 'package:flutter_bloc/flutter_bloc.dart';

part 'loader_state.dart';

class LoaderCubit extends Cubit<LoaderState> {
  LoaderCubit() : super(LoaderState(loader: 0));

  void incrementLoader() {
    emit(state.copyWith(loader: state.loader + 1));
  }

  void decrementLoader() {
    emit(state.copyWith(loader: state.loader - 1));
  }
}
