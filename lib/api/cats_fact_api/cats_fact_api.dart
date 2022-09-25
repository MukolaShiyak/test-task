import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cats_fact_api.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/fact")
  Future<dynamic> getCatFact();
}
