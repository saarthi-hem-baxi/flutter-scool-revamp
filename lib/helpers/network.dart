import 'package:dio/dio.dart' as dio;
import 'package:students/helpers/header.dart';
import 'package:students/helpers/storage_manager.dart';

class APIClient {
  dio.Dio dioClient = dio.Dio();
  String token = '';

  Future<void> getLocalToken() async {
    token = StorageManager().getAuthToken() ?? '';
  }

  Future<Map<String, String>> _getHeaders({Map options = const {}}) async {
    final headers = await HeaderHandler().getHeaders();

    print('LINE 16 NETWORK  : $options');

    Map<String, String> allHeaders = {
      ...options,
      ...headers,
      'authorization': 'Bearer $token',
    };

    print(allHeaders);
    return allHeaders;
  }

  Future getData({
    required String url,
  }) async {
    await getLocalToken();

    print('LINE 29 $url');
    try {
      var response = await dioClient.get(
        url,
        options: dio.Options(
          headers: await _getHeaders(),
          responseType: dio.ResponseType.json,
        ),
      );

      print(response);
      HeaderHandler().handleHeaders(response);
      return response;
    } on dio.DioException catch (error) {
      HeaderHandler().handleHeaders(error.response!);
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future postData({
    required String url,
    required dynamic data,
  }) async {
    await getLocalToken();
    print('NETWORK LINE 59 : $url');
    print('NETWORK LINE 60 : $data');
    try {
      dio.Response response = await dioClient.post(
        url,
        data: data,
        options: dio.Options(
          headers: await _getHeaders(),
          responseType: dio.ResponseType.json,
        ),
      );
      print(response);
      HeaderHandler().handleHeaders(response);
      return response;
    } on dio.DioException catch (error) {
      if (error.response != null) {
        HeaderHandler().handleHeaders(error.response);
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future putData({
    required String url,
    required dynamic data,
  }) async {
    await getLocalToken();
    try {
      var response = await dioClient.put(
        url,
        data: data,
        options: dio.Options(
          headers: await _getHeaders(),
          responseType: dio.ResponseType.json,
        ),
      );
      HeaderHandler().handleHeaders(response);
      return response;
    } on dio.DioException catch (error) {
      HeaderHandler().handleHeaders(error.response);
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future deleteData({
    required String url,
  }) async {
    await getLocalToken();
    try {
      var response = await dioClient.delete(
        url,
        options: dio.Options(
          headers: await _getHeaders(),
          responseType: dio.ResponseType.json,
        ),
      );
      HeaderHandler().handleHeaders(response);
      return response;
    } on dio.DioException catch (error) {
      HeaderHandler().handleHeaders(error.response);
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
