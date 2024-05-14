import 'package:docconnect/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdvertisementCard extends StatelessWidget {

  final opacity;
  final position;

  const AdvertisementCard(this.opacity,this.position,{super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: position? 150: 220,
      left: 20,
      right: 20,
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          child: Container(
            height: 150,
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
                  ]
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 25,
                    left: 25,
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
                              image: AssetImage('assets/images/p1.png'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget("You're invited to the live", 15, Colors.white, FontWeight.normal, letterSpace: 1,),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextWidget(
                                  "Stream with  ",
                                  15,
                                  Colors.white,
                                  FontWeight.normal,
                                  letterSpace: 1,
                                ),
                                TextWidget(
                                  "Dr.Navida",
                                  15,
                                  Colors.white,
                                  FontWeight.bold,
                                  letterSpace: 2,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
                Positioned(
                    top: 100,
                    left: 20,
                    child: Container(
                      height: 1,
                      width: 300,
                      color: Colors.white.withOpacity(.5),
                    )),
                Positioned(
                  top: 115,
                  left: 20,
                  right: 1,
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        TextWidget("120K people join live Stream!", 15, Colors.white, FontWeight.bold, letterSpace: 1,),
                        const SizedBox(width: 10,),
                        const Expanded(child: Stack(
                          children: [
                            Positioned(child: CircleAvatar(radius: 15,backgroundColor: Colors.blue,)),
                      Positioned(
                        left: 20,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                        ),
                      ),
                      Positioned(
                        left: 40,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                        ),),
                          ],
                        )),

                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                        size: 15,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
