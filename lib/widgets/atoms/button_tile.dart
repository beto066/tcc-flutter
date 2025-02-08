import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final double? height;
  final double? padding;
  final TextAlign textAlign;
  final TextOverflow? titleOverflow;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final String fontFamily;
  final double fontSize;
  final TextOverflow subTitleOverflow;
  final int maxLinesTitle;
  final int maxLinesSubTitle;
  final bool filled;

  const ButtonTile(this.title, {
    super.key,
    this.subTitle,
    this.leading,
    this.trailing,
    this.height,
    this.padding,
    this.titleOverflow,
    this.onTap,
    this.contentPadding,
    this.textAlign = TextAlign.center,
    this.fontFamily = 'Inter',
    this.fontSize = 20,
    this.subTitleOverflow = TextOverflow.ellipsis,
    this.maxLinesTitle = 1,
    this.maxLinesSubTitle = 1,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: ListTile(
        leading: leading,
        contentPadding: contentPadding,
        title: Container(
          height: height,
          decoration: BoxDecoration(
            color: filled? Theme.of(context).colorScheme.inversePrimary: null,
            borderRadius: BorderRadius.circular(15),
          ),
          // margin: const EdgeInsets.symmetric(horizontal: 4),
          // padding: EdgeInsets.all(padding ?? 0.0),
          child: Text(
              title,
              maxLines: maxLinesTitle,
              overflow: titleOverflow,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: fontFamily,
              )
          ),
        ),
        subtitle: subTitle != null? Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
              subTitle!,
              maxLines: maxLinesSubTitle,
              overflow: subTitleOverflow,
              textAlign: textAlign,
              style: TextStyle(
                fontFamily: fontFamily,
              )
          ),
        ): null,
        trailing: trailing,
      ),
    );
  }
}