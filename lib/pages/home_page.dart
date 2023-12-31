part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  checkToken() async{
    Future.delayed(Duration(minutes: 1)).then((value) {
      try{
        String? email = PreferencesService.pref!.getString("email");
        String? password = PreferencesService.pref!.getString("password");
        String? token = PreferencesService.pref!.getString("${email}Token");

        String pass = "${email}MyToken${password}";

        JWT.verify(token!, SecretKey(pass));
        checkToken();
      } on JWTExpiredException catch (e){
        PreferencesService.pref!.setBool("isLogin", false);
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String? email = PreferencesService.pref!.getString("email");
    return Scaffold(
      appBar: AppBars.backAppBar(context, title: selectedIndex == 0 ? "About Me": selectedIndex == 1 ? "Contact Me": selectedIndex == 2 ?"Image Editor":selectedIndex == 3 ? "Saved Images":"Users"),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primary),
              accountName: Text(
                "Demo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: Sizes.s16.sp
                ),
              ),
              accountEmail: Text(
                email!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: Sizes.s14.sp
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
              ),
              title: const Text('About Me'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.contact_phone_rounded,
              ),
              title: const Text('Contact Me'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.image_sharp,
              ),
              title: const Text('Edit Image'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
              ),
              title: const Text('Saved Image'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 3;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
              ),
              title: const Text('Users'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
      body:  selectedIndex ==0 ? AboutUs():selectedIndex == 1 ? ContactUs(companyName: "CrystalClear", textColor: AppColors.secondary, cardColor: Colors.white, companyColor: AppColors.primary10, taglineColor: AppColors.primary10, email: "Amp25464@gmail.com",image: Image.asset(AppAssets.profilePic),emailText: "Amp25464@gmail.com",phoneNumber: "+918866772933",phoneNumberText: "+918866772933",githubUserName: "AnandMangukiyaa", instagram: "https://www.instagram.com/_demo_official/?hl=en",websiteText: "https://google.com",website: "https://google.com"):selectedIndex == 2?EditImage():selectedIndex == 3 ?SavedImages():UsersPage(),
    );
  }
}
