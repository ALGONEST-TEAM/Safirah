  import 'package:flutter/cupertino.dart';
  import '../../../../../core/widgets/skeletonizer_widget.dart';
  import '../../../category/data/model/category_data.dart';
import '../../../category/presentation/widgets/home_categories_list_widget.dart';

  class SkeletonizerSectionWidget extends StatelessWidget {
    const SkeletonizerSectionWidget({super.key});

    @override
    Widget build(BuildContext context) {
      return  SkeletonizerWidget(
        child: Column(
          children: [
            HomeCategoriesList(
              category: CategoryData.fakeCategoriesData,
            ),
          ],
        ),
      );
    }
  }
