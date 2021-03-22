import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mylogistics/model/add/add_repo.dart';
import 'package:mylogistics/model/utility/UtilityImageModel.dart';
import 'package:mylogistics/viewmodel/add/add_bloc.dart';
import 'package:mylogistics/viewmodel/add/add_blocdescription.dart';
import 'package:mylogistics/viewmodel/add/add_bloctypeahead.dart';
import 'package:mylogistics/viewmodel/add/add_eventdescription.dart';
import 'package:mylogistics/viewmodel/add/add_eventtypeahead.dart';
import 'package:mylogistics/viewmodel/add/add_statesdescription.dart';
import 'package:mylogistics/viewmodel/add/add_statetypeahead.dart';
import 'package:mylogistics/viewmodel/utility/utility_blocimage.dart';
import 'package:mylogistics/viewmodel/utility/utility_eventimage.dart';
import 'package:mylogistics/viewmodel/utility/utility_stateimage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(AddView());
}

class AddView extends StatelessWidget {
  final TextEditingController txtDescName = TextEditingController();
  final TextEditingController txtDescValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp(
        name: "myLogistics",
        options: FirebaseOptions(
            apiKey: "AIzaSyD522itDp3SA2t8anLKQlewWE7-4VTScxQ",
            appId: "1:726528347061:android:e80eb6ce882c532b19e7fc",
            messagingSenderId: "726528347061",
            projectId: "mylogistics-feda6"));

    {
      return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("error: " + snapshot.error.toString());
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              home: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: MultiBlocProvider(providers: [
                    BlocProvider(
                        create: (context) =>
                            AddBlocInsertData(AddRepository())),
                    BlocProvider(
                        create: (context) => AddBlocTypeAhead(AddRepository())),
                    BlocProvider(
                        create: (context) => UtilityBlocImage(
                            AddRepository(), UtilityImageModel())),
                    BlocProvider(
                        create: (context) =>
                            AddBlocDescription(AddRepository())),
                  ], child: AddViewWidget(txtDescName, txtDescValue))),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return CircularProgressIndicator();
        },
      );
    }
  }
}

class AddViewWidget extends StatelessWidget {
  AddViewWidget(this.txtDescName, this.txtDescValue);

  final TextEditingController txtDescName;
  final TextEditingController txtDescValue;

  @override
  Widget build(BuildContext context) {
    //final addBlocInsertData = BlocProvider.of<AddBlocInsertData>(context);
    // ignore: close_sinks
    final addBlocTypeAhead = BlocProvider.of<AddBlocTypeAhead>(context);
    // ignore: close_sinks
    final addBlocImage = BlocProvider.of<UtilityBlocImage>(context);
    // ignore: close_sinks
    final addBlocDescription = BlocProvider.of<AddBlocDescription>(context);
    final Size mediaSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Container(
          height: mediaSize.height * .9,
          width: mediaSize.width * .8,
          margin: EdgeInsets.symmetric(
              vertical: mediaSize.height * .05,
              horizontal: mediaSize.width * .1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: mediaSize.height * .05,
                  width: mediaSize.width * .8,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: BlocBuilder<AddBlocTypeAhead, AddStateTypeAhead>(
                      builder: (context, state) {
                    return TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                          autofocus: false,
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontStyle: FontStyle.italic),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: OutlineInputBorder(),
                              labelText: "\t\t\t\tproduct name")),
                      suggestionsCallback: (pattern) async {
                        addBlocTypeAhead.add(AddEventFetchTypeAhead(pattern));
                        return state.props.single;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion['name']),
                          subtitle: Text('\$${suggestion['category']}'),
                        );
                      },
                      onSuggestionSelected: (suggestion) {},
                    );
                  })),
              Spacer(),
              Container(
                  height: mediaSize.height * .825,
                  width: mediaSize.width * .8,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BlocBuilder<UtilityBlocImage, UtilityStatesImage>(
                              builder: (context, state) {
                            if (state.props.isEmpty ||
                                state.props.single == null) {
                              return GestureDetector(
                                onTap: () {
                                  addBlocImage.add(
                                      UtilityEventImageChangeFileImagePath());
                                },
                                child: Container(
                                  height: mediaSize.height * .475,
                                  width: mediaSize.width * .8,
                                  child: Center(child: (Text("Add Image"))),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () {
                                    addBlocImage.add(
                                        UtilityEventImageChangeFileImagePath());
                                  },
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
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                  ));
                            }
                          }),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: mediaSize.height * .05)),
                          Container(
                              height: mediaSize.height * .175,
                              width: mediaSize.width * .8,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: BlocBuilder<AddBlocDescription,
                                      AddStatesDescriptions>(
                                  builder: (context, state) {
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                      print("length: " +
                                          state.myMapDesc.length.toString());
                                      if (state.myMapDesc.values
                                              .toList()
                                              .length <
                                          1)
                                        return ListTile(
                                          title: Text("Empty"),
                                        );
                                      else {
                                        return ListTile(
                                          title: Text((state.myMapDesc.keys
                                              .elementAt(index))),
                                          subtitle: Text((state.myMapDesc.values
                                              .elementAt(index))),
                                          trailing:
                                              Icon(Icons.remove_circle_outline),
                                          onTap: () {
                                            addBlocDescription.add(
                                                DescriptionEventPop(
                                                    state.myMapDesc,
                                                    (state.myMapDesc.keys
                                                        .elementAt(index)),
                                                    (state.myMapDesc.values
                                                        .elementAt(index))));
                                          },
                                        );
                                      }
                                    },
                                    itemCount:
                                        state.myMapDesc.values.toList().length);
                              })),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: mediaSize.height * .025)),
                          Container(
                            height: mediaSize.height * .35,
                            width: mediaSize.width * .8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: mediaSize.width * .375,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextField(
                                          controller: txtDescName,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(0),
                                            border: OutlineInputBorder(),
                                            labelText: 'description name',
                                          )),
                                      TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          border: OutlineInputBorder(),
                                          labelText: 'quantity',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          border: OutlineInputBorder(),
                                          labelText: 'date entry',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: mediaSize.width * .375,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BlocBuilder<AddBlocDescription,
                                              AddStatesDescriptions>(
                                          builder: (context, state) {
                                        return TextField(
                                          controller: txtDescValue,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(0),
                                            border: OutlineInputBorder(),
                                            labelText: 'description value',
                                          ),
                                          onSubmitted: (submitValue) {
                                            addBlocDescription.add(
                                                DescriptionEventAdd(
                                                    state.myMapDesc,
                                                    txtDescName.text,
                                                    txtDescValue.text));
                                          },
                                        );
                                      }),
                                      TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          border: OutlineInputBorder(),
                                          labelText: 'price per each',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          border: OutlineInputBorder(),
                                          labelText: 'date expiration',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: 1,
                  ))
            ],
          ),
        ),
        Padding(
          child: Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.save,
                size: ((mediaSize.height + mediaSize.width) * .05),
              )),
          padding: EdgeInsets.only(
              right: mediaSize.width * .02, bottom: mediaSize.height * .01),
        )
      ],
    );
  }
}
