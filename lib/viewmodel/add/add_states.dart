import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AddStateInsertData extends Equatable {
  final String myValue;

  AddStateInsertData({@required this.myValue});

  @override
  // TODO: implement props
  List<Object> get props => [];

}

class StringFound extends AddStateInsertData {
  final _string;

  StringFound(this._string);

  @override
  // TODO: implement myValue
  String get myValue => _string;
}

class SearchStringFailed extends AddStateInsertData {
  final _string;

  SearchStringFailed(this._string);

  @override
  // TODO: implement myValue
  String get myValue => _string;
}
