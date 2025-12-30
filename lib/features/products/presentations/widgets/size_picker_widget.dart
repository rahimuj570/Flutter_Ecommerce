import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';

class SizePickerWidget extends StatefulWidget {
  const SizePickerWidget({super.key});

  @override
  State<SizePickerWidget> createState() => _SizePickerWidgetState();
}

List<String> _sizes = [
  'S',
  'L',
  'XL',
  '2L',
].map((e) => e.toUpperCase()).toList();
String _seletedSize = _sizes[0];

class _SizePickerWidgetState extends State<SizePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sizes', style: TextTheme.of(context).titleMedium),
        SizedBox(height: 5),
        Row(
          children: [
            for (String c in _sizes)
              GestureDetector(
                onTap: () {
                  _seletedSize = c;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: _seletedSize != c
                        ? Colors.white
                        : AppColors.themeColor,
                    // color: ,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        c,
                        style: TextStyle(
                          fontSize: 13,
                          color: _seletedSize == c ? Colors.white : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
