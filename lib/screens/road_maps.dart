import 'package:farmogram/widgets/cotton.dart';
import 'package:farmogram/widgets/rice.dart';
import 'package:farmogram/widgets/wheat.dart';
import 'package:flutter/material.dart';

class RoadMaps extends StatefulWidget {
  const RoadMaps({super.key});

  @override
  State<RoadMaps> createState() => _RoadMapsState();
}

class _RoadMapsState extends State<RoadMaps> {
  int selected = 0;
  final List<Widget> _child = [
    const RiceScreen(),
    const wheatScreen(),
    const CottonScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff80AF81),
      appBar: AppBar(
        centerTitle: true,
        shadowColor: const Color(0xff80AF81),
        surfaceTintColor: const Color(0xff80AF81),
        backgroundColor: const Color(0xff80AF81),
        title: const Text('Roadmaps'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: const Color(0xff80AF81),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 0;
                        });
                      },
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: selected == 0
                                ? Colors.white
                                : const Color(0xff80AF81)),
                        child: Center(
                            child: Text(
                          'Rice',
                          style: TextStyle(fontSize: width * 0.04),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 1;
                        });
                      },
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: selected == 1
                                ? Colors.white
                                : const Color(0xff80AF81)),
                        child: Center(
                            child: Text(
                          'Wheat',
                          style: TextStyle(fontSize: width * 0.04),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 2;
                        });
                      },
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: selected == 2
                                ? Colors.white
                                : const Color(0xff80AF81)),
                        child: Center(
                            child: Text(
                          'Cotton',
                          style: TextStyle(fontSize: width * 0.04),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            color: Colors.white,
            height: height * 0.7955,
            child: _child[selected],
          )
        ],
      ),
    );
  }
}
