part of 'pages.dart';

class SavedImages extends StatefulWidget {
  const SavedImages({super.key});

  @override
  State<SavedImages> createState() => _SavedImagesState();
}

class _SavedImagesState extends State<SavedImages> {
  List<Album> _albums = [];

  ImagesBloc _imagesBloc = GetIt.I<ImagesBloc>();
  @override
  void initState() {
_imagesBloc.getAlbums();
super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesBloc,ImagesState>(bloc:_imagesBloc,builder: (context,state){
        if(state.status == ResultStatus.loading){
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Sizes.s44.h,
                  width: Sizes.s44.w,
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                SizedBox(height: Sizes.s8.h,),
                Text("Loading Images...",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),)
              ],
            ),
          );
        }else if(state.status == ResultStatus.success){
          if(state.albums!.isNotEmpty) {
            return Scaffold(
              body: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                children: [
                  ...?state.albums!.map(
                        (medium) => Container(
                          color: Colors.grey[300],
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: MemoryImage(kTransparentImage),
                            image: ThumbnailProvider(
                              mediumId: medium.id,
                              mediumType: medium.mediumType,
                              highQuality: true,
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            );
          }else{
            return Center(
              child:Text("No Images Stored!",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),) ,
            );
          }
        }else{
          return Center(
            child:Text("No Images Found!",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),) ,
          );
        }



    });
  }
}
