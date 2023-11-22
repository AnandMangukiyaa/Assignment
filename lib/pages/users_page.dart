part of 'pages.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  UserBloc _userBloc = GetIt.I<UserBloc>();

  @override
  void initState() {
_userBloc.getUsers();
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc,UserState>(bloc:_userBloc,builder: (context,state){
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
              Text("Loading Users...",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),)
            ],
          ),
        );
      }else if(state.status == ResultStatus.success){
        if(state.users!.isNotEmpty) {
          return Scaffold(
            body: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              children: [
                ...?state.users!.map(
                      (user) => Card(
                        child: Center(
                          child: Text("${user!.name}",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),) ,
                        ),
                      ),
                ),
              ],
            ),
          );
        }else{
          return Center(
            child:Text("No Users Found!",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),) ,
          );
        }
      }else{
        return Center(
          child:Text("No Users Found!",style: TextStyle(fontFamily: AppFontFamily.poppins,fontSize: Sizes.s16.sp,color: Colors.black,fontWeight: FontWeight.w600),) ,
        );
      }



    });;
  }
}
