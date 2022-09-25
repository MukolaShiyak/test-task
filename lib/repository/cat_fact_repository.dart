import 'package:test_taskk/api/cats_fact_api/cats_fact_api.dart';
import 'package:test_taskk/models/cat_model/cats_model.dart';
import 'package:test_taskk/utils/timeFormater.dart';

class CatRepository {
  CatRepository(this.catFactApi);
  final RestClient catFactApi;

  Future<CatModel> getRandomCatFact() async {
    Map<String, dynamic> response = await catFactApi.getCatFact();

    String factCreated = TimeFormater().formateDateToLocale();

    CatModel catFact = CatModel(
      factText: response['fact'],
      createdAt: factCreated,
    );

    return catFact;
  }
}
