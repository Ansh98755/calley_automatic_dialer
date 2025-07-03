part of 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSizeConfig(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(),
        ),
        BlocProvider<OtpBloc>(
          create: (_) => OtpBloc(),
          child: VerifyOtpScreen(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: AppRouting.appRouter,
        title: StringConstants.furrvy,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorConstants.whiteColor,
          colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.themeColor),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorConstants.whiteColor,
            surfaceTintColor: ColorConstants.whiteColor,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
