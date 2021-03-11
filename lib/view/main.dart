import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mylogistics/model/add/add_repo.dart';
import 'package:mylogistics/model/utility/UtilityImageModel.dart';
import 'package:mylogistics/viewmodel/add/add_bloc.dart';
import 'package:mylogistics/viewmodel/add/add_bloctypeahead.dart';
import 'package:mylogistics/viewmodel/add/add_eventtypeahead.dart';
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
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp(
        name: "myLogistics",
        options: FirebaseOptions(
            apiKey: "AIzaSyD522itDp3SA2t8anLKQlewWE7-4VTScxQ",
            appId: "1:726528347061:android:e80eb6ce882c532b19e7fc",
            messagingSenderId:"726528347061",
            projectId:"mylogistics-feda6"));

    {
      return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("error: "+snapshot.error.toString());
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              home: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: MultiBlocProvider(providers: [
                    BlocProvider(
                        create: (context) => AddBlocInsertData(AddRepository())),
                    BlocProvider(
                        create: (context) => AddBlocTypeAhead(AddRepository())),
                    BlocProvider(
                        create: (context) =>
                            UtilityBlocImage(AddRepository(), UtilityImageModel())),
                  ], child: AddViewWidget())),
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
  @override
  Widget build(BuildContext context) {
    //final addBlocInsertData = BlocProvider.of<AddBlocInsertData>(context);
    // ignore: close_sinks
    final addBlocTypeAhead = BlocProvider.of<AddBlocTypeAhead>(context);
    // ignore: close_sinks
    final addBlocImage = BlocProvider.of<UtilityBlocImage>(context);
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
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
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
              BlocBuilder<UtilityBlocImage, AddStatesImage>(
                  builder: (context, state) {
                if (state.props.isEmpty || state.props.single == null) {
                  return GestureDetector(
                    onTap: () {
                      addBlocImage.add(UtilityEventImageChangeFileImagePath());
                    },
                    child: Container(
                      height: mediaSize.height * .475,
                      width: mediaSize.width * .8,
                      child: Center(child: (Text("Add Image"))),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                      onTap: () {
                        addBlocImage
                            .add(UtilityEventImageChangeFileImagePath());
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
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                      ));
                }
              }),
              Container(
                height: mediaSize.height * .35,
                width: mediaSize.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: mediaSize.width * .375,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: mediaSize.width * .375,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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