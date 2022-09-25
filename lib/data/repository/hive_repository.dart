import 'package:hive/hive.dart';
import 'package:test_taskk/data/models/cat_model/cats_model.dart';

class HiveRepository {
  final Box<List<dynamic>?> hiveDB;

  HiveRepository(this.hiveDB);

  List<dynamic>? getFactsFromHive() {
    return hiveDB.get('facts');
  }

  void putFactIntoHive(List<CatModel> listFacts) {
    hiveDB.put('facts', listFacts);
  }
}
