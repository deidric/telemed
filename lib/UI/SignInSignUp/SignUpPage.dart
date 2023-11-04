import 'package:flutter/material.dart';
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

  bool rememberFor30days = false;

  late String _password;
  double _strength = 0;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String _displayText = 'Please enter a password';

  @override
  void initState() {
    super.initState();
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
                      child: Image.asset(TelemedImage.logoImage,
                        width: 100, // Set the desired width
                        height: 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.here2SeeYou,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
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
                      child: Text(
                        TelemedStrings.createAccount,
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 25, // Adjust the value to make the text smaller or larger
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        TelemedStrings.getStarted,
                        style: data.getTelemedTextStyle(context).titleLarge!.copyWith(
                          fontSize: 14, // Adjust the value to make the text smaller or larger
                        ),
                      ),
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
                                initialValue: data.selectedUserModel.email,
                                onChanged: (newValue) {
                                  data.selectedUserModel.email = newValue;
                                },
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
                                onChanged: (newValue) {
                                  _checkPassword(newValue);
                                  data.selectedUserModel.password = newValue;
                                },
                                initialValue: data.selectedUserModel.password,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(TelemedStrings.passwordStrength,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _displayText,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: _strength,
                                      backgroundColor: Colors.grey[300],
                                      color: _strength <= 1 / 4
                                          ? Colors.red
                                          : _strength == 2 / 4
                                              ? Colors.yellow
                                              : _strength == 3 / 4
                                                  ? Colors.blue
                                                  : Colors.green,
                                      minHeight: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    _displayText,
                                    style: const TextStyle(fontSize: 18),
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
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          Navigator.pushNamed(
                                            context,
                                            BasicInformationPage.route,
                                          );
                                        }
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
                                          .bodySmall!),
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
                                          .bodySmall!),
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

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText = 'Empty';
      });
    } else if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;
        _displayText = 'Too short';
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 2 / 4;
        _displayText = 'Acceptable but not strong';
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
          _strength = 3 / 4;
          _displayText = 'Strong';
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {
          _strength = 1;
          _displayText = 'Great';
        });
      }
    }
  }
}
