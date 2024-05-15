import 'package:docconnect/widgets/presentation/category.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final position;
  final opacity;

  const Categories(this.position,this.opacity,{super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: position? 320 : 420,
        left: 25,
        right: 25,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Category("Drug", 5.0, "assets/images/capsule.png"),
                Category("Virus", 10.0, "assets/images/virus.png"),
                Category( "Physo",10,"assets/images/heart.png"),
                TapRegion(child: Category("Other",12,"assets/images/app.png"),),
              ],
            ),
          ),
        ));
  }
}
