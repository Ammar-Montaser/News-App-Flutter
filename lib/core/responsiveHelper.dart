import 'package:articles_app/core/breakpoints.dart';
import 'package:flutter/material.dart';

class responsiveWidget extends StatelessWidget {
  final Widget? smallMobile;
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;
  responsiveWidget(
      {this.smallMobile,
      required this.mobile,
      this.tablet,
      this.desktop,
      this.largeDesktop,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= breakpoints.smallMobileBP) {
        return smallMobile!;
      } else if (constraints.maxWidth > breakpoints.smallMobileBP &&
          constraints.maxWidth <= breakpoints.mobileBP) {
        return mobile;
      } else if (constraints.maxWidth > breakpoints.mobileBP &&
          constraints.maxWidth <= breakpoints.tabletBP) {
        return tablet!;
      } else if (constraints.maxWidth > breakpoints.tabletBP &&
          constraints.maxWidth <= breakpoints.desktopBP) {
        return desktop!;
      } else if (constraints.maxWidth > breakpoints.desktopBP) {
        return largeDesktop!;
      } else
        return mobile;
    });
  }
}
