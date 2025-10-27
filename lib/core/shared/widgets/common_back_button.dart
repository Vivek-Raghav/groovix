import "package:flutter/cupertino.dart";
import "package:groovix/features/cms/cms_index.dart";

class CommonBackButton extends StatelessWidget {
  final VoidCallback? onPress;
  const CommonBackButton({this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ]),
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPress ?? context.pop,
          icon: Icon(CupertinoIcons.back,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color!
                  .withOpacity(0.7))),
    );
  }
}
