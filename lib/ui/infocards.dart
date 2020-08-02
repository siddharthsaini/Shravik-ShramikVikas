import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Shravik/ui/userprofile.dart';
import 'infolists.dart';

class InfoCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselWithIndicatorDemo();
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[800],
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.6,
                        // aspectRatio: 3,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        // aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: titleCard.map((url) {
                      int index = titleCard.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Colors.red[600]
                              : Colors.grey[350],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: IconButton(
                  iconSize: 35,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              bottomMe(
                Text(
                  "Developed by Siddharth Saini",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bottomMe(Text text) {
  return FlatButton(
    onPressed: () => customLauncher('https://www.linkedin.com/in/sidxharth/'),
    child: text,
  );
}
