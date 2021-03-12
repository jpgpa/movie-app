import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ListState extends Equatable {
  ListState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class Init extends ListState {}

class Empty extends ListState {}

class Loading extends ListState {}

class Loaded extends ListState {
  final dynamic list;

  Loaded({@required this.list});

  @override
  List<Object> get props => [list];
}

class Error extends ListState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
