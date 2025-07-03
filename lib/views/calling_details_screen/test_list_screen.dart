import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/assets_constants/assets_constants.dart';
import '../../utils/color_constants/color_constants.dart';
import '../../utils/text_style_constants/text_style_constants.dart';

class TestListScreen extends StatefulWidget {
  TestListScreen({super.key});

  @override
  State<TestListScreen> createState() => _TestListScreenState();
}

class _TestListScreenState extends State<TestListScreen> {
  String? name;
  @override
  void initState() {
    super.initState();
    _loadDataFromPrefs();
  }

  Future<void> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? 'User';
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.themeColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.menu, color: Colors.black),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        title: Text('Dashboard', style: TextStyleConstants.inter18W600),
        actions: [
          Image.asset('assets/contactSupporIcon.png', height: 24),
          SizedBox(width: 16),
          Image.asset('assets/notificationIcon.png', height: 24),
          SizedBox(width: 16),
        ],
      ),
      drawer: _buildSideDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 33),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: 21, left: 30, right: 23, bottom: 25),
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Test List", style: TextStyleConstants.inter16W600),
                      SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("50",
                              style: TextStyleConstants.inter32W700
                                  .copyWith(color: ColorConstants.color2563EB)),
                          SizedBox(width: 4),
                          Text(
                            'CALLS',
                            style: TextStyleConstants.inter14W400
                                .copyWith(color: ColorConstants.blackColor),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.color2563EB,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      child: Text(
                        "S",
                        style: TextStyleConstants.inter32W700
                            .copyWith(color: ColorConstants.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 75),
            Image.asset(
              'assets/callStatusChart.png',
              height: 160,
            ),
            SizedBox(height: 85),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusCard(
                  label: "Pending",
                  count: 28,
                  bgColor: ColorConstants.colorFEF0DB,
                  lineColor: ColorConstants.colorFAAB3C,
                ),
                _buildStatusCard(
                  label: "Done",
                  count: 22,
                  bgColor: ColorConstants.colorDDFCE0,
                  lineColor: ColorConstants.color0EB01D,
                ),
                _buildStatusCard(
                  label: "Schedule",
                  count: 9,
                  bgColor: ColorConstants.colorF3EEFE,
                  lineColor: ColorConstants.color4E1BD9,
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: ColorConstants.color2563EB,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Start Calling Now',
                  style: TextStyleConstants.inter15W700
                      .copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String label,
    required int count,
    required Color bgColor,
    required Color lineColor,
  }) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: lineColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyleConstants.inter14W600
                    .copyWith(color: Colors.black),
              ),
              Text(
                "$count Calls",
                style: TextStyleConstants.inter12W400
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
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
                padding: EdgeInsets.only(left: 20, top: 30),
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
                                style: TextStyleConstants.inter18W600.copyWith(
                                    color: ColorConstants.whiteColor)
                            ),
                            Text(
                              '• Personal',
                              style: TextStyleConstants.inter14W600.copyWith(
                                  color: ColorConstants.colorFFC778),
                            )
                          ],
                        ),
                        SizedBox(height: 4),
                        Text('swati@cstech.in', style: TextStyle(color: Colors
                            .white)),
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
                  child: Text("App Info",
                      style: TextStyleConstants.inter15W700.copyWith(
                          color: ColorConstants.color2563EB)),
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