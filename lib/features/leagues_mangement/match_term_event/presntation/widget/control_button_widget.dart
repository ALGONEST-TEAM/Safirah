import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../../../../main.dart';
import '../state_mangement/riverpod.dart';

class ControlButtonWidget extends ConsumerStatefulWidget {
  final int matchId;
  final int leagueId;
  final int roundId;

  const ControlButtonWidget({
    super.key,
    required this.matchId,
    required this.leagueId,
    required this.roundId,
  });

  @override
  ConsumerState<ControlButtonWidget> createState() => _ControlButtonWidgetState();
}

class _ControlButtonWidgetState extends ConsumerState<ControlButtonWidget> {
  bool _isFinishing = false;

  @override
  Widget build(BuildContext context) {
    final counterState = ref.watch(matchTermCounterProvider(widget.matchId));
    final currentTerm = ref.watch(getCurrentMatchTermProvider(widget.matchId));
    final notifier = ref.read(matchTermCounterProvider(widget.matchId).notifier);
    final termId = currentTerm.data?.id ?? 0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultButtonWidget(
          text: _buttonText(counterState, currentTerm),
          onPressed: () async {
            if (_isFinishing) return;
            _isFinishing = true;

            try {
              await _handleMatchAction(context, counterState, currentTerm, notifier, termId);
            } finally {
              _isFinishing = false;
            }
          },
        ),
      ),
    );
  }

  String _buttonText(dynamic counter, dynamic currentTerm) {
    if (currentTerm.data == null) return 'انتهت المباراة';
    if (counter.data.isPaused) return 'استئناف المباراة';
    if (counter.data.isRunning) return 'توقيف المباراة';
    return currentTerm.data!.termName??'';
  }

  Future<void> _handleMatchAction(
      BuildContext context,
      dynamic counter,
      dynamic currentTerm,
      dynamic notifier,
      int termId,
      ) async {
    if (currentTerm.data == null || currentTerm.data!.termName == 'انتهت المباراة') {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('انتهت المباراة')),
      );
      return;
    }

    final term = currentTerm.data!;

    if (!counter.data.isRunning && !counter.data.isPaused) {
      await _startTerm(notifier, term);
      return;
    }

    if (counter.data.isRunning && !counter.data.isPaused) {
      notifier.stop(termId);
      if (!mounted) return;
      showFlashBarSuccess(
        message: 'تم توقيف المباراة، الوقت الضائع محسوب بالكامل',
        context: context,
      );
      return;
    }

    if (counter.data.isPaused) {
      notifier.resume(termId);
      if (!mounted) return;
      showFlashBarSuccess(
        message: 'تم استئناف المباراة، تم احتساب الوقت الضائع',
        context: context,
      );
    }
  }

  Future<void> _startTerm(dynamic notifier, dynamic currentTerm) async {
    await notifier.start(
      roundId: widget.roundId,
      leagueId: widget.leagueId,
      currentTerm: currentTerm,
      onAskExtraTime: (title, wastedMinutes) async {
        final controller = TextEditingController();
        final completer = Completer<int?>();
        final context = appNavigatorKey.currentContext;
        if (context == null) return null;

        SchedulerBinding.instance.addPostFrameCallback((_) {
          showDialog<int?>(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                'إضافة وقت إضافي',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 12.h),
                  TextFormFieldWidget(
                    controller: controller,
                    type: TextInputType.number,
                    fillColor: AppColors.scaffoldColor,
                  ),
                ],
              ),
              actions: [
                Row(
                  spacing: 4.w,
                  children: [
                    DefaultButtonWidget(
                      width: 110.w,
                      height: 40.h,
                      text: 'إنهاء الشوط',
                      onPressed: () => Navigator.pop(ctx, null),
                    ),
                    DefaultButtonWidget(
                      width: 110.w,
                      height: 40.h,
                      text: 'إضافة',
                      background: AppColors.primaryColor,
                      onPressed: () => Navigator.pop(ctx, int.tryParse(controller.text) ?? 0),
                    ),
                  ],
                ),
              ],
            ),
          ).then((value) => completer.complete(value));
        });
        return completer.future;
      },
    );
  }
}


class SponsorForm extends StatefulWidget {
  const SponsorForm({Key? key}) : super(key: key);

  @override
  State<SponsorForm> createState() => _SponsorFormState();
}
class _SponsorFormState extends State<SponsorForm> {
  final TextEditingController _sponsorNameController = TextEditingController();
  final TextEditingController _sponsorLinkController = TextEditingController();
  final TextEditingController _sponsorDescriptionController = TextEditingController();
  String _selectedPackage = 'فضي';

  @override
  void initState() {
    super.initState();
    _sponsorNameController.text = 'المبيدات الحشرية';
    _sponsorLinkController.text = 'https://youtu.be/85r4BmSp4Qg';
    _sponsorDescriptionController.text = 'أضافة وصف';
  }

  @override
  void dispose() {
    _sponsorNameController.dispose();
    _sponsorLinkController.dispose();
    _sponsorDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1750),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.only(top: 31),
                  child: Column(
                    children: [
                      // Title
                      const Text(
                        'تحديد الرعاة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 11),
                      // League Info Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Column(
                          children: [
                            Container(
                              width: 390,
                              constraints: const BoxConstraints(maxWidth: double.infinity),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'دوري طوفان الاقصى',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      height: 0.8,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'رعاية احترافي لدوري كرة القدم الخاص بك! 🏆⚽',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      height: 1.6,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 44),
                // Form Section
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(21, 15, 21, 84),
                  child: Column(
                    children: [
                      // Sponsor Name Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'أسم الراعي',
                            style: TextStyle(
                              color: Color(0xFF383B42),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF6F7F7),
                            ),
                            child: TextField(
                              controller: _sponsorNameController,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8E95A2),
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Sponsor Link Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'إضافة رابط الراعي',
                            style: TextStyle(
                              color: Color(0xFF383B42),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF6F7F7),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('https://api.builder.io/api/v1/image/assets/2ec56fb55adc4d6fa0aff31e75533dda/8df9ab8e85906aacd4ac7877db99ef4bc033172e?placeholderIfAbsent=true'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 73),
                                Transform.rotate(
                                  angle: -1.5707963267948966,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF8E95A2),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: TextField(
                                    controller: _sponsorLinkController,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF8E95A2),
                                      fontWeight: FontWeight.w400,
                                      height: 2,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Sponsorship Package Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'باقة الرعي',
                            style: TextStyle(
                              color: Color(0xFF383B42),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF6F7F7),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 9,
                                  top: 13,
                                  child: SizedBox(
                                    width: 219,
                                    height: 21,
                                    child: Text(
                                      _selectedPackage,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF8E95A2),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'IBM Plex Sans Arabic',
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Transform.rotate(
                                    angle: -1.5707963267948966,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF8E95A2),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle dropdown tap
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 48,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Sponsor Description Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'أضافة وصف للراعي',
                            style: TextStyle(
                              color: Color(0xFF383B42),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'IBM Plex Sans Arabic',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF6F7F7),
                            ),
                            padding: const EdgeInsets.fromLTRB(12, 13, 9, 49),
                            child: TextField(
                              controller: _sponsorDescriptionController,
                              textAlign: TextAlign.right,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8E95A2),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'IBM Plex Sans Arabic',
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Upload Sponsor Image
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'رفع صورة للراعي',
                              style: TextStyle(
                                color: Color(0xFF383B42),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'IBM Plex Sans Arabic',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFF6F7F7),
                              ),
                              height: 86,
                              padding: const EdgeInsets.fromLTRB(12, 31, 12, 31),
                              child: const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Icon(
                                    Icons.photo_library_outlined,
                                    size: 24,
                                    color: Color(0xFF8E95A2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Upload Sponsor Logo
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'رفع شعار الراعي',
                              style: TextStyle(
                                color: Color(0xFF383B42),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'IBM Plex Sans Arabic',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFF6F7F7),
                              ),
                              height: 86,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xFFEDF0FF),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // Handle back action
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'عودة',
                                  style: TextStyle(
                                    color: Color(0xFF4B38F3),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'IBM Plex Sans Arabic',
                                    height: 24/14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 19),
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xFF1D1750),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // Handle save action
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'حفظ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'IBM Plex Sans Arabic',
                                    height: 24/14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}