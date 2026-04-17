import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/utils/app_responsive.dart';

Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool useRootNavigator = false,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: isScrollControlled,
    showDragHandle: false,
    useSafeArea: true,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(maxWidth: AppResponsive.sheetMaxWidth(context)),
    builder: (sheetContext) {
      return Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.sheetMaxWidth(sheetContext),
          ),
          child: builder(sheetContext),
        ),
      );
    },
  );
}
