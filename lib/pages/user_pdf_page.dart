part of 'pages.dart';

class UsersPDFScreen extends StatefulWidget {
  final List<UserData> users;
  const UsersPDFScreen(this.users, {Key? key}) : super(key: key);

  @override
  State<UsersPDFScreen> createState() => _UsersPDFScreenState();
}

class _UsersPDFScreenState extends State<UsersPDFScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
                child: PdfPreview(
                  pageFormats: const {
                    'A4': PdfPageFormat.a4,
                  },
                  useActions: false,
                  build: (context) {
                    return CreateUsersDataPdf(widget.users);
                  },
                ),
              ),

      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.s16.w, vertical: Sizes.s8.h),
          child: PrimaryButton(
              label: 'Download and share',
              onPressed: () async{
                //Directory dir = Directory('/storage/emulated/0/Download');
                Directory? dir = await getExternalStorageDirectory();
                 XFile file = XFile("${dir!.path}/" + "Users.pdf");
              })),
    );
  }
}
