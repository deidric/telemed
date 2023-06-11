import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    TelemedImage.doctorImage,
    TelemedImage.clockImage,
  ];
  List<Widget> imageSliders = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      imageSliders = imgList
          .map((item) => Container(
                margin: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Image.asset(item),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Video consult top doctors from the comfort of your home',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'These are the Specialists in their respective fields, which includes Brain & Nervous system',
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0.0,
                    //   left: 0.0,
                    //   right: 0.0,
                    //   child: Container(
                    //     decoration: const BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           Color.fromARGB(200, 0, 0, 0),
                    //           Color.fromARGB(0, 0, 0, 0)
                    //         ],
                    //         begin: Alignment.bottomCenter,
                    //         end: Alignment.topCenter,
                    //       ),
                    //     ),
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10.0, horizontal: 20.0),
                    //     child: Text(
                    //       'No. ${imgList.indexOf(item)} image',
                    //       style: const TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ))
          .toList();

      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : Column(children: [
            CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
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
                        color: (Theme.of(context).brightness ==
                            Brightness.dark
                            ? Colors.white
                            : Colors.black)
                            .withOpacity(
                            _current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ],),
    );
  }
}
