import 'package:equatable/equatable.dart';

class AddStatesDescriptions extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

  Map<dynamic, dynamic> get myMapDesc => {};
}

class DescriptionStatesPush extends AddStatesDescriptions {
  final Map myMap;

  DescriptionStatesPush(this.myMap);

  @override
  // TODO: implement props
  List<Object> get props => [myMap];

  @override
  Map get myMapDesc => (props.asMap().values.map((e) {
        Map map;
        map = e;
        return map;
      }).single);
}

class DescriptionStatesPop extends AddStatesDescriptions {
  final Map myMap;

  DescriptionStatesPop(this.myMap);

  @override
  // TODO: implement props
  List<Object> get props => [myMap];

  @override
  Map get myMapDesc => (props.asMap().values.map((e) {
    Map map;
    map = e;
    return map;
  }).single);
}
