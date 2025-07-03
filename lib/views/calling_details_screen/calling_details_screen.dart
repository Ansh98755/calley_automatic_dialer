import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_routing/app_routing.dart';
import '../../utils/assets_constants/assets_constants.dart';
import '../../utils/color_constants/color_constants.dart';
import '../../utils/text_style_constants/text_style_constants.dart';

class CallingDetailsScreen extends StatefulWidget {
  const CallingDetailsScreen({super.key});

  @override
  State<CallingDetailsScreen> createState() => _CallingDetailsScreenState();
}

class _CallingDetailsScreenState extends State<CallingDetailsScreen> {
  bool _showBottomNavigation = false;
  String? name;
  String? email;
  final Uri whatsappUri = Uri.parse('https://wa.me/8630847107');

  @override
  void initState() {
    super.initState();
    _loadDataFromPrefs();
  }

  Future<void> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? 'User';
      email = prefs.getString('user_email') ?? 'User';
    });
  }

  void _onStartCallingPressed() {
    setState(() {
      _showBottomNavigation = true;
    });
  }

  void _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Scaffold(
      backgroundColor: ColorConstants.themeColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text('Dashboard', style: TextStyleConstants.inter18W600),
        actions: [
          Image.asset('assets/contactSupporIcon.png'),
          SizedBox(width: 20),
          Image.asset('assets/notificationIcon.png'),
          SizedBox(width: 20),
        ],
        elevation: 0,
      ),
      drawer: _buildSideDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Container
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorConstants.color2563EB,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Image.asset(AssetsConstants.profileIcon),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello $name',
                          style: TextStyle(color: ColorConstants.whiteColor)),
                      SizedBox(height: 4),
                      Text('Calley Personal',
                          style: TextStyle(color: ColorConstants.whiteColor)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // color: ColorConstants.color11294D,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "LOAD NUMBER TO CALL",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            Image.asset('assets/loadNumbers.png'),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _launchUrl(whatsappUri),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                      Border.all(color: ColorConstants.color0EB01D),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Image.asset(AssetsConstants.whatsappIconHome),
                  ),
                ),
                ElevatedButton(
                  onPressed: _onStartCallingPressed,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(260, 50),
                    backgroundColor: ColorConstants.color2563EB,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Start Calling Now',
                    style: TextStyleConstants.inter15W700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _showBottomNavigation
          ? Container(
        decoration: BoxDecoration(
          color: ColorConstants.colorEEF7FF,
          borderRadius: BorderRadius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: ColorConstants.color2563EB,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            if (index == 2) {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => _buildCallingListBottomSheet(),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.upload_file), label: "Upload"),
            BottomNavigationBarItem(
                icon: Icon(Icons.play_circle), label: "Call"),
            BottomNavigationBarItem(
                icon: Icon(Icons.call), label: "Dialer"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      )
          : null,
    );
  }
  Widget _buildCallingListBottomSheet() {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: ColorConstants.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            decoration: BoxDecoration(
              color: ColorConstants.colorEFF6FF,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Calling List"),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.color2563EB,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(
                    Icons.refresh,
                    color: ColorConstants.whiteColor,
                  ),
                  label: Text(
                    "Refresh",
                    style: TextStyleConstants.inter14W500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 26),
            decoration: BoxDecoration(
              color: ColorConstants.colorEFF6FF,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Test List"),
                GestureDetector(
                    onTap: () {
                      context.goNamed(AppRouteEnum.testListScreen.name);
                    },
                    child: Image.asset('assets/testListIcon.png')
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSideDrawer() {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: ColorConstants.color2563EB,
                height: 100,
                padding: EdgeInsets.only(left: 20,top: 30),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(AssetsConstants.profileIcon),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '$name',
                              style: TextStyleConstants.inter18W600.copyWith(color: ColorConstants.whiteColor)
                            ),
                            Text(
                              '• Personal',
                              style: TextStyleConstants.inter14W600.copyWith(color: ColorConstants.colorFFC778),
                            )
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$email', style: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.whiteColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Menu items
              _buildDrawerItem('assets/startIcon.png', 'Getting Started'),
              _buildDrawerItem('assets/syncIcon.png', 'Sync Data'),
              _buildDrawerItem('assets/gamificationIcon.png', 'Gamification'),
              _buildDrawerItem('assets/logsIcon.png', 'Send Logs'),
              _buildDrawerItem('assets/settingsIcon.png', 'Settings'),
              _buildDrawerItem('assets/helpIcon.png', 'Help?'),
              _buildDrawerItem('assets/cancelIcon.png', 'Cancel Subscription'),

              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("App Info", style: TextStyleConstants.inter15W700.copyWith(color: ColorConstants.color2563EB)),
                ),
              ),
              _buildDrawerItem('assets/aboutIcon.png', 'About Us'),
              _buildDrawerItem('assets/privacyIcon.png', 'Privacy Policy'),
              _buildDrawerItem('assets/versionIcon.png', 'Version 1.01.52'),
              _buildDrawerItem('assets/shareIcon.png', 'Share App'),
              _buildDrawerItem('assets/logoutIcon.png', 'Logout'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String imagePath, String title) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.whiteColor
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset(
            imagePath,
            height: 24,
            width: 24,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyleConstants.inter15W500,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
  }


