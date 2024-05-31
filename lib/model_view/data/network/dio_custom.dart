import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'endpoints.dart';

class DioHelper {
  static Dio? dio;

  static initdio(){
    dio = Dio(
      BaseOptions(
        baseUrl : EndPoint.baseurl,
        receiveDataWhenStatusError : true,
        headers: {
          "Accept" : "application/json",
          "Content-Type" : "application/json",
        },
      ),
    );

    dio!.interceptors.add(PrettyDioLogger());
// customization
    dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

 static Future <Response> get({
    required String endpoint,
    Map<String,dynamic>?queryParameters,
    Map<String,dynamic>?body,
    Map<String,dynamic>?headers,
   FormData? formData,
  })
  async{
    try{
      dio?.options.headers = headers;
       return await dio!.get(
           endpoint,
         queryParameters :queryParameters,
         data : formData ?? body,
       );
    }
    catch (e){
      rethrow;
    }
}
  static Future<Response?> post(
  {
    required String endpoint,
    Map<String,dynamic>?queryParameters,
    Map<String,dynamic>?headers,
    FormData? formData,
    bool ? WithToken,

}
      )
  async {
    try{
      dio?.options.headers =  {
        'accept: application/json'
            'Content-Type' : 'multipart/form-data',
      };

      return await dio?.post(
        endpoint,
        queryParameters: queryParameters,
        data: formData,

      );
    }
    catch (e){
      rethrow;
    }
  }

 static Future<Response> put(
      {
        required String endpoint,
        Map<String,dynamic>?queryParameters,
        Map<String,dynamic>?body,
        Map<String,dynamic>?headers,
      }
      )
  async {
    try{
      dio?.options.headers = headers;
      return await dio!.put(
        endpoint,
        queryParameters: queryParameters,
        data: body,
      );
    }
    catch (e){
      rethrow;
    }
  }
static  Future<Response> delete(
      {
        required String endpoint,
        Map<String,dynamic>?queryParameters,
        Map<String,dynamic>?body,
        Map<String,dynamic>?headers,
      }
      )
  async {
    try{
      dio?.options.headers = headers;
      return await dio!.delete(
        endpoint,
        queryParameters: queryParameters,
        data: body,
      );
    }
    catch (e){
      rethrow;
    }
  }


}