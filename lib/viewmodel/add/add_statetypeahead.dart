import 'package:equatable/equatable.dart';

class AddStateTypeAhead extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddStateFetchDataSuccessFul extends AddStateTypeAhead {
  final String _string;

  AddStateFetchDataSuccessFul(this._string);

  @override
  // TODO: implement props
  List<Object> get props => [_string];
}

class AddStateFetchDataLoading extends AddStateTypeAhead {
  final String _string;

  AddStateFetchDataLoading(this._string);

  @override
  // TODO: implement props
  List<Object> get props => [_string];
}

class AddStateFetchDataFailed extends AddStateTypeAhead {
  final String _string;

  AddStateFetchDataFailed(this._string);

  @override
  // TODO: implement props
  List<Object> get props => [_string];
}
