import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ObjectState extends Equatable {
  ObjectState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class Init extends ObjectState {}

class Empty extends ObjectState {}

class Loading extends ObjectState {}

class Loaded extends ObjectState {
  final dynamic object;

  Loaded({@required this.object});

  @override
  List<Object> get props => [object];
}

class Error extends ObjectState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
