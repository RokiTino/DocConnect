import 'package:docconnect/screens/Chat.dart';
import 'package:docconnect/widgets/presentation/app_bar.dart';
import 'package:docconnect/widgets/presentation/find_doctor.dart';
import 'package:flutter/material.dart';

import '../widgets/res/lists.dart';
import '../widgets/text_widget.dart';

class Doctors extends StatefulWidget {
  const Doctors({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {

  var opacity = 0.0;
  bool position=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position=false;
    } else {
      opacity = 1;
      position=true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 70),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 1 : 50,
              left: 20,
              right: 20,
              child: CustomAppBar("Doctors",position,opacity,true),
            ),
            AnimatedPositioned(
                top: position ? 60 : 120,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 300),
                child: FindDoctor(opacity,position),
            ),
            AnimatedPositioned(
                top: position ? 390 : 450,
                right: 20,
                left: 20,
                duration: Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(milliseconds: 400),
                  child: Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          "Nearby Doctors",
                          22,
                          Colors.black,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        TextWidget(
                          "See all",
                          14,
                          Colors.blue.shade900,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: position ? 430 : 500,
                left: 20,
                right: 20,
                duration: Duration(milliseconds: 500),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity,
                    child: Container(
                      height: 350,
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder:
                            (context, index) => InkWell(
                          onTap: () async {
                            animator();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Chat(image: images[index],name: names[index],specialist: spacilality[index]),
                                ));
                            animator();
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  const SizedBox(width: 20,),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: images[index],
                                    backgroundColor: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        names[index],
                                        20,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                        spacilality[index],
                                        17,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.navigation_sharp,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 20,),
                                ],
                              ),
                            ),
                          ),
                        ),),
                    )
                )),
          ],
        ),
      ),
    );
  }
}
