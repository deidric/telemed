import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/SignInSignUp/SignInPage.dart';
import 'package:telemed/settings.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  static const String route = '/onBoardingPage';

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<HomePageContent> imgList = [
    HomePageContent(
      imageURI: TelemedImage.doctorImage,
      title: "Video consult top doctors from the comfort of your home",
      description:
          "These are the Specialists in their respective fields, which includes Brain & Nervous system",
    ),
    HomePageContent(
      imageURI: TelemedImage.clockImage,
      title: "Communicate in the best & effective way possible",
      description:
          "Time & health are two precious assets that we don't compromise on",
    ),
  ];
  List<Widget> imageSliders = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      imageSliders = imgList
          .map((item) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      item.imageURI,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.description,
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                      ),
                    ],
                  ),
                ],
              ))
          .toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CarouselSlider(
                      items: imageSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.8,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.account_circle),
                          onPressed: () {
                            data.setUserTypeId(3);
                            Navigator.pushNamed(
                              context,
                              SignInPage.route,
                            );
                          },
                          label: Text(TelemedStrings.patient),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.account_circle),
                          onPressed: () {
                            data.setUserTypeId(2);
                            Navigator.pushNamed(
                              context,
                              SignInPage.route,
                            );
                          },
                          label: Text(TelemedStrings.doctor),
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

class HomePageContent {
  String imageURI;
  String title;
  String description;

  HomePageContent(
      {required this.imageURI, required this.title, required this.description});
}
