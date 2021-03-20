import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mylogistics/model/add/add_repo.dart';
import 'package:mylogistics/model/utility/UtilityImageModel.dart';
import 'package:mylogistics/view/sales_view.dart';
import 'package:mylogistics/viewmodel/add/add_bloc.dart';
import 'package:mylogistics/viewmodel/utility/utility_blocimage.dart';
import 'package:mylogistics/viewmodel/utility/utility_eventimage.dart';
import 'package:mylogistics/viewmodel/utility/utility_stateimage.dart';


class ViewProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body:  MultiBlocProvider(providers: [
            BlocProvider(
                create: (context) => AddBlocInsertData(AddRepository())),
            BlocProvider(
                create: (context) =>
                    UtilityBlocImage(AddRepository(), UtilityImageModel())),
          ], child: MyViewProductWidget())),
    );
  }
}

class MyViewProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final mainBloc = BlocProvider.of<AddBlocInsertData>(context);
    // ignore: close_sinks
    final utilityBlocImage = BlocProvider.of<UtilityBlocImage>(context);
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
                  )),
              Spacer(),
              BlocBuilder<UtilityBlocImage, UtilityStatesImage>(
                  builder: (context, state) {
                    if (state.props.isEmpty || state.props.single == null) {
                      return GestureDetector(
                        onTap: () {
                          utilityBlocImage.add(UtilityEventImageChangeFileImagePath());
                        },
                        child: Container(
                          height: mediaSize.height * .375,
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
                            utilityBlocImage.add(UtilityEventImageChangeFileImagePath());
                          },
                          child: Container(
                            height: mediaSize.height * .4,
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
              Spacer(),
              Container(
                height: mediaSize.height * .225,
                width: mediaSize.width * .8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              ),
              Spacer(),
              Container(
                height: mediaSize.height * .2,
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
