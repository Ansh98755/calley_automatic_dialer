import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import '../../app_routing/app_routing.dart';
import '../../utils/color_constants/color_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialFunction();
  }

  Future<void> initialFunction() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 500), () async{
        // bool isLoggedIn = SharedPrefsUtils().getBool(SharedPrefsKey.isUserLoggedIn);
        // if(isLoggedIn){
          // if (mounted) {
            // await context.read<LocationBloc>().fetchLocation();
            // var userName = SharedPrefsUtils().getString(SharedPrefsKey.userName);
            // if(userName.isNotEmpty){
            //   context.read<GetPetBloc>().add(GetPetListEvent());
            // }else{
            //   context.goNamed(AppRouteEnum.completeProfileScreen.name);
            // }
          // }
        // }else{
          // if (mounted) {
          //   context.goNamed(AppRouteEnum.loginScreen.name);
          // }
        // }
          context.goNamed(AppRouteEnum.languageSelect.name);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    // return MultiBlocListener(
      // listeners: [
      //   BlocListener<GetPetBloc, GetPetState>(
      //     listener: (context, state) {
      //       if(state.getPetStatus==GetPetStatus.success) {
      //         if (state.petList.isEmpty) {
      //           context.goNamed(AppRouteEnum.createPetProfileScreen.name);
      //         } else {
      //           context.goNamed(AppRouteEnum.mainScreen.name);
      //         }
      //       }
      //     },
      //   ),
      // ],
      child:
      return Scaffold(
        backgroundColor: ColorConstants.themeColor,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          // height: SizeConfig.screenHeight,
          // width: SizeConfig.screenWidth,
          child: Center(
            child: Image.asset('assets/log.png')
          ),
        ),
      );
  }
}
