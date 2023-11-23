import 'package:equatable/equatable.dart';
import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:photo_gallery/photo_gallery.dart';

class ImagesState extends Equatable{

  final ResultStatus status;
  final List<Medium>? albums;
  final String message;


  ImagesState({this.status = ResultStatus.none, this.albums, this.message = ""});

  ImagesState update({
    ResultStatus? status,
    String? message,
    List<Medium>? albums,
  }) {
    return ImagesState(
      status: status ?? this.status,
      message: message ?? this.message,
      albums: albums ?? this.albums,
    );
  }

  @override
  List<Object> get props {
    return [status, message, albums ?? []];
  }

}