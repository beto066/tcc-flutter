import 'package:flutter/material.dart';

class InputAutocomplete extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<String> options;
  final Function(String)? onSelected;
  final double? height;
  final double? width;
  final TextInputType? keyboardType;
  final int? maxLines;
  final double fontSize;

  const InputAutocomplete(
    this.label, {
      super.key,
      this.controller,
      this.focusNode,
      required this.options,
      this.onSelected,
      this.height,
      this.width,
      this.keyboardType,
      this.maxLines,
      this.fontSize = 14,
    }
  );

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      textEditingController: controller,
      focusNode: focusNode,

      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) {
          return const Iterable<String>.empty();
        }

        return options.where(
              (option) => option.toLowerCase().contains(
            value.text.toLowerCase(),
          ),
        );
      },

      onSelected: (value) {
        if (controller?.text != null) {
          controller!.text = value;
        }
        onSelected?.call(value);
      },

      fieldViewBuilder: (
          context,
          textController,
          textFocusNode,
          onFieldSubmitted,
          ) {
        return SizedBox(
          height: height,
          width: width,
          child: TextFormField(
            controller: textController,
            focusNode: textFocusNode,

            keyboardType: keyboardType,
            maxLines: maxLines,

            style: TextStyle(
              fontSize: fontSize,
            ),

            decoration: InputDecoration(
              labelText: label,

              fillColor: Colors.lightBlue[50],
              filled: true,

              floatingLabelStyle: const TextStyle(
                color: Color(0xFF7A8CBA),
              ),

              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFDEE2E3),
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF7A8CBA),
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFBEC2C3),
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),

              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
            ),
          ),
        );
      },

      optionsViewBuilder: (
          context,
          onSelected,
          options,
          ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(20),

            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 200,
                minWidth: 200,
              ),

              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,

                itemCount: options.length,

                itemBuilder: (context, index) {
                  final option = options.elementAt(index);

                  return ListTile(
                    dense: true,

                    title: Text(
                      option,
                      overflow: TextOverflow.ellipsis,
                    ),

                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}