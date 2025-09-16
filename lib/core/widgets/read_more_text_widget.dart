import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../generated/l10n.dart';
import '../theme/app_colors.dart';

class ReadMoreTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int trimLines;
  final Duration animationDuration;
  final Curve animationCurve;

  const ReadMoreTextWidget({
    super.key,
    required this.text,
    this.style,
    this.trimLines = 4,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ReadMoreTextWidget> createState() => _ReadMoreTextWidgetState();
}

class _ReadMoreTextWidgetState extends State<ReadMoreTextWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = _toggleExpand;
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.style ??
        TextStyle(
          fontSize: 12.sp,
          height: 1.18.h,
          fontWeight: FontWeight.w400,
          color: AppColors.greySwatch.shade300,
          fontFamily: 'ReadexPro',
        );
    final linkStyle = textStyle.copyWith(
      fontSize: 12.sp,
      height: 1.18.h,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'ReadexPro',
    );

    const ellipsis = '... ';
   var  moreLabel = S.of(context).readMore;
    var lessLabel = S.of(context).showLess;

    return AnimatedSize(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      child: LayoutBuilder(builder: (context, constraints) {
        if (_expanded) {
          return RichText(
            text: TextSpan(
              style: textStyle,
              children: [
                TextSpan(text: "${widget.text} "),
                TextSpan(
                  text: lessLabel,
                  style: linkStyle,
                  recognizer: _tapRecognizer,
                ),
              ],
            ),
          );
        }

        final linkTp = TextPainter(
          text: TextSpan(text: ellipsis + moreLabel, style: linkStyle),
          textDirection: Directionality.of(context),
        )..layout(maxWidth: constraints.maxWidth);

        final linkWidth = linkTp.width;

        final textTp = TextPainter(
          text: TextSpan(text: widget.text, style: textStyle),
          maxLines: widget.trimLines,
          textDirection: Directionality.of(context),
        )..layout(maxWidth: constraints.maxWidth);

        if (!textTp.didExceedMaxLines) {
          return RichText(
            text: TextSpan(
              style: textStyle,
              children: [
                TextSpan(
                  text: widget.text,
                  style: textStyle,
                ),
              ],
            ),
          );
        }

        final lineMetrics = textTp.computeLineMetrics();
        final lastLine = lineMetrics[widget.trimLines - 1];
        final endOffset = textTp
            .getPositionForOffset(
              Offset(constraints.maxWidth - linkWidth, lastLine.baseline),
            )
            .offset;

        var truncated = widget.text.substring(0, endOffset).trimRight();
        final lastSpace = truncated.lastIndexOf(' ');
        if (lastSpace != -1) {
          truncated = truncated.substring(0, lastSpace);
        }

        return RichText(
          text: TextSpan(
            style: textStyle,
            children: [
              TextSpan(text: truncated + ellipsis),
              TextSpan(
                text: moreLabel,
                style: linkStyle,
                recognizer: _tapRecognizer,
              ),
            ],
          ),
        );
      }),
    );
  }
}
