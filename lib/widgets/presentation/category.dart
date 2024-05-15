import 'package:docconnect/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String asset;
  final double padding;
  final String text;

  const Category(this.text,this.padding,this.asset,{super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              padding:  EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image:
                  AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          text,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }
}
