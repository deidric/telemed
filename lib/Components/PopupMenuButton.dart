import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/SignInSignUp/SignInPage.dart';
import 'package:telemed/Utils/DialogUtils.dart';
import 'package:telemed/settings.dart';

class AppBarActionsPopupMenuButton extends StatefulWidget {
  const AppBarActionsPopupMenuButton({Key? key}) : super(key: key);

  @override
  State<AppBarActionsPopupMenuButton> createState() =>
      _AppBarActionsPopupMenuButtonState();
}

class _AppBarActionsPopupMenuButtonState
    extends State<AppBarActionsPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<TelemedDataProvider>();
    return PopupMenuButton(
        icon: const Icon(Icons.person),
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  child: ListTile(
                      leading: Icon(
                          !data.isDark ? Icons.dark_mode : Icons.light_mode),
                      title: Text(
                        !data.isDark
                            ? TelemedSettings.darkMode
                            : TelemedSettings.lightMode,
                      ),
                      onTap: () async {
                        data.setDarkMode(!data.isDark);
                        Navigator.pop(context);
                      })),
              PopupMenuItem(
                  child: ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: Text(TelemedStrings.signOut),
                      onTap: () async {
                        // Navigator.pop(context);
                        var result =
                            await DialogUtils.displayDialogOKCancelCallBack(
                                context: context,
                                title: TelemedStrings.signOut,
                                message:
                                    TelemedStrings.areYouSureYouWantToSignOut);

                        if (result == true) {
                          Navigator.of(context).pop(true);
                          SignInPage.checkIfSignedIn(context: context);
                        } else {
                          Navigator.of(context).pop(false);
                        }
                      })),
            ]);
  }
}
