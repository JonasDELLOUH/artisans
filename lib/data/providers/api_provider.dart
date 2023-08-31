import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../core/services/my_get_storage.dart';

class ApiProvider {
  ApiProvider._();

  static Dio _init() {
    Dio dio = Dio(BaseOptions(
      baseUrl: Constants.originUrl,
      // connectTimeout: const Duration(seconds: 10)
    ));
    // Get.lazyPut(() => AppGetServices());
    // AppGetServices appGetServices = Get.find<AppGetServices>();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, requestInterceptorHandler) {
          print("Mon token devient : ${MyGetStorage.instance.read(Constants.token)}");
          String? authToken = MyGetStorage.instance.read("token") ?? "";
          print(
              "Url : ${requestOptions.uri} \n the data : ${requestOptions.data} \t the parameters : ${requestOptions.queryParameters}");
          // Vérifiez si le token est disponible
          print("le token : $authToken");
          if (authToken.isNotEmpty) {
            requestOptions.headers['Authorization'] = 'Bearer $authToken';
          }
          requestInterceptorHandler.next(requestOptions);
        },
        onResponse: (response, onResponse) {
          print("the response : ${response.data} ");
          onResponse.next(response);
        },
        onError: (DioException dioException, ErrorInterceptorHandler onError) {
          print("the error : ${dioException.response?.data}");
          // Vérifiez si le statut de la réponse est 401 (Unauthorized) ou 403 (Forbidden)
          if (dioException.response?.statusCode == 401) {
            // Supprimez le token expiré ou invalide de GetStorage
            MyGetStorage.instance.remove('token');
            // Redirigez l'utilisateur vers la page de connexion
            Get.offAllNamed(AppRoutes
                .signInRoute); // Remplacez LoginScreen par votre écran de connexion
          } else {
            onError.next(dioException);
          }
        },
      ),
    );
    print("let's continue");
    return dio;
  }

  static Dio? _api;

  static Dio get client => _api ?? (_api = _init());
}
