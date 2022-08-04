import 'dart:async';
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
  Icon actionIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text("AppBar Title");
  List<dynamic>? rowsList = [];

  @override
  void initState() {
    super.initState();
    _rowsBloc.add(GetExerciseList());
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                actionIcon = const Icon(Icons.close);
                appBarTitle = TextField(
                  onChanged: onItemChanged,
                  controller: _textController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white)),
                );
              } else {
                _rowsBloc.add(GetExerciseList());
                actionIcon = const Icon(Icons.search);
                appBarTitle = const Text("AppBar Title");
              }
            });
          },
        ),
      ]),
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
              
            },
            child: BlocBuilder<RowsBloc, RowsState>(
              builder: (context, state) {
                 if (state is RowsInitial) {
                  return _buildLoading();
                } else if (state is RowsLoading) {
                  return _buildLoading();
                }
               else if (state is RowsLoaded) {
                  completer?.complete();
                  completer = null;
                  rowsList = state.exercise.rows;
                  return _buildListView(context, rowsList!);
                } else if (state is RowsError) {
                  return Column(children: const [
                    Text("No Data Found"),
                  ]);
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

  onItemChanged(String value) {
    _rowsBloc.add(RowsSearchList(filter: value));
  }

  Widget _buildListView(BuildContext context, List<dynamic> rowsList) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: rowsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: (rowsList[index]['imageHref'] != null)
                    ? Image.network(rowsList[index]['imageHref'])
                    : Container(),
              ),
              title: (rowsList[index]['title'] != null)
                  ? Text(rowsList[index]['title'])
                  : Container(),
              subtitle: (rowsList[index]['description'] != null)
                  ? Text(rowsList[index]['description'])
                  : Container(),
            ),
          );
        });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
