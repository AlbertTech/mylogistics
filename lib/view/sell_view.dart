import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylogistics/model/add/add_repo.dart';
import 'package:mylogistics/view/sales_view.dart';
import 'package:mylogistics/viewmodel/add/add_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SellView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocProvider(
              create: (context) => AddBlocInsertData(AddRepository()),
              child: MySellViewWidget())),
    );
  }
}

class MySellViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final mainBloc = BlocProvider.of<AddBlocInsertData>(context);
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
                  height: mediaSize.height * .07,
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
              Container(
                height: mediaSize.height * .4,
                width: mediaSize.width * .8,
                child: Center(
                    child: Text(
                  "Image here",
                  textAlign: TextAlign.center,
                )),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              ),
              Spacer(),
              Container(
                height: mediaSize.height * .2,
                width: mediaSize.width * .8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              ),
              Container(
                height: mediaSize.height * .2,
                width: mediaSize.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                Icons.monetization_on,
                size: ((mediaSize.height + mediaSize.width) * .05),
              )),
          padding: EdgeInsets.only(
              right: mediaSize.width * .02, bottom: mediaSize.height * .01),
        )
      ],
    );
  }
}
