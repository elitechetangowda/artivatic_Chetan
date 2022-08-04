import 'dart:async';

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
  String appTitle = '';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Completer? completer;
  @override
  void initState() {
    super.initState();
    _rowsBloc.add(GetExerciseList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
       _rowsBloc.add(GetExerciseList());
          completer = Completer();
          return completer!.future;
        },
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
                  completer?.complete();
                  completer = null;
                  return _buildListView(context, state.exercise);
                } else if (state is RowsError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, Exercise model) {
    appTitle = model.title!;
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: model.rows!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: (model.rows![index]['imageHref'] != null)
                    ? Image.network(model.rows![index]['imageHref'])
                    : Container(),
              ),
              title: (model.rows![index]['title'] != null)
                  ? Text(model.rows![index]['title'])
                  : Container(),
              subtitle: (model.rows![index]['description'] != null)
                  ? Text(model.rows![index]['description'])
                  : Container(),
            ),
          );
        });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
