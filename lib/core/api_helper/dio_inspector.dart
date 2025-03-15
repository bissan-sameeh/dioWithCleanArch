import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor{
  @override
  Future<void> onRequest(RequestOptions options,RequestInterceptorHandler handler) async{
    options.headers['Content-Type']='application/json';
    super.onRequest(options, handler);

  }
}