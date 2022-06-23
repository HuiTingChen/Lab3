import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/subject.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({Key? key,}) : super(key: key);

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  late double screenHeight, screenWidth, resWidth;
  List<Subject> subjectList = <Subject>[];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }
    return Scaffold(
        body: Column(
          children: List.generate(subjectList.length, (index) {
            return CustomScrollView(
      slivers: <Widget>[
            SliverAppBar(
              //pinned: true,
              floating: false,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Basic Slivers'),
                centerTitle: true,
                background: Container(
                  color: Colors.yellow,
                  child: CachedNetworkImage(
                    height: 100.0,
                    imageUrl: CONSTANTS.server +
                        "/mytutor/mobile/assets/courses/" +
                        subjectList[index].subjectId.toString() +
                        '.png',
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    width: resWidth,
                    placeholder: (context, url) => const LinearProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            // SliverFixedExtentList(
            //   itemExtent: 50,
            //   delegate: SliverChildListDelegate([
            //     Container(color: Colors.red),
            //     Container(color: Colors.green),
            //     Container(color: Colors.blue),
            //   ]),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.orange[100 * (index % 9)],
                    child: Text('orange $index'),
                  );
                },
                childCount: 9,
              ),
            ),
      ],
    );})
        ));
  }
}
