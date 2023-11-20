part of 'pages.dart';

class EditImage extends StatefulWidget {
  const EditImage({super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {

  File? file;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          file != null ? Expanded(child: Image.file(file!)):SizedBox.shrink(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoriesEditor(
                        giphyKey: 'API KEY',
                        //fontFamilyList: const ['Shizuru', 'Aladin'],
                        galleryThumbnailQuality: 300,
                        //isCustomFontList: true,
                        onDone: (uri) {
                          debugPrint(uri);
                          Navigator.pop(context);
                          file = File(uri);
                          setState(() {

                          });
                        },
                      )));
            },
            child: const Text('Open Image Editor'),
          ),
        ],
      ),
    );
  }
}
