import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:mylogistics/model/add/add_repo.dart';
import 'package:mylogistics/viewmodel/add/add_eventtypeahead.dart';
import 'package:mylogistics/viewmodel/add/add_statetypeahead.dart';

class AddBlocTypeAhead extends Bloc<AddEventTypeAhead, AddStateTypeAhead> {
  AddRepository addRepository;

  AddBlocTypeAhead(this.addRepository) : super(AddStateTypeAhead());

  @override
  Stream<AddStateTypeAhead> mapEventToState(AddEventTypeAhead event) async* {
    if (event is AddEvent_FetchTypeAhead) {
      yield AddState_FetchDataSuccessFul(event.props.single);
    }
  }

  @override
  Future<void> close() {
    AddBlocTypeAhead(addRepository).close();
    return super.close();
  }
}
