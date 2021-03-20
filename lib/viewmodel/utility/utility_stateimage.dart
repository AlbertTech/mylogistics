import 'dart:io';

import 'package:equatable/equatable.dart';

class UtilityStatesImage extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}



class UtilityStatesPlaceImageSuccessFul extends UtilityStatesImage {
 final File file;
  UtilityStatesPlaceImageSuccessFul(this.file);

  @override
  // TODO: implement props
  List<Object> get props => [this.file];
}

class UtilityStatesPlaceImageFailed extends UtilityStatesImage {
  @override
  // TODO: implement props
  List<Object> get props => [];
}