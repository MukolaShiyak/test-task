import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_taskk/data/models/cat_model/cats_model.dart';
import 'package:test_taskk/data/repository/cat_fact_repository.dart';
import 'package:test_taskk/data/repository/hive_repository.dart';
import 'package:test_taskk/logic/loader_cubit/loader_cubit.dart';

part 'cat_fact_state.dart';

class CatFactCubit extends Cubit<CatFactState> {
  final CatRepository catRepository;
  final HiveRepository hiveRepository;
  final LoaderCubit loaderCubit;
  CatFactCubit({
    required this.catRepository,
    required this.loaderCubit,
    required this.hiveRepository,
  }) : super(CatFactState(listOfCatFacts: []));

  Future<void> getCatFact() async {
    const String url = 'https://cataas.com/cat';
    try {
      loaderCubit.incrementLoader();

      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
          .buffer
          .asUint8List();

      final List<CatModel> listFacts = [...state.listOfCatFacts];

      CatModel catFact = await catRepository.getRandomCatFact();

      listFacts.insert(0, catFact);

      hiveRepository.putFactIntoHive(listFacts);

      emit(state.copyWith(image: bytes));
      emit(state.copyWith(catFact: catFact));
      emit(state.copyWith(listOfCatFacts: listFacts));
    } catch (e) {
      print(e);
    } finally {
      loaderCubit.decrementLoader();
    }
  }

  void loadStateFromHive(List<CatModel> listFacts) {
    emit(state.copyWith(listOfCatFacts: listFacts));
  }
}
