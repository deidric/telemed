import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String route = '/signIn';

  static Future<void> checkIfSignedIn({required BuildContext context}) async {
    Navigator.pushNamedAndRemoveUntil(
        context, SignInPage.route, (route) => false);
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

  @override
  void initState() {
    super.initState();

    emailController.text = 'jona@gmail.com';
    passwordController.text = 'jona123';
  }

  Future<void> signIn(BuildContext context) async {
    var data = context.read<TelemedDataProvider>();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // UserModel userModel = UserModel(
      //     email: emailController.text.trim(),
      //     password: passwordController.text.trim());
      //
      // await data.apiRouteLogin(context: context, userModel: userModel);
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
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
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
                      child: const Icon(Icons.medical_information),
                    ),
                    Text(TelemedStrings.here2SeeYou,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(TelemedStrings.signInToYourAccount,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.bold)),
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
                                    suffixIcon:
                                        const Icon(Icons.account_circle)),
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
                                    border: OutlineInputBorder(),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                      child: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.red,
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.lock),
                                onPressed: () {
                                  signIn(context);
                                },
                                label:
                                    Text(TelemedStrings.signIn.toUpperCase()),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.account_circle),
                                onPressed: () {
                                  // Navigator.pushNamedAndRemoveUntil(context,
                                  //     SignUpPage.route, (route) => false);
                                },
                                label: Text(
                                    TelemedStrings.createAccount.toUpperCase()),
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
