import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_get_api_data_widget.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/presntation/widget/all_players_of_league_widget.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../data/model/authorization_models.dart';
import '../riverpod/riverpod.dart';
import '../widgets/select_league_role_bottom_sheet.dart';

class SelectUserForAuthorizationPage extends ConsumerStatefulWidget {
  const SelectUserForAuthorizationPage({super.key,required this.leagueSyncId});

  final String leagueSyncId ;
  @override
  ConsumerState<SelectUserForAuthorizationPage> createState() =>
      _SelectUserForAuthorizationPageState();
}

class _SelectUserForAuthorizationPageState
    extends ConsumerState<SelectUserForAuthorizationPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = searchController.text.trim();
    final searchState = ref.watch(searchUserProvider(query));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const AutoSizeTextWidget(
          text: "منظمين الدوري",
          colorText: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.w),
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: searchController,
              hintText: 'ابحث عن منظم',
              prefix: const Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  // يكفي إعادة البناء ليتم تمرير القيمة الجديدة لـ provider
                });
              },
            ),
            16.h.verticalSpace,
            Expanded(
              child: query.isEmpty
                  ? Center(
                      child: AutoSizeTextWidget(
                        text: 'قم بالبحث عن لاعبين',
                        colorText: AppColors.secondaryColor,
                        fontSize: 16,
                      ),
                    )
                  : CheckStateInGetApiDataWidget(
                      state: searchState,
                      widgetOfData: ListView.builder(
                        itemCount: searchState.data.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0.h),
                          child: GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final user = UserModelForAuthorization(
                                userId: searchState.data[index].id,
                                name: searchState.data[index].name,
                                leagueSyncId: widget.leagueSyncId,
                              );
                              showModalBottomSheetWidget(
                                context: context,
                                page: SelectLeagueRoleBottomSheet(
                                  userModelForAuthorization: user,
                                  onConfirm: (choice) {

                                  },
                                ),
                              );
                            },
                            child: PlayerTile(
                              name: searchState.data[index].name ?? '',
                              avatar: '',
                            ),
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
