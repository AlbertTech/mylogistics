import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:mylogistics/model/add/add_repo.dart';
import 'package:mylogistics/model/utility/UtilityImageModel.dart';
import 'utility_eventimage.dart';
import 'utility_stateimage.dart';

class UtilityBlocImage extends Bloc<UtilityEventImage, UtilityStatesImage> {
  AddRepository addRepository;
  UtilityImageModel addImageModel;

  UtilityBlocImage(this.addRepository, this.addImageModel)
      : super(UtilityStatesImage());

  @override
  Stream<UtilityStatesImage> mapEventToState(UtilityEventImage event) async* {
    addImageModel = new UtilityImageModel();
    if (event is UtilityEventImageChangeFileImagePath) {
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
