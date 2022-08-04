part of 'rows_bloc.dart';

abstract class RowsEvent extends Equatable {
  const RowsEvent();

  @override
  List<Object> get props => [];
}
class GetExerciseList extends RowsEvent {}
class RowsSearchList extends RowsEvent{
    final String filter;
  const  RowsSearchList({this.filter = ""});
@override
  List<Object> get props => [filter];
}

