import 'package:flutter/material.dart';
import '../helpers/sizes.dart';
import '../theming/styles.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? message;
  final String? status;
  const CustomErrorWidget({super.key, this.message, this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset('assets/svgs/warning.svg'),
          // verticalSpace(20),
          Text(
            status ?? 'An Error Occured',
            style: TextStyles.font20BoldNeutral100,
          ),
          verticalSpace(20),
          Text(
            message ?? 'Unexpected Error Occured',
            style: TextStyles.font14RegularNeutral80,
          ),
        ],
      ),
    );
  }
}
