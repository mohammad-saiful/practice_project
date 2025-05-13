import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('users')
  Future<UserResponse> getUsers();
}
