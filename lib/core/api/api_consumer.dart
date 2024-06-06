abstract class ApiConsumer {
  Future<dynamic> get(String path,
      // لازم path  يكون اجباري لان دا هيكون عنوان endpoint الي هروح اجيبها من السيرفر
          {
        Object? data,
        //داتا دي هي body اللي ممكن ابعته مع الريكوست ومخليها nullable عشان ممكن محتاجهاش
        Map<String, dynamic>? queryParameters,
        // هنا البراميتيرز اللي ممكن ابعتها مع الريكويست لو انا بعمل فيلتريشن مثلا عشان اجيب حاجة معينة من داخل endPoint وكذلك ممكن محتاجهاش عشان كدا نالابل ؟
      });

  Future<dynamic> post(String path, {
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> patch(String path, {
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> delete(String path, {
  dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  });

}
