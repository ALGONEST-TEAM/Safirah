import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class UserCountrySelection {
  final String dialCode;
  final String flagEmoji;

  const UserCountrySelection({
    required this.dialCode,
    required this.flagEmoji,
  });
}

class UserCountryPickerHelper {
  static const List<String> arabCountryCodes = [
    'YE',
    'SA',
    'AE',
    'EG',
    'JO',
    'IQ',
    'SY',
    'LB',
    'PS',
    'OM',
    'QA',
    'KW',
    'BH',
    'DZ',
    'MA',
    'TN',
    'LY',
    'SD',
    'SO',
    'DJ',
    'MR',
    'KM',
  ];

  static void show({
    required BuildContext context,
    required ValueChanged<UserCountrySelection> onSelected,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
      ),
      builder: (_) => _UserCountryPickerBottomSheet(onSelected: onSelected),
    );
  }
}

class _UserCountryPickerBottomSheet extends StatefulWidget {
  final ValueChanged<UserCountrySelection> onSelected;

  const _UserCountryPickerBottomSheet({required this.onSelected});

  @override
  State<_UserCountryPickerBottomSheet> createState() =>
      _UserCountryPickerBottomSheetState();
}

class _UserCountryPickerBottomSheetState
    extends State<_UserCountryPickerBottomSheet> {
  final CountryService _countryService = CountryService();
  final TextEditingController _searchController = TextEditingController();

  late final List<Country> _allCountries;
  late final List<Country> _favoriteCountries;
  late final Set<String> _favoriteCodes;

  String get _query => _searchController.text.trim();
  bool get _isSearching => _query.isNotEmpty;

  TextStyle get _countryTextStyle => TextStyle(
    fontSize: 12.sp,
    fontFamily: 'ReadexPro',
    color: AppColors.mainColorFont,
    fontWeight: FontWeight.w500,
  );

  TextStyle get _searchTextStyle => TextStyle(
    fontSize: 11.sp,
    fontFamily: 'ReadexPro',
    color: AppColors.mainColorFont,
    fontWeight: FontWeight.w400,
  );

  @override
  void initState() {
    super.initState();
    _allCountries = _countryService.getAll();
    _favoriteCountries =
        _countryService.findCountriesByCode(UserCountryPickerHelper.arabCountryCodes);
    _favoriteCodes = _favoriteCountries.map((country) => country.countryCode).toSet();
    _searchController.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_refresh);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = CountryLocalizations.of(context);
    final searchLabel =
        localizations?.countryName(countryCode: 'search') ?? 'ابحث عن الدولة';

    final visibleCountries = _isSearching
        ? _allCountries
        .where((country) => country.startsWith(_query, localizations))
        .toList()
        : _allCountries
        .where((country) => !_favoriteCodes.contains(country.countryCode))
        .toList();

    return SafeArea(
      top: false,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.82,
        child: Column(
          children: [
            Container(
              width: 42.w,
              height: 4.4.h,
              margin: EdgeInsets.only(bottom: 6.h, top: 8.h),
              decoration: BoxDecoration(
                color: AppColors.fontColor2.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: TextField(
                controller: _searchController,
                style: _searchTextStyle,
                decoration: InputDecoration(
                  hintText: searchLabel,
                  hintStyle: TextStyle(
                    fontSize: 10.4.sp,
                    fontFamily: 'ReadexPro',
                    color: AppColors.fontColor2,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(Icons.search, size: 18.sp),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  if (!_isSearching && _favoriteCountries.isNotEmpty) ...[
                    ..._favoriteCountries.map(_buildCountryRow),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const Divider(thickness: 1),
                    ),
                  ],
                  if (visibleCountries.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Center(
                        child: Text(
                          'لا توجد نتائج',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: 'ReadexPro',
                            color: AppColors.fontColor2,
                          ),
                        ),
                      ),
                    )
                  else
                    ...visibleCountries.map(_buildCountryRow),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryRow(Country country) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final translatedName = CountryLocalizations.of(context)
        ?.countryName(countryCode: country.countryCode)
        ?.replaceAll(RegExp(r'\s+'), ' ') ??
        country.name;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onSelected(
            UserCountrySelection(
              dialCode: country.phoneCode,
              flagEmoji: country.flagEmoji,
            ),
          );
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            children: [
              20.w.horizontalSpace,
              Text(
                country.flagEmoji,
                style: TextStyle(fontSize: 20.sp),
              ),
              15.w.horizontalSpace,
              SizedBox(
                width: 45.w,
                child: Text(
                  '${isRtl ? '' : '+'}${country.phoneCode}${isRtl ? '+' : ''}',
                  style: _countryTextStyle,
                ),
              ),
              5.w.horizontalSpace,
              Expanded(
                child: Text(
                  translatedName,
                  style: _countryTextStyle,
                ),
              ),
              10.w.horizontalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

