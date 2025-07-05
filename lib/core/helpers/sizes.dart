import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpace(double height) => SizedBox(height: height);

SizedBox horizontalSpace(double width) => SizedBox(width: width);

double getHeight(BuildContext context) => MediaQuery.sizeOf(context).height;

double getWidth(BuildContext context) => MediaQuery.sizeOf(context).width;

double pagePadding = 12;
double appBarSize = 55;
