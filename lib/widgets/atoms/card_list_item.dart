import 'package:flutter/material.dart';
import 'package:tccflutter/theme/default_theme.dart';

class CardListItem extends StatefulWidget {
  final String title;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final TextAlign textAlign;
  final TextOverflow? titleOverflow;
  final Function? onTap;
  final String fontFamily;
  final TextOverflow subTitleOverflow;
  final int maxLinesTitle;
  final int maxLinesSubTitle;

  const CardListItem(this.title, {
    super.key,
    this.subTitle,
    this.leading,
    this.trailing,
    this.titleOverflow,
    this.onTap,
    this.textAlign = TextAlign.center,
    this.fontFamily = 'Inter',
    this.subTitleOverflow = TextOverflow.ellipsis,
    this.maxLinesTitle = 1,
    this.maxLinesSubTitle = 1,
  });

  @override
  State<StatefulWidget> createState() => CardListItemState();
}

class CardListItemState extends State<CardListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: widget.onTap != null? () => widget.onTap!(): null,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color(int.parse(DefaultTheme.cyan)),
              child: SizedBox(
                height: 70,
                child: Center(
                  child: ListTile(
                    leading: widget.leading,
                    title: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        widget.title,
                        maxLines: widget.maxLinesTitle,
                        overflow: widget.titleOverflow,
                        textAlign: widget.textAlign,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: widget.fontFamily,
                        )
                      ),
                    ),
                    subtitle: widget.subTitle != null? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        widget.subTitle!,
                        maxLines: widget.maxLinesSubTitle,
                        overflow: widget.subTitleOverflow,
                        textAlign: widget.textAlign,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: widget.fontFamily,
                        )
                      ),
                    ): null,
                    trailing: widget.trailing,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}