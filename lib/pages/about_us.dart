part of 'pages.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary10,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
                radius: 70, backgroundImage: AssetImage(AppAssets.profilePic)),
            Text(
              'Anand Patel',
              style: TextStyle(
                  fontFamily: AppFontFamily.poppins,
                  color: Color(0xfff07b3f),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(
                  fontFamily: AppFontFamily.poppins,
                  letterSpacing: 2.5,
                  color: Color(0xfff07b3f),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(
                color: Color(0xfff07b3f),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Color(0xfff07b3f),
                ),
                title: Text(
                  '+918866772933',
                  style: TextStyle(
                    fontFamily: AppFontFamily.poppins,
                    color: Color(0xfff07b3f),
                    fontSize: 20,
                  ),
                ),
              ),

            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 2,horizontal: 25),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Color(0xfff07b3f),
                ),
                title: Text(
                  'Amp25464@gmail.com',
                  style: TextStyle(
                    fontFamily: AppFontFamily.poppins,
                    color: Color(0xfff07b3f),
                    fontSize: 20,
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
