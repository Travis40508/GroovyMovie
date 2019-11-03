import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class StreamHandler extends StatelessWidget {
  final Widget errorWidget;
  final Widget loadingWidget;
  final Widget successWidget;
  final Widget emptyResultWidget;
  final AsyncSnapshot snapshot;

  StreamHandler(
      {@required this.snapshot,
      @required this.errorWidget,
      @required this.loadingWidget,
      @required this.successWidget,
      this.emptyResultWidget});

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      return errorWidget;
    }

    if (!snapshot.hasData) {
      return loadingWidget;
    }

    if ((snapshot.data as List).length == 0) {
      return emptyResultWidget;
    }

    return successWidget;
  }
}
