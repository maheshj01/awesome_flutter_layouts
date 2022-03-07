import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:flutter/material.dart';

class HorizontalTabBuilder extends StatefulWidget {
  final List<String> tabs;
  final String selected;
  final TabController? controller;

  final Function(String)? onChange;
  HorizontalTabBuilder(
      {Key? key,
      required this.tabs,
      required this.selected,
      this.onChange,
      this.controller})
      : assert(tabs.isNotEmpty),
        assert(tabs.contains(selected), 'selected not present in tabs'),
        super(key: key);

  @override
  _HorizontalTabBuilderState createState() => _HorizontalTabBuilderState();
}

class _HorizontalTabBuilderState extends State<HorizontalTabBuilder>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: DefaultTabController(
        initialIndex: 1,
        length: widget.tabs.length,
        animationDuration: const Duration(milliseconds: 500),
        child: TabBar(
            controller: controller,
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: size_md_6),
            indicatorSize: TabBarIndicatorSize.label,
            indicator: const UnderlineTabIndicator(),
            onTap: (x) {
              // print(widget.tabs[x]);
              if (widget.onChange != null) {
                widget.onChange!(widget.tabs[x]);
              }
            },
            tabs: widget.tabs.map((e) {
              bool isSelected = widget.selected == e;
              return Container(
                  margin:
                      EdgeInsets.only(left: e == 'Clocks' ? size_ex_lg_24 : 0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: size_md_6 * 2, vertical: size_md_6 * 2),
                  decoration: BoxDecoration(
                    boxShadow: [shadowLight],
                    color: isSelected ? black : Colors.white,
                    borderRadius: BorderRadius.circular(circle_radius),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey),
                  ));
            }).toList()),
      ),
    );
  }
}
