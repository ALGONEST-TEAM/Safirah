import 'package:flutter/material.dart';

class DropdownHelper {
  static final DropdownHelper _instance = DropdownHelper._internal();

  factory DropdownHelper() {
    return _instance;
  }

  DropdownHelper._internal();

  OverlayEntry? overlayEntry;

  void toggleDropdown({
    required BuildContext context,
    required Widget items,
    GestureTapDownCallback? onTapDown,
    double? top = 0,
  }) {
    if (overlayEntry == null) {
      overlayEntry = _createOverlayEntry(
        context: context,
        items: items,
        onTapDown: onTapDown,
        top: top,
      );
      Overlay.of(context).insert(overlayEntry!);
    } else {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry({
    required BuildContext context,
    required Widget items,
    GestureTapDownCallback? onTapDown,
    double? top = 0,
  }) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(builder: (_) {
      return Stack(
        children: [
          GestureDetector(
            onTapDown: onTapDown ??
                (_) {
                  toggleDropdown(context: context, items: items);
                },
            behavior: HitTestBehavior.translucent,
            child: IgnorePointer(
              ignoring: overlayEntry == null,
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: offset.dy + renderBox.size.height - top!,
            width: MediaQuery.of(context).size.width,
            child: Material(
              elevation: 2.0,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.55,
                ),
                color: Colors.white,
                child: items,
              ),
            ),
          ),
        ],
      );
    });
  }
}
