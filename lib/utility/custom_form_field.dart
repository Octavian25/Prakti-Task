import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/utility/styles.dart';

class CustomFormField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hint;
  final Function()? handleOnTap;
  final FocusNode? focusNode;
  final bool? enabled;
  const CustomFormField(
      {super.key,
      required this.controller,
      required this.title,
      required this.hint,
      this.enabled,
      this.focusNode,
      this.handleOnTap});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    }
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: normal.copyWith(fontSize: 12.sp),
        ),
        5.verticalSpacingDiagonal,
        TextFormField(
          showCursor: widget.enabled ?? true,
          keyboardType: widget.enabled ?? true == true ? TextInputType.text : TextInputType.none,
          focusNode: focusNode,
          onTap: widget.handleOnTap,
          controller: widget.controller,
          style: normal.copyWith(fontSize: 12.sp),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Cant be empty";
            }
            return null;
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: widget.hint,
              contentPadding: EdgeInsets.only(left: 16.dg, top: 8.dg, bottom: 8.dg),
              border: OutlineInputBorder(borderSide: BorderSide(color: "#E7E7E7".toColor())),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: "#E7E7E7".toColor())),
              focusedBorder:
                  const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
              suffixIcon: (controller.text.isNotEmpty)
                  ? IconButton(
                      splashRadius: 5,
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        controller.clear();
                      },
                      icon: const Icon(Icons.clear))
                  : null),
        )
      ],
    );
  }
}
