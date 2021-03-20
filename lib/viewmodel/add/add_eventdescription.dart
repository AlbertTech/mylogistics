import 'package:equatable/equatable.dart';

class AddEventDescription extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DescriptionEventAdd extends AddEventDescription {
  final String myName, myValue;
  final Map myMapDesc;

  DescriptionEventAdd(this.myMapDesc, this.myName, this.myValue);

  @override
  // TODO: implement props
  List<Object> get props => [this.myMapDesc, this.myName, this.myValue];
}

class DescriptionEventPop extends AddEventDescription {
  final Map myOldMap;

  final String valueToDelete;
  final String nameToDelete;

  DescriptionEventPop(this.myOldMap,this.nameToDelete, this.valueToDelete,);

  @override
  // TODO: implement props
  List<Object> get props => [myOldMap, nameToDelete, valueToDelete];
}
