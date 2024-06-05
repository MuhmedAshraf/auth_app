class EndPoints{
   static const String baseUrl = "https://food-api-omega.vercel.app/api/v1/";
   static const String signIn = "user/signin";
   static const String signUp = "user/signup";
   static  String getUserDataEndPoint(id){
      return "user/get-user/$id";
   }
   static const String delete = "user/delete";
   static const String logOut = "user/logout";
   static const String update = "user/update";
}

class ApiKeys{ // بحط هنا الكلمات اللي بتقابلني في api بحيث لما استخدمها اندها كمتغير عشان مكتبهاش بايدي ويحصل لغبطة
   static String status = "status";
   static String errMessage = "ErrorMessage";
   static String email = "email";
   static String password = "password";
   static String confirmPassword = "confirmPassword";
   static String token = "token";
   static String message = "message";
   static String id = "id";
   static String name = "name";
   static String phone = "phone";
   static String profilePic = "profilePic";
   static String location = "location";
}