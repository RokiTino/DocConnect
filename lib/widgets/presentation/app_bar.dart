import 'package:flutter/material.dart';

import '../text_widget.dart';

class CustomAppBar extends StatelessWidget {

  var opacity = 0.0;
  bool position=false;
  String title;
  bool searchEnabled = false;

  CustomAppBar(this.title,this.position,this.opacity,this.searchEnabled,{super.key});

  animator() {
    if (opacity == 0.0) {
      opacity = 1.0;
    } else {
      opacity = 0.0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 5,
        right: 20,
        left: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  animator();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                )),
            TextWidget(
              title,
              25,
              Colors.black,
              FontWeight.bold,
              letterSpace: 0,
            ),
            Container(
              height: 10,
            ),
            searchEnabled ? const Icon(
              Icons.search,
              color: Colors.black,
              size: 25,
            ): const SizedBox()
          ],
        ),
    );
  }
}
