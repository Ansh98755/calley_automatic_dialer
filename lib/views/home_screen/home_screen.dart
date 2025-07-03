import 'package:calley_automatic_dialer/app_routing/app_routing.dart';
import 'package:calley_automatic_dialer/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:calley_automatic_dialer/utils/assets_constants/assets_constants.dart';
import 'package:calley_automatic_dialer/utils/color_constants/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Uri whatsappUri = Uri.parse('https://wa.me/8630847107');
  String? name;
  YoutubePlayerController? _youtubeController;
  bool showVideo = false;

  @override
  void initState() {
    super.initState();
    _loadDataFromPrefs();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'BHACKCNDMW8',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  Future<void> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name');
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
    return Scaffold(
      backgroundColor: ColorConstants.themeColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Card(
                color: ColorConstants.color2563EB,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Image.asset(AssetsConstants.profileIcon),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello $name', style:TextStyleConstants.inter13W500),
                          SizedBox(height: 4),
                          Text('Calley Personal', style: TextStyleConstants.inter18W600.copyWith(color: ColorConstants.whiteColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.color2563EB,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(15),
                child: Text(
                  'If you are here for the first time then ensure that you have uploaded the list to call from calley Web Panel hosted on https://app.getcalley.com',
                  style: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: showVideo && _youtubeController != null
                    ? YoutubePlayer(
                  controller: _youtubeController!,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: ColorConstants.colorFFC107,
                  progressColors: ProgressBarColors(
                    playedColor: ColorConstants.colorFFC107,
                    handleColor: ColorConstants.colorFFD740,
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    setState(() {
                      showVideo = true;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AssetsConstants.homeVideoImage,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        AssetsConstants.playIcon,
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _launchUrl(whatsappUri),
                    child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: ColorConstants.color0EB01D
                          )
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(AssetsConstants.whatsappIconHome),
                        )
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.goNamed(AppRouteEnum.callingDetailsScreen.name);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(260, 50),
                      backgroundColor: ColorConstants.color2563EB,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text('Start Calling Now', style: TextStyleConstants.inter15W700),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
