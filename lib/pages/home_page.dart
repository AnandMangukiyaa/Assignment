part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String? email = PreferencesService.pref!.getString("email");
    return Scaffold(
      appBar: AppBars.backAppBar(context, title: selectedIndex == 0 ? "About Me":"Contact Me"),
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
          ],
        ),
      ),
      body:  selectedIndex ==0 ? AboutUs():ContactUs(companyName: "CrystalClear", textColor: AppColors.secondary, cardColor: Colors.white, companyColor: AppColors.primary10, taglineColor: AppColors.primary10, email: "Amp25464@gmail.com",image: Image.asset(AppAssets.profilePic),emailText: "Amp25464@gmail.com",phoneNumber: "+918866772933",phoneNumberText: "+918866772933",githubUserName: "AnandMangukiyaa", instagram: "https://www.instagram.com/_demo_official/?hl=en",websiteText: "https://google.com",website: "https://google.com"),
    );
  }
}
