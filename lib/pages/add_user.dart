part of 'pages.dart';

class AddUserPage extends StatefulWidget {
  UserData? user;
  AddUserPage({this.user,super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> with ValidationMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _status = TextEditingController();
  UserBloc _userBloc = GetIt.I<UserBloc>();

  @override
  void initState() {
    if(widget.user != null){
      _name.text = widget.user!.name!;
      _email.text = widget.user!.email!;
      _gender.text = widget.user!.gender! == Gender.MALE?"male":"female";
      _status.text = widget.user!.status! == Status.ACTIVE?"active":"inactive";
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc,UserState>(
      bloc: _userBloc,
      listener: (context,state){
        if(state.status == ResultStatus.loading){
          Loader.show(context);
        }else if(state.status == ResultStatus.success && state.users.isEmpty){
          Loader.dismiss(context);
          Navigator.pop(context,true);
          SnackUtils.showSnak("User ${widget.user != null ? "updated" : "created"} successfully");
        }else{
          Loader.dismiss(context);
          SnackUtils.showSnak(state.message);
        }
      },
      child: Scaffold(
          appBar: AppBars.backAppBar(context, title: widget.user!= null ? "Edit User":"Add User"),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                    child: Column(
                      children: [
                         SizedBox(height: Sizes.s16.h,),
                        _buildSignUpForm()
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.s8.h,horizontal: Sizes.s16.w),
            child: PrimaryButton(onPressed: (){
              if(_formKey.currentState!.validate()){
                UserData user = UserData()
                    ..name = _name.text.toString()
                    ..email = _email.text.toString()
                    ..gender = _gender.text.toString() == "male" ? Gender.MALE:Gender.FEMALE
                    ..status = _status.text.toString() == "active" ? Status.ACTIVE:Status.INACTIVE;
                if(widget.user == null) {
                  _userBloc.createUser(user);
                }else{
                  user.id = widget.user!.id!;
                  _userBloc.updateUser(user);
                }

              }
            }, label: widget.user != null? "Update":"Save",),
          ),
        )

    );
  }

  Widget _buildSignUpForm() {

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Sizes.s20.h),
          decoration: BoxDecoration(
              color: const Color(0xffF7F7F7),
              borderRadius: BorderRadius.circular(Sizes.s24.h)),
          child: Column(
            children: [
              PrimaryTextField(
                controller: _name,
                labelText: 'Name',
                icon: Icons.person_outline,
                validator: nameValidation,
              ),
              SizedBox(height: Sizes.s20.h),
              PrimaryTextField(
                controller: _email,
                labelText: 'Email',
                icon: Icons.email_outlined,
                validator: emailAddressValidation,
              ),
              SizedBox(height: Sizes.s20.h),
              PrimaryTextField(
                controller: _gender,
                labelText: 'Gender',
                readOnly: true,
                hintText: 'Select Gender',
                suffix: Icon(
                  Icons.keyboard_arrow_down,
                  size: Sizes.s20.sp,
                  color: Colors.black,
                ),
                validator: genderValidation,
                onTap: () async {
                  String? gender = await AppDialogs.showGenderPicker(context);

                  if (gender != null) {
                    _gender.text = gender;
                    setState(() {

                    });
                  }
                },
              ),
              SizedBox(height: Sizes.s20.h),
              PrimaryTextField(
                controller: _status,
                labelText: 'Status',
                hintText: 'Select Status',
                readOnly: true,
                suffix: Icon(
                  Icons.keyboard_arrow_down,
                  size: Sizes.s20.sp,
                  color: Colors.black,
                ),
                validator: statusValidation,
                onTap: () async {
                  String? status = await AppDialogs.showStatusPicker(context);

                  if (status != null) {
                    _status.text = status!;
                    setState(() {

                    });
                  }
                },
              ),

            ],
          ),
        ),
      ],
    );
  }

}
