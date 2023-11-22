part of 'pages.dart';

class EditImage extends StatefulWidget {
  const EditImage({super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {

  List<File?> files = [];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            files.isNotEmpty ? Expanded(child: Stack(
              children: [
                PageView.builder(itemBuilder: (ctx,index){
                  return Image.file(files[index]!);
                },itemCount: files.length,onPageChanged: (page){
                  setState(() {
                    currentIndex = page;
                  });
                },),
                Padding(padding: EdgeInsets.symmetric(vertical: Sizes.s24.h,horizontal: Sizes.s16.w),child: Align(alignment:Alignment.topCenter,child: Text("${currentIndex+1}/${files.length}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp),))),

              ],
            )):Center(
              child: Padding(
                padding: EdgeInsets.all(Sizes.s16.w),
                child: Text("Capture image by clicking below camera button",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp),),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: Sizes.s24.h,horizontal: Sizes.s16.w),
        child: SizedBox(
          height: Sizes.s60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async{
                  File? file = await FileUtils.pickImage(ImageSource.camera);
                  if(mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoriesEditor(
                            giphyKey: 'API KEY',
                            galleryThumbnailQuality: 300,
                            file:file,
                            onDone: (uri) {
                              debugPrint(uri);
                              Navigator.pop(context);
                              files.add(File(uri));
                              setState(() {

                              });
                            },
                          )));
                  }
                },
                child: const Icon(Icons.camera_enhance_rounded,color: Colors.white,),
              ),
              if(files.isNotEmpty)
              ...[ElevatedButton(onPressed: (){
                setState(() {
                  files.clear();
                });
              }, child: Text("Discard",style: TextStyle(color: Colors.white,fontSize: Sizes.s16.sp,fontFamily: AppFontFamily.poppins),)),
              ElevatedButton(onPressed: () async{
                if(files.isNotEmpty){
                  Loader.show(context);
                  for (int i = 0; i < files.length; i++) {
                    await saveToGallery(files[i]);
                  }
                  Loader.dismiss(context);
                  setState(() {
                    files.clear();
                  });
                }


              }, child: Text("Save to Gallery",style: TextStyle(color: Colors.white,fontSize: Sizes.s16.sp,fontFamily: AppFontFamily.poppins),))]
            ],
          ),
        ),
      ),
    );
  }

  Future saveToGallery(File? _image) async{

    String path = "";
    if(Platform.isAndroid){
      String directory = "/storage/emulated/0/Download/MyAssignment";
      if(!Directory(directory).existsSync()){
        Directory(directory).create();
      }
      path = '$directory/${DateTime.now().millisecondsSinceEpoch}.jpg';
    }else{
      path = "${(await getApplicationDocumentsDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
    }
   final image = img.decodeImage(await _image!.readAsBytes());
    _image = File(path);
    await _image!.writeAsBytes(img.encodeJpg(image!));
    await ImageGallerySaver.saveFile(_image!.path);

  }
}
