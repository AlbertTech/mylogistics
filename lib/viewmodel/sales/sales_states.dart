import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StateSales extends Equatable {
  final String dropdownValue;

  StateSales({@required this.dropdownValue});

  @override
  // TODO: implement props
  List<Object> get props => [this.dropdownValue];
  
}

// ignore: must_be_immutable
class StateSalesChangeDropDownValue extends StateSales {
  String _dropdownValue;

  StateSalesChangeDropDownValue(this._dropdownValue);

  @override
  // TODO: implement props
  List<Object> get props => [this._dropdownValue];
}

