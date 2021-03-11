import 'dart:io';

import 'package:equatable/equatable.dart';

class AddStatesImage extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class UtilityStatesPlaceImageSuccessFul extends AddStatesImage {
  File file;
  UtilityStatesPlaceImageSuccessFul(this.file);

  @override
  // TODO: implement props
  List<Object> get props => [this.file];
}

class UtilityStatesPlaceImageFailed extends AddStatesImage {
  @override
  // TODO: implement props
  List<Object> get props => [];
}