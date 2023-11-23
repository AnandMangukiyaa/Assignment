part of 'pages.dart';

String? filePath;

Future<Uint8List> CreateUsersDataPdf(List<UserData> users) async{
  List<String> experts = [AppAssets.expert1,AppAssets.expert2,AppAssets.expert3,AppAssets.expert4,AppAssets.expert5,AppAssets.profilePic];

  final pdf = pw.Document();
  List<Uint8List> images = [];
  final font = await PdfGoogleFonts.poppinsRegular();
  for(int i = 0; i < experts.length; i++){
    final img = await rootBundle.load(experts[i]);
    final imageBytes = img.buffer.asUint8List();
    images.add(imageBytes);
  }
  pdf.addPage(
    pw.MultiPage(build: (contex) {
       return [pw.Padding(
         padding: pw.EdgeInsets.only(top:Sizes.s16.h,left: Sizes.s8.w,right: Sizes.s8.w),
         child: pw.ListView.separated(itemBuilder: (contex,ind) {
           final randomImageIndex = Random().nextInt(experts.length);
           final randomImageAsset = images[randomImageIndex];
           UserData user = users[ind]!;
           return pw.Container(
             padding: pw.EdgeInsets.all(Sizes.s2.w),
             foregroundDecoration: pw.BoxDecoration(
                 borderRadius: pw.BorderRadius.all(pw.Radius.circular(Sizes.s6.sp)),
                 boxShadow: [pw.BoxShadow(color: PdfColors.grey,offset: PdfPoint(0.5, 0.5),blurRadius: 0.5,spreadRadius: 2)],
                 border: pw.Border.all(color: PdfColors.grey,width: 1)
             ),
             child: pw.Row(
               children: [
                 pw.SizedBox(
                   height: Sizes.s100.h,
                   width: Sizes.s100.w,
                   child: pw.Image(pw.MemoryImage(randomImageAsset))
                 ),
                 pw.SizedBox(width: Sizes.s8.w,),
                 pw.Column(
                   mainAxisSize: pw.MainAxisSize.min,
                   crossAxisAlignment: pw.CrossAxisAlignment.start,
                   children: [
                     pw.SizedBox(width:Sizes.s180.w,child: pw.Text("${user!.name}",style: pw.TextStyle(font: font,color: PdfColors.black,fontSize: Sizes.s16.sp),)),

                     pw.SizedBox(height: Sizes.s4.h,),
                     pw.SizedBox(
                       width: Sizes.s220.w,
                       child: pw.Row(
                         children: [
                           pw.Expanded(child: pw.Text(user!.email!,style: pw.TextStyle(font: font,fontSize: Sizes.s14.sp,color: PdfColors.black),)),
                         ],
                       ),
                     ),
                     pw.SizedBox(height: Sizes.s4.h,),
                     pw.Row(
                       children: [
                         pw.Text("Gender : ${user!.gender! == Gender.MALE ? "Male" : "Female"}",style: pw.TextStyle(font: font,fontSize: Sizes.s14.sp,color: PdfColors.black),),
                         pw.SizedBox(width: Sizes.s8.w,),
                         pw.Text("${user!.status! == Status.ACTIVE ? "Active" :"Inactive"}",style: pw.TextStyle(font: font,fontSize: Sizes.s14.sp,color: user!.status! == Status.ACTIVE? PdfColors.green:PdfColors.red),),
                       ],
                     )
                   ],
                 ),
               ],
             ),
           );

         }, separatorBuilder: (contex,ind){
           return pw.SizedBox(height: Sizes.s16.h,);
         }, itemCount: users.length)
       )];
    })
  );

  Directory? dir = await getExternalStorageDirectory();
  File file = File("${dir!.path}/" +
      "Users.pdf");
  //  print(dir.path);
  File urlFile = await file.writeAsBytes(await pdf.save());
  // print(urlFile.absolute.path);
  filePath = urlFile.absolute.path;
  if (filePath != null) {
    /*SnackUtils.showSnak(
      "Download successfully !! \n you can find your pdf at : \n ${filePath!}",
    );*/

    await file.writeAsBytes(await pdf.save());
    filePath = file.absolute.path;
  }
  return pdf.save();

}