import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:mylogistics/model/add/add_repo.dart';

import '../../model/utility/UtilityImageModel.dart';
import 'utility_eventimage.dart';
import 'utility_stateimage.dart';

class UtilityBlocImage extends Bloc<AddEventImage, AddStatesImage> {
  AddRepository addRepository;
  AddImageModel addImageModel;

  UtilityBlocImage(this.addRepository, this.addImageModel)
      : super(AddStatesImage());

  @override
  Stream<AddStatesImage> mapEventToState(AddEventImage event) async* {
    addImageModel = new AddImageModel();
    if (event is UtilityEventImage_ChangeFileImagePath) {
      print("now selection");
      try {

        yield UtilityStatesPlaceImageSuccessFul(await addRepository.fetchImageSelected());
      } catch (e) {
        print("failed:" + e.toString() + " ");
        yield UtilityStatesPlaceImageFailed();
      }
    }
  }

  @override
  Future<void> close() {
    UtilityBlocImage(addRepository, addImageModel).close();
    return super.close();
  }
}
