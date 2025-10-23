import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/model/on_boarding_model.dart';
import '../widgets/splach_screen_image_widget.dart';
import '../widgets/splach_screen_widget.dart';

class SplachScreenPage extends StatefulWidget {
  const SplachScreenPage({
    super.key,
  });

  @override
  State<SplachScreenPage> createState() => _SplachScreenPageState();
}

class _SplachScreenPageState extends State<SplachScreenPage> {
  int currentIndex = 0;
  var controller = PageController();

  List<OnBoardingModel> boarding = [
    // OnBoardingModel(
    //   image: AppImages.onBoarding1,
    //   title: "اكتشف وجهتك المثالية",
    //   description:
    //       "استعرض أفضل الفنادق في المحافظات اليمنية بأسعار تناسب ميزانيتك، وخيارات تناسب ذوقك",
    // ),
    // OnBoardingModel(
    //   image: AppImages.onBoarding2,
    //   title: "وين حاب تروح؟",
    //   description:
    //       "خلينا نساعدك تلاقي الفندق اللي يناسبك… بكل سهولة وفي أي مكان",
    // ),
    // OnBoardingModel(
    //   image: AppImages.onBoarding3,
    //   title: "احجزها بثواني",
    //   description: "اختر المكان والتاريخ، واحجز غرفتك بدون لف ودوران",
    // ),
  ];

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: controller,
              itemCount: boarding.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return SplachScreenImageWidget(
                  image: boarding[index].image,
                );
              },
            ),
            SplachScreenWidget(
              title: boarding[currentIndex].title,
              description: boarding[currentIndex].description,
              controller: controller,
              currentIndex: currentIndex,
              boardingLength: boarding.length,
            ),
          ],
        ),
      ),
    );
  }
}
