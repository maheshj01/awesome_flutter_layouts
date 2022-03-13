import 'package:awesome_flutter_layouts/demos/clock/constants/constants.dart';
import 'package:flutter/material.dart';

class SearchBuilder extends StatefulWidget {
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String hint;
  final TextEditingController? controller;
  final Function(String)? onChange;

  const SearchBuilder(
      {Key? key,
      this.leadingIcon,
      this.trailingIcon,
      this.hint = 'Search',
      this.onChange,
      this.controller})
      : super(key: key);

  @override
  _SearchBuilderState createState() => _SearchBuilderState();
}

class _SearchBuilderState extends State<SearchBuilder> {
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller = TextEditingController();
    } else {
      controller = widget.controller!;
    }
  }

  late TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(size_md_6),
      margin: const EdgeInsets.symmetric(horizontal: size_ex_lg_24),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [searchShadow],
          borderRadius: BorderRadius.circular(circle_radius * 1.6)),
      child: TextField(
          controller: controller,
          onChanged: (x) =>
              widget.onChange != null ? widget.onChange!(x) : null,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              prefixIcon: widget.leadingIcon,
              suffixIcon: widget.trailingIcon)),
    );
  }
}
