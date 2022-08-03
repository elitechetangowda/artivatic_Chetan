import 'package:artivatic_profiency_exercise/Model/exercise_response.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Exercise> fetchCovidList() {
    return _provider.fetchExerciseList();
  }
}