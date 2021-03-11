import 'package:equatable/equatable.dart';

class AddStateTypeAhead extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddState_FetchDataSuccessFul extends AddStateTypeAhead {
  final String _string;

  AddState_FetchDataSuccessFul(this._string);

  @override
  // TODO: implement props
  List<Object> get props => [_string];
}

class AddState_FetchDataLoading extends AddStateTypeAhead {
  final String _string;

  AddState_FetchDataLoading(this._string);

  @override
  // TODO: implement props
  List<Object> get props => [_string];
}

class AddState_FetchDataFailed extends AddStateTypeAhead {
  final String _string;

  AddState_FetchDataFailed(this._string);

  @override
  // TODO: implement props
  List<Object> get props => [_string];
}
