import 'package:flutter/material.dart';

import '../../screens/Doctors.dart';
import '../../screens/Profile.dart';
import '../text_widget.dart';

class ChatAppBar extends StatelessWidget {

  final AssetImage image;
  final String name;
  final String specialist;

  late Size size;
  var animate = false;
  var opacity = 0.0;


  ChatAppBar(this.image,this.name,this.specialist,this.size,this.opacity,this.animate,{super.key});

  animator() {
    if (opacity == 0.0) {
      opacity = 1.0;
      animate = true;
    } else {
      opacity = 0.0;
      animate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 1,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 70,
          color: Colors.white,
          width: size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: ()
                {
                  animator();

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Doctors(),)
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.black,
                ),
              ),
              InkWell(
                onTap: () async
                {
                  animator();
                  await Future.delayed(const Duration(milliseconds: 400));
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(image: image,name: name,speciality: specialist),));
                  animator();
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  backgroundImage: image,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    name,
                    15,
                    Colors.black,
                    FontWeight.bold,
                    letterSpace: 0,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle),
                      ),
                      TextWidget(
                        "online",
                        13,
                        Colors.black,
                        FontWeight.normal,
                        letterSpace: 1,
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.video_camera_front,
                        color: Colors.white.withOpacity(.7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.wifi_calling_outlined,
                        color: Colors.white.withOpacity(.7),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
