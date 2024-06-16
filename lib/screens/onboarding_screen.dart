import 'package:expenz_app/constants/colors.dart';
import 'package:expenz_app/data/onboarding_data.dart';
import 'package:expenz_app/screens/onboarding/front_page.dart';
import 'package:expenz_app/screens/onboarding/shared_onboarding.dart';
import 'package:expenz_app/screens/user_data_screen.dart';
import 'package:expenz_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool showDetailPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //onboarding page
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailPage = index == 3;
                    });
                  },
                  children: [
                    FrontPage(),
                    SharedOnboardingScreen(
                      title: OnbardingData.onboardingList[0].title,
                      imgPath: OnbardingData.onboardingList[0].imagePath,
                      description: OnbardingData.onboardingList[0].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnbardingData.onboardingList[1].title,
                      imgPath: OnbardingData.onboardingList[1].imagePath,
                      description: OnbardingData.onboardingList[1].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnbardingData.onboardingList[2].title,
                      imgPath: OnbardingData.onboardingList[2].imagePath,
                      description: OnbardingData.onboardingList[2].description,
                    ),
                  ],
                ),
                //page indecator
                Container(
                  alignment: Alignment(0, 0.65),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: ExpandingDotsEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),
                //navigation button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: !showDetailPage
                        ? GestureDetector(
                            onTap: () {
                              _controller.animateToPage(
                                _controller.page!.toInt() + 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: CustomButton(
                              btName: showDetailPage ? "Get Started" : "Next",
                              btColor: kMainColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserDataScreen()));
                            },
                            child: CustomButton(
                              btName: showDetailPage ? "Get Started" : "Next",
                              btColor: kMainColor,
                            ),
                          ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
