part of 'rows_bloc.dart';

abstract class RowsState extends Equatable {
  const RowsState();
  
  @override
  List<Object> get props => [];
}

class RowsInitial extends RowsState {

}
class RowsLoading extends RowsState{

}
class RowsLoaded extends RowsState{
  final Exercise exercise;
  const RowsLoaded(this.exercise);
}

class RowsError extends RowsState {
  final String? message;
  const RowsError(this.message);
}


