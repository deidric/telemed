import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/BasePage.dart';
import 'package:telemed/UI/Home/BookAppointmentPage.dart';
import 'package:telemed/UI/Home/BookAppointmentsReasonForVisitPage.dart';
import 'package:telemed/UI/Home/CadersPage.dart';
import 'package:telemed/UI/Home/HealthProfilePage.dart';
import 'package:telemed/UI/Home/ReviewProfilePage.dart';
import 'package:telemed/UI/OnboardingPage.dart';
import 'package:telemed/UI/SignInSignUp/BasicInformationPage.dart';
import 'package:telemed/UI/SignInSignUp/HealthInsurancePage.dart';
import 'package:telemed/UI/SignInSignUp/SignInPage.dart';
import 'package:telemed/UI/SignInSignUp/SignUpPage.dart';
import 'package:telemed/settings.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TelemedDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<TelemedDataProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => TelemedSettings.appName,

      scrollBehavior: MyCustomScrollBehavior(),
      // theme: ThemeData(
      //   useMaterial3: true,
      //   // Comment the following when using material 3
      //   // primarySwatch: Colors.deepPurple,
      //   //
      //   colorSchemeSeed: Colors.deepPurple,
      // ),
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: data.isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: OnboardingPage.route,
      routes: {
        OnboardingPage.route: (context) => const OnboardingPage(),
        SignInPage.route: (context) => const SignInPage(),
        SignUpPage.route: (context) => const SignUpPage(),
        BasicInformationPage.route: (context) => const BasicInformationPage(),
        HealthInsurancePage.route: (context) => const HealthInsurancePage(),
        BasePage.route: (context) => const BasePage(),
        BookAppointmentsReasonForVisitPage.route: (context) =>
            const BookAppointmentsReasonForVisitPage(),
        CadersPage.route: (context) => const CadersPage(),
        BookAppointmentPage.route: (context) => const BookAppointmentPage(),
        HealthProfilePage.route: (context) => const HealthProfilePage(),
        ReviewProfilePage.route: (context) => const ReviewProfilePage(),
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        // etc.
      };
}
