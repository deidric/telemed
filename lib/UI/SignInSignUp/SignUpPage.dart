import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/SignInSignUp/BasicInformationPage.dart';
import 'package:telemed/settings.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String route = '/signUp';

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
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

  ///Passing a key to access the validate function
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

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
                      child: const Icon(Icons.medical_information),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.here2SeeYou,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.createAccount,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.getStarted,
                          style: Theme.of(context).textTheme.titleLarge!),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: IntrinsicWidth(
                        stepWidth: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(TelemedStrings.passwordStrength,
                                  style:
                                      Theme.of(context).textTheme.labelLarge!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  FlutterPwValidator(
                                    key: validatorKey,
                                    controller: passwordController,
                                    minLength: 8,
                                    uppercaseCharCount: 2,
                                    lowercaseCharCount: 3,
                                    numericCharCount: 3,
                                    specialCharCount: 1,
                                    normalCharCount: 3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 200,
                                    onSuccess: () {
                                      print("MATCHED");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Password is matched")));
                                    },
                                    onFail: () {
                                      print("NOT MATCHED");
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                          BasicInformationPage.route,);
                                      },
                                      child: Text(TelemedStrings.proceed),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(TelemedStrings.toProceed,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Text(TelemedStrings.privacyPolicy),
                                  ),
                                  Text(TelemedStrings.and,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                        " ${TelemedStrings.termsOfService}"),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(TelemedStrings.haveAccount),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(TelemedStrings.signIn),
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
