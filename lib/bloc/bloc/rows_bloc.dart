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
    String? filterText = "";
    Exercise mlist;
    List<dynamic> mainList = [];
    on<GetExerciseList>((event, emit) async {
      try {
        emit(RowsLoading());
        mlist = await _apiRepository.fetchExerciseList();
        mainList.add(mlist);
        emit(RowsLoaded(mlist));
      } on NetworkError {
        emit(const RowsError("Failed to fetch data. Please check your Internet connection?"));
      }
    });

    // ignore: void_checks
    on<RowsSearchList>((event, emit) {
      filterText = event.filter;
      if (filterText!.isEmpty) {
        return mainList;
      }
      Exercise? searchvalues;
      List<dynamic> searchList = [];
      List<dynamic> rowsList = [];
      searchList = mainList[0].rows;
      for (var value in searchList) {
        if (value["title"] != null &&
            value["title"].toLowerCase().contains(filterText!.toLowerCase())) {
          rowsList.add(value);
          searchvalues = Exercise(rows: rowsList, title: "");
        }else{
         emit(const RowsError('No Record Found'));
        }
      }
      emit(RowsLoaded(searchvalues!));
    });
  }
}
