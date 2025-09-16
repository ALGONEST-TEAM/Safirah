import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../state_mangment/riverpod.dart';
import '../widget/appbar_search_widget.dart';
import '../widget/delete_search_mode_widget.dart';
import '../widget/list_name_of_search_widget.dart';
import '../widget/list_of_last_search_widget.dart';

class SearchPage extends ConsumerStatefulWidget {
  SearchPage({super.key, required this.hintTextSearch,});

  String hintTextSearch;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  TextEditingController search = TextEditingController();
  bool _isTypingStarted = false;
  bool deleteSearchMode = false;

  @override
  Widget build(BuildContext context) {
    search.text = widget.hintTextSearch;
    return GestureDetector(
      onTap: () {
        if (deleteSearchMode == true) {
          setState(() {
            deleteSearchMode = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: appBarSearchWidget(
          context: context,
          search: search,
          isTypingStarted: _isTypingStarted,
          onSearchChanged: (text) {
            setState(() {
              widget.hintTextSearch = text;
            });
            if (text.isNotEmpty && !_isTypingStarted) {
              setState(() {
                _isTypingStarted = true;
              });
            } else if (text.isEmpty && _isTypingStarted) {
              setState(() {
                _isTypingStarted = false;
              });
            }
          },
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final stateNameSearch =
                ref.watch(searchNameProvider(widget.hintTextSearch));
            final state = ref.watch(searchHistoryProvider);
            return Padding(
              padding: EdgeInsets.only(right: 15.0.sp, top: 15.sp, left: 15.sp),
              child: _isTypingStarted
                  ? CheckStateInGetApiDataWidget(
                      state: stateNameSearch,
                      widgetOfData: ListNameOfSearchWidget(
                        namesSearch: stateNameSearch.data,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.isEmpty
                            ? const SizedBox()
                            : DeleteSearchModeWidget(
                                deleteSearchMode: deleteSearchMode,
                                onTapIconDelete: () {
                                  setState(() {
                                    deleteSearchMode = true;
                                  });
                                },
                              ),
                        10.verticalSpace,
                        ListOfLastSearchWidget(
                          isDeleteMode: deleteSearchMode,
                          historySearch: state,
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
