import 'package:artivatic_profiency_exercise/Model/exercise_response.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Exercise> fetchExerciseList() {
    return _provider.fetchExerciseList();
  }
}

class NetworkError extends Error {}
