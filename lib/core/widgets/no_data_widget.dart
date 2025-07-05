import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helpers/sizes.dart';
import '../theming/styles.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svgs/file.svg'),
        verticalSpace(10),
        Text('There is no data yet', style: TextStyles.font16RegularNeutral80),
      ],
    );
  }
}
