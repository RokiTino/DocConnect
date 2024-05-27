
import 'package:docconnect/widgets/advertisement_card.dart';
import 'package:docconnect/widgets/presentation/categories.dart';
import 'package:docconnect/widgets/presentation/doctorList.dart';
import 'package:docconnect/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'Doctors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var opacity = 0.0;
  bool position=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,() {
      animator();
      setState(() {});
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30,left: 0,right: 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
              top: position ? 1 : 100,
              right: 20,
              left: 20,
                child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget("Hello",17,Colors.black.withOpacity(.7),FontWeight.bold),
                        TextWidget("Giovanny", 25, Colors.black, FontWeight.bold),
                      ],
                    ),
                    const Icon(Icons.phonelink_ring),
                  ],
                ),
              ),
              ),
              AnimatedPositioned( duration: const Duration(milliseconds: 400),
                  top: position? 80: 140,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none,
                        prefixIcon: Icon(Icons.search_sharp,
                        size: 25,
                        color: Colors.black.withOpacity(.5),
                        ),
                        hintText: "     Search"),
                      ),
                    ),
                  )
              ),
              AdvertisementCard(opacity,position),
              Categories(position, opacity),
              AnimatedPositioned(
                  top: position?420:500,
                  left: 20,
                  right: 20, duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget("Our Doctors", 25, Colors.black.withOpacity(.8), FontWeight.bold,letterSpace: 0,),
                          InkWell(
                              onTap: ()
                              {
                                animator();
                                setState(() {
                                });
                                Future.delayed(const Duration(milliseconds: 500));
                                Navigator.push(context, MaterialPageRoute(builder:  (context) {
                                  return const Doctors();
                                },
                                ),
                                );

                                setState(() {
                                  animator();
                                });
                              },
                              child: TextWidget("See all", 15, Colors.blue.shade600.withOpacity(.8), FontWeight.bold,letterSpace: 0,),
                          ),

                        ],
                      ),
                    ),
                  )),
              Doctorlist(position, opacity),
              CustomBottomNavigation(opacity,position)
            ],
          ),
        ),
      ),
    );
  }
}
