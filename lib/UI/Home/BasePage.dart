import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/PopupMenuButton.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/CalendarPage.dart';
import 'package:telemed/UI/Home/HomePage.dart';
import 'package:telemed/UI/Home/MessagesPage.dart';
import 'package:telemed/UI/Home/ProfilePage.dart';
import 'package:telemed/settings.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
  static const String route = '/basePage';
  static const homePage = 0;
  static const calendarPage = 1;
  static const messagesPage = 2;
  static const profilePage = 3;

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> with TickerProviderStateMixin {
  String _selectedPageName = '';
  var currentPage;
  int _selectedDestination = BasePage.homePage;
  var scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _navigationDrawerList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          addDestinations();
          selectDestination(_selectedDestination);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(_selectedPageName), actions: const [
        AppBarActionsPopupMenuButton(),
      ]),
      drawer: NavigationDrawer(
        selectedIndex: _selectedDestination,
        onDestinationSelected: (selectedIndex) {
          setState(() {
            selectDestination(selectedIndex);
          });
        },
        children: _navigationDrawerList,
      ),
      body: currentPage,
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
      switch (_selectedDestination) {
        case BasePage.homePage:
          currentPage = const HomePage();
          _selectedPageName = TelemedStrings.home;

          break;
        case BasePage.calendarPage:
          currentPage = const CalendarPage();
          _selectedPageName = TelemedStrings.calendar;

          break;
        case BasePage.messagesPage:
          currentPage = const MessagesPage();
          _selectedPageName = TelemedStrings.message;

          break;
        case BasePage.profilePage:
          currentPage = const ProfilePage();
          _selectedPageName = TelemedStrings.profile;

          break;
      }
      _scaffoldKey.currentState!.closeDrawer();
    });
  }

  void addDestinations() {
    final data = context.read<TelemedDataProvider>();
    _navigationDrawerList.clear();
    _navigationDrawerList.add(
      UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          child: Image.asset(TelemedImage.logoImage),
        ),
        accountName: Text(
            "${data.selectedUserModel.firstName!} ${data.selectedUserModel.lastName!}",
            style: Theme.of(context).textTheme.headlineSmall!),
        accountEmail: Text(data.selectedUserModel.email!,
            style: Theme.of(context).textTheme.titleSmall!),
      ),
    );

    addNavigationDrawerDestination(
      iconData: Icons.home,
      label: TelemedStrings.home,
    );
    addNavigationDrawerDestination(
      iconData: Icons.calendar_month,
      label: TelemedStrings.calendar,
    );
    addNavigationDrawerDestination(
      iconData: Icons.message,
      label: TelemedStrings.message,
    );
    addNavigationDrawerDestination(
      iconData: Icons.person,
      label: TelemedStrings.profile,
    );
  }

  void addNavigationDrawerDestination(
      {required IconData iconData, required String label}) {
    _navigationDrawerList.add(
      NavigationDrawerDestination(
        icon: Icon(iconData),
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!,
        ),
      ),
    );
  }

  void addNavigationDrawerTitle({required String label}) {
    _navigationDrawerList.add(
      Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleSmall!,
        ),
      ),
    );
  }
}
