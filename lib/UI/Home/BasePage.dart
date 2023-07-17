import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/PopupMenuButton.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/HomePage.dart';
import 'package:telemed/UI/Home/Messages/ConversationsPage.dart';
import 'package:telemed/UI/Home/ProfilePage.dart';
import 'package:telemed/settings.dart';

class BasePage extends StatefulWidget {
  final int subRoute;

  const BasePage({Key? key, required this.subRoute}) : super(key: key);
  static const String route = '/basePage';

  static const homePage = 0;
  static const messagesPage = 1;
  static const profilePage = 2;

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
          _selectedDestination = widget.subRoute;
          selectDestination(_selectedDestination);
        });
      }
      // listenToFirebaseNotifications();
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
        case BasePage.messagesPage:
          currentPage = const ConversationsPage();
          _selectedPageName = TelemedStrings.messages;

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
      iconData: Icons.message,
      label: TelemedStrings.messages,
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

  // Future<void> listenToFirebaseNotifications() async {
  //   final fcmToken = await FirebaseMessaging.instance.getToken();
  //   print("FCM token: " + fcmToken!);
  //   FirebaseMessaging.instance.onTokenRefresh
  //       .listen((fcmToken) {
  //     // TODO: If necessary send token to application server.
  //
  //     // Note: This callback is fired at each app startup and whenever a new
  //     // token is generated.
  //
  //   })
  //       .onError((err) {
  //     // Error getting token.
  //   });
  // }
}
