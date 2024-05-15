import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../screens/Calendar.dart';
import '../screens/Doctors.dart';
import '../screens/Home.dart';

class CustomBottomNavigation extends StatelessWidget {

  final bool position;
  final double opacity;
  const CustomBottomNavigation(this.opacity,this.position,{super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: CurvedNavigationBar(
          backgroundColor: Colors.blue,
          items: [
            InkWell(onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home(), ));
            },
              child: const Icon(Icons.home_filled,color: Colors.black,size: 30,),
            ),
            InkWell(onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Calendar(1),
                ),
              );
            },
              child: const Icon(Icons.calendar_month_rounded,color: Colors.black,size: 30,),
            ),
            InkWell(onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Doctors(),),
              );
            },
              child: const Icon(Icons.people,color: Colors.black,size: 30,),
            ),
            InkWell(onTap: (){
            },
              child:  const Icon(Icons.account_circle_outlined,color: Colors.black,size: 30,),
            ),
          ],
        ),
      ),
    );
  }
}
