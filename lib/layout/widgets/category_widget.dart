import 'package:flutter/material.dart';
import 'package:gameaway/utilities/context_extenstions.dart';
import 'package:sizer/sizer.dart';

class CategoryWidget extends StatefulWidget {
  var globalIndex;
  var index;
  var categories;

  CategoryWidget({
    super.key,
    required this.globalIndex,
    required this.index,
    required this.categories,
  });

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final boxShadow = BoxShadow(
      color: Theme.of(context).shadowColor,
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(1, 1),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: widget.globalIndex == widget.categories[widget.index]['index']
              ? Border.all(color: context.primaryColor, width: 2)
              : Border.all(color: Colors.transparent, width: 1),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [boxShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.isTablet ? 5.sp : 3.sp,
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                widget.categories[widget.index]['logo'],
                width: 15.sp,
                color: widget.categories[widget.index]['color'],
              ),
            ),
          ),
          SizedBox(
            width: context.isTablet ? 4.sp : 10.sp,
          ),
          Text(
            ' ${widget.categories[widget.index]['name']}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: context.isTablet ? 10.sp : 12.sp,
                ),
          ),
        ],
      ),
    );
  }
}
