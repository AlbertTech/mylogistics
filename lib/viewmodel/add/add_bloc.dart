import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:mylogistics/model/add/add_repo.dart';
import 'dart:async';

import 'package:mylogistics/viewmodel/add/add_events.dart';
import 'package:mylogistics/viewmodel/add/add_states.dart';


class AddBlocInsertData extends Bloc<EventAddInsertData, AddStateInsertData> {
  AddRepository addRepository;

  AddBlocInsertData(this.addRepository) : super(AddStateInsertData(myValue: "Date"));


  @override
  Stream<AddStateInsertData> mapEventToState(EventAddInsertData event) async* {
    if (event is FetchString) {
      try {
        yield StringFound(await addRepository.fetchText());
      } catch (error) {
        yield SearchStringFailed(error.toString());
      }
    } else {
      yield SearchStringFailed("failed");
    }
  }

  @override
  Future<void> close() {
    AddBlocInsertData(null).close();
    return super.close();
  }
}
