import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'file:///D:/Programming/Flutter_Projects/mylogistics/lib/model/add/add_repo.dart';
import 'package:mylogistics/model/sales/sales_values.dart';
import 'dart:async';
import 'sales_events.dart';
import 'sales_states.dart';

class BlocSales extends Bloc<EventSales, StateSales> {
  AddRepository mainRepository;
  SalesValues salesValues;

  BlocSales(this.mainRepository, this.salesValues)
      : super(StateSales(dropdownValue: salesValues.getMyDropDownValue));

  List<String> get initList => salesValues.getMyDropDownList;

  @override
  Stream<StateSales> mapEventToState(EventSales event) async* {
    if (event is EventSalesChangeSearchType) {
      print("event selected: " + event.props.single);

      yield StateSalesChangeDropDownValue(event.props.single);
    }
  }

  @override
  Future<void> close() {
    BlocSales(mainRepository, salesValues).close();
    return super.close();
  }
}
