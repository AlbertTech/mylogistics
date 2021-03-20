import 'package:bloc/bloc.dart';
import 'package:mylogistics/model/add/add_repo.dart';
import 'package:mylogistics/viewmodel/add/add_eventdescription.dart';
import 'package:mylogistics/viewmodel/add/add_statesdescription.dart';

class AddBlocDescription
    extends Bloc<AddEventDescription, AddStatesDescriptions> {
  AddRepository addRepository;

  AddBlocDescription(this.addRepository) : super(AddStatesDescriptions());

  @override
  Stream<AddStatesDescriptions> mapEventToState(
      AddEventDescription event) async* {
    if (event is DescriptionEventAdd) {
      yield DescriptionStatesPush(addRepository.incrementDesc(event.props.toList()));
    } else if (event is DescriptionEventPop) {
      yield DescriptionStatesPop(addRepository.decrementDesc(event.props.toList()));
    }
  }
}
