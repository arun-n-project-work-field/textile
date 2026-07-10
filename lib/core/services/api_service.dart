import 'package:dio/dio.dart';

class ApiService {

  static final Dio dio = Dio(

    BaseOptions(

      connectTimeout: const Duration(seconds: 20),

      receiveTimeout: const Duration(seconds: 20),

    ),

  );

}