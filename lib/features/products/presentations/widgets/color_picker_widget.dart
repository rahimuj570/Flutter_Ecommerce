import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key, required this.colorList});
  final List<String> colorList;
  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late String _seletedColor = widget.colorList[0];
  Color getColor(String s) {
    switch (s) {
      case 'red':
        return Colors.red;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'deepPurple':
        return Colors.deepPurple;
      case 'indigo':
        return Colors.indigo;
      case 'blue':
        return Colors.blue;
      case 'lightBlue':
        return Colors.lightBlue;
      case 'cyan':
        return Colors.cyan;
      case 'teal':
        return Colors.teal;
      case 'green':
        return Colors.green;
      case 'lightGreen':
        return Colors.lightGreen;
      case 'lime':
        return Colors.lime;
      case 'yellow':
        return Colors.yellow;
      case 'amber':
        return Colors.amber;
      case 'orange':
        return Colors.orange;
      case 'deepOrange':
        return Colors.deepOrange;
      case 'brown':
        return Colors.brown;
      case 'grey':
        return Colors.grey;
      case 'blueGrey':
        return Colors.blueGrey;
      case 'black':
        return Colors.black;
      case 'gold':
        return Colors.amber;
      case 'golden':
        return Colors.amber;
      case 'white':
        return Colors.white;
      // Accent colors (Color type)
      case 'redAccent':
        return Colors.redAccent;
      case 'pinkAccent':
        return Colors.pinkAccent;
      case 'purpleAccent':
        return Colors.purpleAccent;
      case 'deepPurpleAccent':
        return Colors.deepPurpleAccent;
      case 'indigoAccent':
        return Colors.indigoAccent;
      case 'blueAccent':
        return Colors.blueAccent;
      case 'lightBlueAccent':
        return Colors.lightBlueAccent;
      case 'cyanAccent':
        return Colors.cyanAccent;
      case 'tealAccent':
        return Colors.tealAccent;
      case 'greenAccent':
        return Colors.greenAccent;
      case 'lightGreenAccent':
        return Colors.lightGreenAccent;
      case 'limeAccent':
        return Colors.limeAccent;
      case 'yellowAccent':
        return Colors.yellowAccent;
      case 'amberAccent':
        return Colors.amberAccent;
      case 'orangeAccent':
        return Colors.orangeAccent;
      case 'deepOrangeAccent':
        return Colors.deepOrangeAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailsScreen.selectedColor = _seletedColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Colors', style: TextTheme.of(context).titleMedium),
        SizedBox(height: 5),
        Row(
          children: [
            for (String c in widget.colorList)
              GestureDetector(
                onTap: () {
                  _seletedColor = c;
                  ProductDetailsScreen.selectedColor = _seletedColor;
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
