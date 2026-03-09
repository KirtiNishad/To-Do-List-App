import 'package:dio/dio.dart';

class ApiBaseClient {
  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: "https://to-do-list-app-da49c-default-rtdb.firebaseio.com",
    sendTimeout: Duration(seconds: 30),
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  );

  final Dio _dio = Dio(_baseOptions);

  Future<Map<String, dynamic>> getTasks() async {
    try {
      final response = await _dio.get("/tasks.json");
      return response.data ?? {};
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> addTask(String title) async {
    try {
      final response = await _dio.post(
        "/tasks.json",
        data: {"title": title, "isCompleted": false},
      );

      return response.data["name"];
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateTask(String id, bool status) async {
    try {
      await _dio.patch("/tasks/$id.json", data: {"isCompleted": status});

      return true;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      await _dio.delete("/tasks/$id.json");
      return true;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
