import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Model/UserModel.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/OnboardingPage.dart';
import 'package:telemed/UI/SignInSignUp/SignUpPage.dart';
import 'package:telemed/settings.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String route = '/signIn';

  static Future<void> checkIfSignedIn({required BuildContext context}) async {
    Navigator.pushNamedAndRemoveUntil(
        context, OnboardingPage.route, (route) => false);
  }

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberFor30days = false;

  @override
  void initState() {
    super.initState();

    emailController.text = 'roby@gmail.com';
    passwordController.text = '1234';
  }

  Future<void> signIn(BuildContext context) async {
    var data = context.read<TelemedDataProvider>();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      UserModel userModel = UserModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        device_key: fcmToken,
      );
      if (mounted) {
        await data.apiRouteLogin(context: context, userModel: userModel);
      }
    }
  }

  bool _showPassword = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(TelemedSettings.appName),
      ),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView(
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RotationTransition(
                      turns: _animation,
                      child: Image.asset(TelemedImage.logoImage),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.here2SeeYou,
                          style: data
                              .getTelemedTextStyle(context)
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    if (data.selectedUserModel.userTypeId ==
                        TelemedSettings.patientId)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.patient,
                            style: data
                                .getTelemedTextStyle(context)
                                .displaySmall!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    if (data.selectedUserModel.userTypeId ==
                        TelemedSettings.doctorId)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.doctor,
                            style: data
                                .getTelemedTextStyle(context)
                                .displaySmall!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.signInToYourAccount,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.welcomeBack,
                          style: data.getTelemedTextStyle(context).titleLarge!),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: IntrinsicWidth(
                        stepWidth: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TelemedStrings.pleaseEnterText;
                                  }
                                  return null;
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: TelemedStrings.email,
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.mail_outline),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TelemedStrings.pleaseEnterText;
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                obscureText: _showPassword,
                                decoration: InputDecoration(
                                  labelText: TelemedStrings.password,
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.lock_open),
                                  suffixIcon: IconButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    tooltip: _showPassword
                                        ? TelemedStrings.showPassword
                                        : TelemedStrings.hidePassword,
                                    icon: _showPassword
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                      title: Text(TelemedStrings.remember),
                                      value: rememberFor30days,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (newValue) {
                                        setState(() {
                                          rememberFor30days = newValue!;
                                        });
                                      }),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(TelemedStrings.forgotPassword),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        signIn(context);
                                      },
                                      child: Text(TelemedStrings.signIn),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(TelemedStrings.noAccount),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          SignUpPage.route,
                                        );
                                      },
                                      child: Text(TelemedStrings.signUp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
