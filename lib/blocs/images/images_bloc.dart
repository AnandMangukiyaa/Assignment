import 'package:flutter_assignment/blocs/images/images_state.dart';
import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

class ImagesBloc extends Cubit<ImagesState>{
  ImagesBloc() : super(ImagesState());

  getAlbums() async{
    try {
      emit(state.update(status: ResultStatus.loading));
      List<Album> albums = await PhotoGallery.listAlbums(mediumType: MediumType.image);
      Album album = albums.where((element) => element.name! == "MyAssignment").toList().first;
      MediaPage mediaPage = await album.listMedia();
      emit(state.update(status: ResultStatus.success,
          albums: mediaPage.items));
    }catch (e){
      emit(state.update(status: ResultStatus.failure,
          message: "Something went wrong"));
    }

  }

}