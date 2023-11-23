part of 'pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with ValidationMixin {
  //
  final AuthenticationBloc _authenticationBloc = GetIt.I<AuthenticationBloc>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _passwordVisible = true;

  Future<void> _signInHandler() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (await ConnectivityService.isConnected) {
        _authenticationBloc.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
      } else {
        SnackUtils(context).showSnakBar(noConnectionMessage);
      }
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: _authenticationBloc,
          listener: (context, state) {
            switch (state.status) {
              case ResultStatus.loading:
                Loader.show(context);
                break;
              case ResultStatus.success:
                Loader.dismiss(context);
                SnackUtils(context).showSnakBar(state.message);

                Future.delayed(const Duration(milliseconds: 500), () {
                  PreferencesService.pref!.setBool("isLogin", true);
                  Navigator.pushReplacementNamed(context, Routes.home);
                });

                break;
              case ResultStatus.failure:
                Loader.dismiss(context);
                SnackUtils(context).showSnakBar(state.message);
                break;
              default:
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(Sizes.s16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: Sizes.s24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: Sizes.s20.h),
                    Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.s14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    SizedBox(height: Sizes.s20.h),
                    _buildSignInForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Sizes.s20.h),
          decoration: BoxDecoration(
              color: const Color(0xffF7F7F7),
              borderRadius: BorderRadius.circular(Sizes.s24.h)),
          child: Column(
            children: [
              PrimaryTextField(
                controller: _email,
                labelText: 'Email',
                icon: Icons.email_outlined,
                validator: emailAddressValidation,
              ),
              SizedBox(height: Sizes.s20.h),
              PrimaryTextField(
                controller: _password,
                labelText: 'Password',
                icon: Icons.lock_outline,
                obscureText: _passwordVisible,
                validator: passwordValidation,
                suffix: InkWell(
                  child: Icon(
                    _passwordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: Sizes.s20.sp,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: Sizes.s20.h),
              PrimaryButton(label: 'Sign In', onPressed: _signInHandler),
              SizedBox(height: Sizes.s20.h),
            ],
          ),
        ),
      ],
    );
  }
}

