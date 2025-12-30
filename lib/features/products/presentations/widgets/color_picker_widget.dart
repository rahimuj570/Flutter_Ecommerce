import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key});

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

List<String> _colors = [
  'Red',
  'green',
  'blue',
].map((e) => e.toLowerCase()).toList();
String _seletedColor = _colors[0];
MaterialColor getColor(String s) {
  switch (s) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'orange':
      return Colors.orange;
    case 'blue':
      return Colors.blue;
    default:
      return Colors.grey;
  }
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Colors', style: TextTheme.of(context).titleMedium),
        SizedBox(height: 5),
        Row(
          children: [
            for (String c in _colors)
              GestureDetector(
                onTap: () {
                  _seletedColor = c;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: getColor(c),
                    // color: ,
                    shape: BoxShape.circle,
                  ),
                  child: c == _seletedColor
                      ? Icon(
                          Icons.check_rounded,
                          color: c != 'white' ? Colors.white : Colors.black,
                          size: 15,
                        )
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
