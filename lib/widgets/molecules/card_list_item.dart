import 'package:flutter/material.dart';
import 'package:tccflutter/theme/default_theme.dart';
import 'package:tccflutter/widgets/atoms/button_tile.dart';

class CardListItem extends StatefulWidget {
  final String title;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final TextAlign textAlign;
  final TextOverflow? titleOverflow;
  final Function? onTap;
  final Function? onExpand;
  final double? finalHeight;
  final String fontFamily;
  final TextOverflow subTitleOverflow;
  final int maxLinesTitle;
  final int maxLinesSubTitle;
  final double initialHeight;
  final bool isExpanded;

  const CardListItem(this.title, {
    super.key,
    this.subTitle,
    this.leading,
    this.trailing,
    this.child,
    this.titleOverflow,
    this.onTap,
    this.onExpand,
    this.finalHeight,
    this.textAlign = TextAlign.center,
    this.fontFamily = 'Inter',
    this.subTitleOverflow = TextOverflow.ellipsis,
    this.maxLinesTitle = 1,
    this.maxLinesSubTitle = 1,
    this.initialHeight = 70.0,
    this.isExpanded = false,
  });

  @override
  State<StatefulWidget> createState() => _CardListItemState();
}

class _CardListItemState extends State<CardListItem> {
  @override
  void initState() {
    super.initState();
  }

  void _onTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    }

    if (widget.child != null) {
      setState(() {
        if (widget.onExpand != null) {
          widget.onExpand!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double finalHeight = widget.finalHeight ?? MediaQuery.of(context).size.height * 0.8;
    var expands = [
      if (widget.child != null) {
        const Divider(
          thickness: 2,
          color: Colors.black26,
        ),
      },
      widget.child ?? Container(),
    ] as List<Widget>;

    return Column(
      children: <Widget>[
        const SizedBox(height: 15),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color(int.parse(DefaultTheme.cyan)),

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: widget.isExpanded? finalHeight: widget.initialHeight,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _onTap,
                        child: ButtonTile(
                          widget.title,
                          textAlign: widget.textAlign,
                          subTitle: widget.subTitle,
                          leading: widget.leading,
                          trailing: widget.trailing,
                          fontFamily: widget.fontFamily,
                          maxLinesSubTitle: widget.maxLinesSubTitle,
                          maxLinesTitle: widget.maxLinesTitle,
                          subTitleOverflow: widget.subTitleOverflow,
                          titleOverflow: widget.titleOverflow,
                          filled: false,
                          onTap: _onTap,
                        ),
                      ),
                      if (widget.isExpanded) ...expands else Container(),
                    ],
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