import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwork/index.dart';

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final int currBarItem;
  final Duration animationDuration;
  final double elevation;
  final ValueChanged<int> onItemTap;
  final Color? backgroundColor;

  const AnimatedBottomBar({
    Key? key,
    required this.barItems,
    this.animationDuration = const Duration(milliseconds: 500),
    required this.elevation,
    required this.onItemTap,
    required this.currBarItem,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor ?? BrandColors.kColorBackground,
      elevation: widget.elevation,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AnimatedBarItem(
              currBarItem: widget.currBarItem,
              isSelected: widget.currBarItem == 0,
              animationDuration: widget.animationDuration,
              barItem: widget.barItems[0],
              elevation: widget.elevation,
              onItemTap: widget.onItemTap,
              thisItemIndex: 0,
            ),
            AnimatedBarItem(
              currBarItem: widget.currBarItem,
              isSelected: widget.currBarItem == 1,
              animationDuration: widget.animationDuration,
              barItem: widget.barItems[1],
              elevation: widget.elevation,
              onItemTap: widget.onItemTap,
              thisItemIndex: 1,
            ),
            AnimatedBarItem(
              currBarItem: widget.currBarItem,
              isSelected: widget.currBarItem == 2,
              animationDuration: widget.animationDuration,
              barItem: widget.barItems[2],
              elevation: widget.elevation,
              onItemTap: widget.onItemTap,
              thisItemIndex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBarItem extends StatefulWidget {
  final bool isSelected;
  final int currBarItem;
  final BarItem barItem;
  final int thisItemIndex;
  final Duration animationDuration;
  final double elevation;
  final ValueChanged<int> onItemTap;

  const AnimatedBarItem({
    Key? key,
    required this.isSelected,
    required this.thisItemIndex,
    required this.barItem,
    required this.currBarItem,
    required this.animationDuration,
    required this.elevation,
    required this.onItemTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedBarItemState();
}

class AnimatedBarItemState extends State<AnimatedBarItem> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: widget.isSelected
          ? const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 8.0,
            )
          : const EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 8.0,
            ),
      duration: widget.animationDuration,
      decoration: BoxDecoration(
        color: widget.isSelected ? widget.barItem.color!.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          widget.onItemTap(widget.thisItemIndex);
        },
        child: Obx(() {
          return Row(
            children: <Widget>[
              Icon(
                widget.barItem.icon,
                // color: widget.isSelected ? widget.barItem.color : Colors.black,
                // if the item is selected show the item color otherwise if the item is not selected then check for the active theme
                color: widget.isSelected
                    ? widget.barItem.color
                    : !themeController.isLightTheme
                        ? BrandColors.white
                        : BrandColors.black,
                size: widget.barItem.iconSize,
              ),
              const SizedBox(width: 5.0),
              AnimatedSize(
                curve: Curves.easeInOut,
                duration: widget.animationDuration,
                child: LimitedBox(
                  maxWidth: 100.0,
                  child: AutoSizeText(
                    widget.isSelected ? "${widget.barItem.text}" : "",
                    style: GoogleFonts.montserrat(
                      color: widget.barItem.color,
                      fontWeight: FontWeight.w600,
                      fontSize: widget.barItem.textSize,
                    ),
                    maxFontSize: widget.barItem.textSize!,
                    maxLines: 1,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
