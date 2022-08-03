import 'package:artivatic_profiency_exercise/Model/exercise_response.dart';
import 'package:artivatic_profiency_exercise/bloc/bloc/rows_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final RowsBloc _rowsBloc = RowsBloc();

  @override
  void initState() {
    super.initState();
    _rowsBloc.add(GetExerciseList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _rowsBloc,
        child: BlocListener<RowsBloc, RowsState>(
          listener: (context, state) {
            if (state is RowsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<RowsBloc, RowsState>(
            builder: (context, state) {
              if (state is RowsInitial) {
                return _buildLoading();
              } else if (state is RowsLoading) {
                return _buildLoading();
              } else if (state is RowsLoaded) {
                return _buildCard(context, state.exercise);
              } else if (state is RowsError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Exercise model) {
    return ListView.builder(
      itemCount: model.rows!.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.red,
          margin: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                      "Total Confirmed: ${model.rows![index]}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}