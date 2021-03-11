import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'file:///D:/Programming/Flutter_Projects/mylogistics/lib/model/add/add_repo.dart';
import 'package:mylogistics/model/sales/sales_values.dart';
import 'package:mylogistics/viewmodel/sales/sales_bloc.dart';
import 'package:mylogistics/viewmodel/sales/sales_events.dart';
import 'package:mylogistics/viewmodel/sales/sales_states.dart';

class SalesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocProvider.value(
              value: BlocSales(AddRepository(), SalesValues()),
              child: MySalesViewWidget())),
    );
  }
}

class MySalesViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salesBloc = BlocProvider.of<BlocSales>(context);
    final Size mediaSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        BlocBuilder<BlocSales, StateSales>(builder: (context, state) {
          return Container(
            height: mediaSize.height * .9,
            width: mediaSize.width * .8,
            margin: EdgeInsets.symmetric(
                vertical: mediaSize.height * .05,
                horizontal: mediaSize.width * .1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                      height: mediaSize.height * .07,
                      width: mediaSize.width * .3,
                      child: DropdownButton<String>(
                        isDense: false,
                        isExpanded: true,
                        items: salesBloc.initList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: state.props.single,
                        onChanged: (newValue) {
                          print("new value: $newValue");
                          salesBloc.add(EventSalesChangeSearchType(newValue));
                          print("my state: " + state.props.single);
                        },
                      )),
                  Spacer(),
                  myDropDownWidget(
                      state.props.single, mediaSize, state, salesBloc, context)
                ]),
                Column(
                  children: [
                    myChosenDropDownSelection(state.props.single, mediaSize,
                        state, salesBloc, BuildContext)
                  ],
                )
              ],
            ),
          );
        }),
      ],
    );
  }

  myDropDownWidget(String selectedDropdownValue, Size mediaSize,
      StateSales state, BlocSales sales, BuildContext context) {
    if (selectedDropdownValue == sales.initList[0]) {
      return Container(
          height: mediaSize.height * .05,
          width: mediaSize.width * .5,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(fontStyle: FontStyle.italic),
                decoration: InputDecoration(border: OutlineInputBorder())),
            suggestionsCallback: (pattern) async {
              return await BackendService.getSuggestions(pattern);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion['name']),
                subtitle: Text('\$${suggestion['category']}'),
              );
            },
            onSuggestionSelected: (suggestion) {},
          ));
    }
    if (selectedDropdownValue == sales.initList[1]) {
      return Container(
          height: mediaSize.height * .05,
          width: mediaSize.width * .5,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(fontStyle: FontStyle.italic),
                decoration: InputDecoration(border: OutlineInputBorder())),
            suggestionsCallback: (pattern) async {
              return await BackendService.getSuggestions(pattern);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion['category']),
              );
            },
            onSuggestionSelected: (suggestion) {},
          ));
    }
    if (selectedDropdownValue == sales.initList[2]) {
      return Row(
        children: [
          Container(
              height: mediaSize.height * .05,
              width: mediaSize.width * .25,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: GestureDetector(
                child: Center(
                  child: Text("start date"),
                ),
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());
                },
              )),
          Container(
              height: mediaSize.height * .05,
              width: mediaSize.width * .25,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: GestureDetector(
                child: Center(
                  child: Text("end date"),
                ),
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());
                },
              )),
        ],
      );
    } else {
      return Container(
          height: mediaSize.height * .07,
          width: mediaSize.width * .5,
          child: TextField(
              decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search),
            labelText: 'name, category, etc..',
          )));
    }
  }

  Widget myChosenDropDownSelection(String selectedDropdownValue, Size mediaSize,
      StateSales state, BlocSales sales, context) {
    if (selectedDropdownValue == sales.initList[0]) {
      return Container(
          width: mediaSize.width * .8,
          height: mediaSize.height * .8,
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    BlocBuilder/*<>*/(builder: (context, state) {
                      if (state.props.isEmpty || state.props.single == null) {
                        return GestureDetector(
                          onTap: () {
                            print("choose imahe");
                          },
                          child: Container(
                            height: mediaSize.height * .475,
                            width: mediaSize.width * .8,
                            child: Center(child: (Text("Choose file"))),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: mediaSize.height * .475,
                              width: mediaSize.width * .8,
                              child: Center(
                                  child: (Image.file(
                                    state.props.single,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                  ))),
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 1),
                              ),
                            ));
                      }
                    }),
                    Padding(
                      padding: EdgeInsets.only(bottom: mediaSize.height * .05),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: mediaSize.height * .05,
                            width: mediaSize.width * .4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: GestureDetector(
                              child: Center(
                                child: Text("start date"),
                              ),
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
                              },
                            )),
                        Container(
                            height: mediaSize.height * .05,
                            width: mediaSize.width * .4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: GestureDetector(
                              child: Center(
                                child: Text("end date"),
                              ),
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
                              },
                            )),
                      ],
                    ),
                    Container(
                      width: mediaSize.width * .8,
                      height: mediaSize.height * .3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: mediaSize.height * .05),
                    ),
                    Container(
                      width: mediaSize.width * .8,
                      height: mediaSize.height * .3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                    ),
                  ],
                );
              }));
    } else if (selectedDropdownValue == sales.initList[1]) {
      return Container(
          width: mediaSize.width * .8,
          height: mediaSize.height * .8,
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: mediaSize.height * .05,
                            width: mediaSize.width * .4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: GestureDetector(
                              child: Center(
                                child: Text("start date"),
                              ),
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
                              },
                            )),
                        Container(
                            height: mediaSize.height * .05,
                            width: mediaSize.width * .4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: GestureDetector(
                              child: Center(
                                child: Text("end date"),
                              ),
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
                              },
                            )),
                      ],
                    ),
                    Container(
                      width: mediaSize.width * .8,
                      height: mediaSize.height * .5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                              width: mediaSize.width * .8,
                              height: mediaSize.height * 1,
                            );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: mediaSize.height * .05),
                    ),
                    Container(
                      width: mediaSize.width * .8,
                      height: mediaSize.height * .3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                    ),
                  ],
                );
              }));
    } else if (selectedDropdownValue == sales.initList[2]) {
      return Container(
          width: mediaSize.width * .8,
          height: mediaSize.height * .8,
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: mediaSize.width * .8,
                      height: mediaSize.height * .5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                              width: mediaSize.width * .8,
                              height: mediaSize.height * 1,
                            );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: mediaSize.height * .05),
                    ),
                    Container(
                      width: mediaSize.width * .8,
                      height: mediaSize.height * .3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                    ),
                  ],
                );
              }));
    } else {
      return Container(
          width: mediaSize.width * .8,
          height: mediaSize.height * .8,
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: mediaSize.width * .8,
                      height: mediaSize.height * .3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                    ),
                  ],
                );
              }));
    }
  }
}

class BackendService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 500));
    return List.generate(10, (index) {
      return {
        'category': query, /*'category': Random().nextInt(100)*/
      };
    });
  }
}
