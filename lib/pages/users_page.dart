part of 'pages.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  UserBloc _userBloc = GetIt.I<UserBloc>();
  List<String> experts = [AppAssets.expert1,AppAssets.expert2,AppAssets.expert3,AppAssets.expert4,AppAssets.expert5,AppAssets.profilePic];

  int page = 1;
  int per_page = 20;
  ScrollController _scrollController = ScrollController();
  bool isShowing = false;

  @override
  void initState() {
_userBloc.getUsers();
_scrollController.addListener(() {
  if (_scrollController.position.pixels ==
      _scrollController.position.maxScrollExtent) {
    loadMoreData();
  }
});
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc,UserState>(bloc:_userBloc,builder: (context,state){
        if(state.status == ResultStatus.loading && _userBloc.page == 1){
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
                Text("Loading Users...",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),)
              ],
            ),
          );
        }else if(state.status == ResultStatus.success ||(state.status == ResultStatus.loading && _userBloc.page != 1)){
          if(state.status == ResultStatus.loading && _userBloc.page != 1){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Loader.show(context);
              isShowing=true;
            });

          }else{
            if(isShowing) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Loader.dismiss(context);
              isShowing=false;
            });
            }
          }
          if(state.users!.isNotEmpty) {
            return Scaffold(
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.s8.h,horizontal: Sizes.s16.w),
                  child: PrimaryButton(onPressed: () async{
                        var created = await Navigator.pushNamed(context, Routes.addUser);
                        if(created as bool){
                          _userBloc.getUsers();
                        }
                  }, label: "Add user",),
                ),
              body: Padding(
                padding: EdgeInsets.only(top:Sizes.s16.h,left: Sizes.s8.w,right: Sizes.s8.w),
                child: ListView.separated(controller:_scrollController,itemBuilder: (context,ind){
                  final randomImageIndex = Random().nextInt(experts.length);
                  final randomImageAsset = experts[randomImageIndex];
                  UserData user = state.users[ind]!;
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        Image.asset(
                          randomImageAsset,
                          height: Sizes.s100.h,
                          width: Sizes.s100.w,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: Sizes.s8.w,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width:Sizes.s180.w,child: Text("${user!.name}",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),)),
                                IconButton(onPressed: () async{
                                  var updated = await Navigator.pushNamed(context, Routes.addUser,arguments: user);
                                  if(updated as bool){
                                    _userBloc.getUsers();
                                  }
                                }, icon: Icon(Icons.mode_edit_outline_outlined,color: AppColors.primary,))
                              ],
                            ),
                            SizedBox(height: Sizes.s4.h,),
                            SizedBox(
                              width: Sizes.s220.w,
                              child: Row(
                                children: [
                                  Expanded(child: Text(user!.email!,style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s14.sp,color: Colors.black,fontWeight: FontWeight.w400),)),
                                ],
                              ),
                            ),
                            SizedBox(height: Sizes.s4.h,),
                            Row(
                              children: [
                                Text("Gender : ${user!.gender! == Gender.MALE ? "Male" : "Female"}",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s14.sp,color: Colors.black,fontWeight: FontWeight.w400),),
                                SizedBox(width: Sizes.s8.w,),
                                Text("${user!.status! == Status.ACTIVE ? "Active" :"Inactive"}",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s14.sp,color: user!.status! == Status.ACTIVE? Colors.green:Colors.red,fontWeight: FontWeight.w400),),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }, separatorBuilder: (context,ind){
                  return SizedBox(height: Sizes.s16.h,);
                }, itemCount: state.users.length),
              )
            );
          }else{
            return Center(
              child:Text("No Users Found!",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),) ,
            );
          }
        }else{
          if(state.message.contains("internet")){
            return Center(
              child:Text("${state.message}",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),) ,
            );
          }else {
              return Center(
                child: Text(
                  "No Users Found!",
                  style: TextStyle(
                      fontFamily: AppFontFamily.poppins,
                      fontSize: Sizes.s16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              );
            }
          }



      });
  }

  void loadMoreData() {
    _userBloc.getUsers();
  }
}
