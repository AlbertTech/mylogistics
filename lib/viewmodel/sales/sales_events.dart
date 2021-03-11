import 'package:equatable/equatable.dart';

class EventSales extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EventSalesChangeSearchType extends EventSales {
  final String newValue;

  EventSalesChangeSearchType(this.newValue);

  @override
  // TODO: implement props
  List<Object> get props => [this.newValue];
}
