import 'package:equatable/equatable.dart';

class AddEventTypeAhead extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AddEvent_FetchTypeAhead extends AddEventTypeAhead {
  String pattern;

  AddEvent_FetchTypeAhead(this.pattern);
@override
  // TODO: implement props
  List<Object> get props => [this.pattern];
}