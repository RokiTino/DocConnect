import 'package:docconnect/widgets/presentation/doctorcard.dart';
import 'package:docconnect/widgets/res/lists.dart';
import 'package:flutter/material.dart';

import '../../screens/Profile.dart';

class Doctorlist extends StatelessWidget {
  final bool position;
  final double opacity;

  const Doctorlist(this.position,this.opacity,{super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: position ?460:550,
        left: 20,
        right: 20,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child:
                Column(
                  children: [
                    InkWell(
                       onTap: () {
                         Navigator.push(context,
                         MaterialPageRoute(builder: (context) => Profile(name: names[0], image: images[0], speciality: spacilality[0],)));
                       },
                      child: Doctorcard(names[0],spacilality[0], images[0]),
                    ),
                    InkWell( onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile(name: names[1], image: images[1], speciality: spacilality[1],)));
                    },
                    child: Doctorcard(names[1], spacilality[1], images[1]),
                    ),

              InkWell( onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile(name: names[2], image: images[2], speciality: spacilality[2],)));
              },
                child:
                Doctorcard(names[2], spacilality[2], images[2]),),
                  ],
                ),

              ),
            ),
          ),
        )
    );
  }
}
