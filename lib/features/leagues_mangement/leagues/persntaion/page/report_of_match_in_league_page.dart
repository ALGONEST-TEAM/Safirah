import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:safirah/core/widgets/secondary_app_bar_widget.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../data/model/report_model.dart';
import '../riverpod/riverpod.dart';
import 'create_league_page.dart';

class ReportOfMatchInLeaguePage extends ConsumerStatefulWidget {
  const ReportOfMatchInLeaguePage({super.key, required this.leagueSyncId,required this.matchSyncId});
  final String matchSyncId;

  final String leagueSyncId;
  @override
  ConsumerState<ReportOfMatchInLeaguePage> createState() => _ReportOfMatchInLeaguePageState();
}

class _ReportOfMatchInLeaguePageState extends ConsumerState<ReportOfMatchInLeaguePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final LocalImageStore _imageStore = const LocalImageStore();
  final String _draftKey = const Uuid().v7();

  /// ✅ صور متعددة
  final List<String> _imagesLocalPaths = <String>[];

  /// ✅ فيديو (اختياري)
  String? _videoLocalPath;

  Future<void> _pickImages() async {
    final List<XFile> files = await _picker.pickMultiImage(imageQuality: 70);
    if (files.isEmpty) return;

    final List<String> saved = [];
    for (var i = 0; i < files.length; i++) {
      final f = files[i];
      final savedPath = await _imageStore.savePickedImage(
        pickedPath: f.path,
        namespace: 'reports',
        key: '${_draftKey}_img_${i}_${DateTime.now().microsecondsSinceEpoch}',
      );
      saved.add(savedPath);
    }

    if (!mounted) return;
    setState(() {
      _imagesLocalPaths.addAll(saved);
    });
  }

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? file = await _picker.pickVideo(source: source);
    if (file == null) return;

    // نحفظ الفيديو بجانب الصور باستخدام نفس التخزين (copy)
    final savedPath = await _imageStore.savePickedImage(
      pickedPath: file.path,
      namespace: 'reports_videos',
      key: '${_draftKey}_video_${DateTime.now().microsecondsSinceEpoch}',
    );

    if (!mounted) return;
    setState(() {
      _videoLocalPath = savedPath;
    });
  }

  Future<void> _showVideoSourceSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.video_library),
                  title: const Text('اختيار فيديو من المعرض'),
                  onTap: () async {
                    Navigator.of(ctx).pop();
                    await _pickVideo(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('تصوير فيديو بالكاميرا'),
                  onTap: () async {
                    Navigator.of(ctx).pop();
                    await _pickVideo(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addReportProvider);
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: 'اضافة تقرير'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeTextWidget(text: 'اكتب عنوان التقرير'),
                  6.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: titleController,
                    hintText: 'اضافة عنوان التقرير',
                    hintTextColor: AppColors.fontColor,
                    labelTextColor: Colors.grey[600],
                    fieldValidator: (value) {
                      if (value == null || value.toString().trim().isEmpty) {
                        return 'قم باضافة عنوان التقرير';
                      }
                      return null;
                    },
                  ),
                  12.h.verticalSpace,

                  AutoSizeTextWidget(text: 'اكتب تفاصيل التقرير'),
                  6.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: detailsController,
                    hintText: 'اضافة تفاصيل التقرير',
                    hintTextColor: AppColors.fontColor,
                    labelTextColor: Colors.grey[600],
                    maxLine: 8, // ✅ حجم كبير
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    fieldValidator: (value) {
                      if (value == null || value.toString().trim().isEmpty) {
                        return 'قم باضافة تفاصيل التقرير';
                      }
                      return null;
                    },
                  ),
                  12.h.verticalSpace,

                  // ✅ صور متعددة
                  Row(
                    children: [
                      Expanded(
                        child: AutoSizeTextWidget(
                          text: 'صور التقرير',
                          fontSize: 12.sp,
                          colorText: Colors.black,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _pickImages,
                        icon: const Icon(Icons.add_photo_alternate_outlined,color: Colors.black,),
                        label: const AutoSizeTextWidget(text: 'إضافة صور'),
                      ),
                    ],
                  ),
                  8.h.verticalSpace,
                  if (_imagesLocalPaths.isEmpty)
                    Container(
                      height: 90.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: const Icon(Icons.image_outlined, color: Colors.grey),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _imagesLocalPaths.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.w,
                        mainAxisSpacing: 8.h,
                      ),
                      itemBuilder: (context, index) {
                        final path = _imagesLocalPaths[index];
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.file(
                                File(path),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey[200],
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.broken_image_outlined),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6,
                              right: 6,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _imagesLocalPaths.removeAt(index);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.55),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  12.h.verticalSpace,

                  // ✅ فيديو
                  AutoSizeTextWidget(
                    text: 'فيديو (اختياري)',
                    fontSize: 12.sp,
                    colorText: Colors.black,
                  ),
                  8.h.verticalSpace,
                  GestureDetector(
                    onTap: () async => _showVideoSourceSheet(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.video_file_outlined, color: Colors.grey),
                          10.w.horizontalSpace,
                          Expanded(
                            child: Text(
                              (_videoLocalPath == null || _videoLocalPath!.trim().isEmpty)
                                  ? 'اضغط لإضافة فيديو'
                                  : p.basename(_videoLocalPath!),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: (_videoLocalPath == null || _videoLocalPath!.trim().isEmpty)
                                    ? Colors.grey
                                    : Colors.black,
                                fontSize: 12.sp,
                                fontFamily: 'IBMPlexSansArabic',
                              ),
                            ),
                          ),
                          if (_videoLocalPath != null && _videoLocalPath!.trim().isNotEmpty)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _videoLocalPath = null;
                                });
                              },
                              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            )
                          else
                            const Icon(Icons.upload, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  18.h.verticalSpace,

                  CheckStateInPostApiDataWidget(
                    state: state,
                    functionSuccess: (){
                      Navigator.pop(context);
                    },
                    bottonWidget: DefaultButtonWidget(
                      text: 'رفع التقرير',
                      isLoading: state.stateData == States.loading,
                      background: AppColors.primaryColor,
                      onPressed: () {
                        final isValid = formKey.currentState?.validate() ?? false;
                        if (!isValid) return;

                        final report = ReportModel(
                          title: titleController.text.trim(),
                          details: detailsController.text.trim(),
                          leagueSyncId: widget.leagueSyncId,
                          imagesLocalPaths: _imagesLocalPaths,
                          videoLocalPath: _videoLocalPath,
                        );

                        ref.read(addReportProvider.notifier).addReport(report);

                        debugPrint('title: ${report.title}');
                        debugPrint('details: ${report.details}');
                        debugPrint('imagesLocalPaths: ${report.imagesLocalPaths}');
                        debugPrint('videoLocalPath: ${report.videoLocalPath}');
                      },
                    ),
                  ),
                  12.h.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

