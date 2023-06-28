import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/PopupMenuButton.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/HomePage.dart';
import 'package:telemed/UI/Home/ProfilePage.dart';
import 'package:telemed/settings.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
  static const String route = '/basePage';

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");
  var currentPage;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    currentPage = const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
        appBar: AppBar(title: Text(TelemedSettings.appName), actions: const [
          AppBarActionsPopupMenuButton(),
          // IconButton(
          //   icon: const Icon(Icons.close),
          //   tooltip: TelemedStrings.close,
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) {
            // Respond to item press.
            currentIndex = value;
            switch (value) {
              case 0:
                currentPage = const HomePage();
                break;
              case 3:
                currentPage = const ProfilePage();
            }
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              label: TelemedStrings.home,
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: TelemedStrings.calendar,
              icon: const Icon(Icons.calendar_month),
            ),
            BottomNavigationBarItem(
              label: TelemedStrings.message,
              icon: const Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              label: TelemedStrings.profile,
              icon: const Icon(Icons.account_circle),
            ),
          ],
        ),
        body: data.isLoading
            ? const TelemedLoadingProgressDialog()
            : currentPage);
  }
}
