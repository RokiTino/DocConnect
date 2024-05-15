import 'package:flutter/material.dart';

import '../text_widget.dart';

class FindDoctor extends StatelessWidget {

  var opacity = 0.0;
  bool position=false;

  FindDoctor(this.opacity,this.position,{super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: opacity,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade700,
                    Colors.blue.shade900,
                    Colors.blue.shade900,
                  ])),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 25,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Center(
                          child: Image(
                            fit: BoxFit.fill,
                            image:
                            AssetImage('assets/images/p1.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            "Find Doctors!",
                            18,
                            Colors.white,
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                "Use this feature to find a doctor\nclosest to you",
                                15,
                                Colors.white,
                                FontWeight.normal,
                                letterSpace: 0,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
              Positioned(
                  top: 115,
                  left: 20,
                  right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  'assets/images/map.png'))),
                    ),
                  )),
              const Positioned(
                  top: 15,
                  right: 15,
                  child: Icon(
                    Icons.close_outlined,
                    color: Colors.white,
                    size: 15,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
