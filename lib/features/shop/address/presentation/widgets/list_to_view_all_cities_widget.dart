import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../data/model/address_model.dart';
import '../../data/model/city_model.dart';
import '../riverpod/address_riverpod.dart';
import 'design_for_cities_and_districts_names_widget.dart';
import 'search_input_widget.dart';

class ListToViewAllCitiesWidget extends ConsumerStatefulWidget {
  final AddressModel address;

  const ListToViewAllCitiesWidget({super.key, required this.address});

  @override
  ConsumerState<ListToViewAllCitiesWidget> createState() =>
      _ListToViewAllCitiesWidgetState();
}

class _ListToViewAllCitiesWidgetState
    extends ConsumerState<ListToViewAllCitiesWidget> {
  TextEditingController searchForACity = TextEditingController();
  List<CityModel> items = [];

  @override
  void initState() {
    items = ref.read(citiesProvider.notifier).state.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cities = ref.watch(citiesProvider);

    return SizedBox(
      height: 400.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          14.h.verticalSpace,
          SearchInputWidget(
            search: searchForACity,
            onChanged: (searchItem) {
              setState(() {
                items = cities.data
                    .where((element) => element.name
                        .toString()
                        .toUpperCase()
                        .contains(searchItem.toString().toUpperCase()))
                    .toList();
              });
            },
          ),
          if (items.isEmpty) const SearchResultsAreEmptyWidget(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(14.sp),
              itemBuilder: (context, index) {
                return ReactiveFormBuilder(
                  form: () => ref
                      .read(addressProvider(widget.address).notifier)
                      .form
                      .group,
                  builder: (context, form, child) {
                    return DesignForCitiesAndDistrictsNamesWidget(
                      name: items[index].name.toString(),
                      onTap: () {
                        setState(() {
                          form.control('city_id').value = items[index].id;
                          form.control('city_name').value = items[index].name;
                          form.patchValue({'district_id': null});
                          form.patchValue({'district_name': null});
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
