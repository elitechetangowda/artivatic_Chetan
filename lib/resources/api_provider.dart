import 'package:artivatic_profiency_exercise/Model/exercise_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf';

  Future<Exercise> fetchExerciseList() async {
    try {
      Response response = await _dio.get(_url);
      return Exercise.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return Exercise.withError("Data not found / Connection issue");
    }
  }
}