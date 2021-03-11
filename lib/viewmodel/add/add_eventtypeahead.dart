import 'package:equatable/equatable.dart';

class AddEventTypeAhead extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AddEventFetchTypeAhead extends AddEventTypeAhead {
  final String pattern;

  AddEventFetchTypeAhead(this.pattern);
@override
  // TODO: implement props
  List<Object> get props => [this.pattern];
}