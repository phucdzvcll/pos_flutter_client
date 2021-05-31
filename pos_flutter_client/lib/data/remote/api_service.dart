import 'package:dio/dio.dart';
import 'package:pos_flutter_client/data/remote/enitity/category_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://pos.tinyflutterteam.com:8082/pos_api/")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/products')
  Future<CategoryResponse> getCategories();
}
