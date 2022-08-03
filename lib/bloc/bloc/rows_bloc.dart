import 'dart:async';

import 'package:artivatic_profiency_exercise/Model/exercise_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rows_event.dart';
part 'rows_state.dart';

class RowsBloc extends Bloc<RowsEvent, RowsState> {
  RowsBloc() : super(RowsInitial());

  
 
}
