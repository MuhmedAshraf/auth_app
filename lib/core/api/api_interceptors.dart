import 'package:auth_app1/cach/cache_helper.dart';
import 'package:auth_app1/core/api/end_points.dart';
import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKeys.token] =
        CacheHelper().getData(key: ApiKeys.token) != null
            ? 'FOODAPI ${CacheHelper().getData(key: ApiKeys.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
