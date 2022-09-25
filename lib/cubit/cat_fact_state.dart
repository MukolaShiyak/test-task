part of 'cat_fact_cubit.dart';

class CatFactState {
  final List<CatModel> listOfCatFacts;
  final CatModel? catFact;
  final Uint8List? image;
  CatFactState({
    required this.listOfCatFacts,
    this.catFact,
    this.image,
  });

  CatFactState copyWith({
    List<CatModel>? listOfCatFacts,
    CatModel? catFact,
    Uint8List? image,
  }) {
    return CatFactState(
      listOfCatFacts: listOfCatFacts ?? this.listOfCatFacts,
      catFact: catFact ?? this.catFact,
      image: image ?? this.image,
    );
  }
}
