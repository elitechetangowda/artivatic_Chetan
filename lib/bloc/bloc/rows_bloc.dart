import 'dart:async';

import 'package:artivatic_profiency_exercise/Model/exercise_response.dart';
import 'package:artivatic_profiency_exercise/resources/api_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rows_event.dart';
part 'rows_state.dart';

class RowsBloc extends Bloc<RowsEvent, RowsState> {
  RowsBloc() : super(RowsInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetExerciseList>((event, emit) async {
      try {
        emit(RowsLoading());
        final mList = await _apiRepository.fetchExerciseList();
        emit(RowsLoaded(mList));
      } on NetworkError {
        emit( const RowsError("Failed to fetch data. is your device online?"));
      }
    });
  }
}

