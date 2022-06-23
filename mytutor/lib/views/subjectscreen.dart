import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';

import '../models/subject.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<Subject> subjectList = <Subject>[];
  String titlecenter = "";
  var rating = "";
  late double screenHeight, screenWidth, resWidth;
  var numofpage, curpage = 1;
  var color;
  TextEditingController searchController = TextEditingController();
  String search = "";
  String arrangement = "ASC";

  @override
  void initState() {
    super.initState();
    _loadSubjects(1, search, arrangement);
  }

  Future<void> _refresh() async {
    return await Future.delayed(const Duration(milliseconds: 500));
  }

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
      appBar: AppBar(
        title: const Text('Subjects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
        ],
      ),
      body: subjectList.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  Center(
                      child: Text(titlecenter,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                ],
              ),
            )
          : LiquidPullToRefresh(
                  onRefresh: _refresh,
                  color: Colors.teal,
                  backgroundColor: const Color.fromARGB(255, 246, 254, 255),
                  animSpeedFactor: 2,
                  springAnimationDurationInMilliseconds: 1000,
                  showChildOpacityTransition: true,
            
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Expanded(
                    //   child: LiquidPullToRefresh(
                    // onRefresh: _refresh,
                    // color: const Color.fromARGB(255, 246, 254, 255),
                    // backgroundColor: Colors.teal,
                    // animSpeedFactor: 2,
                    // springAnimationDurationInMilliseconds: 1000,
                    // showChildOpacityTransition: true,
                    child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 1),
                        children: List.generate(subjectList.length, (index) {
                          return InkWell(
                            splashColor: const Color.fromARGB(255, 156, 219, 213),
                            onTap: () => {_loadSubjectDetails(index)},
                            child: Card(
                                elevation: 5,
                                color: const Color.fromARGB(255, 220, 243, 241),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  children: [
                                    Flexible(
                                      flex: 7,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: CachedNetworkImage(
                                              height: 100.0,
                                              imageUrl: CONSTANTS.server +
                                                  "/mytutor/mobile/assets/courses/" +
                                                  subjectList[index]
                                                      .subjectId
                                                      .toString() +
                                                  '.png',
                                              fit: BoxFit.cover,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20)),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              width: resWidth,
                                              placeholder: (context, url) =>
                                                  const LinearProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 3,
                                            right: 2,
                                            child: Icon(Icons.circle,
                                                color: Colors.red,
                                                size: 40), //Icon
                                          ),
                                          Positioned(
                                            top: -2,
                                            right: -2,
                                            child: IconButton(
                                              icon: const Icon(Icons.touch_app,
                                                  color: Colors.white),
                                              onPressed: () {
                                                print("subscribe");
                                                //_addSubscribe(index);
                                              },
                                            ), //Icon
                                          ),
                                          const Positioned(
                                            bottom: 3,
                                            right: 2,
                                            child: Icon(Icons.circle,
                                                color: Colors.white,
                                                size: 40), //Icon
                                          ),
                                          Positioned(
                                            bottom: -3,
                                            right: -2,
                                            child:
                                                // FavoriteButton(
                                                //   iconSize: -10,
                                                //   isFavorite: false,
                                                //   valueChanged: (_isFavorite){
                                                //     _addFavorite(index);
                                                //     print('favorite: $_isFavorite');
                                                //   }
                                                //   ),
                                                IconButton(
                                              icon: const Icon(
                                                  Icons.favorite_rounded,
                                                  color: Colors.red),
                                              onPressed: () {
                                                print("favorite");
                                                //_addFavorite(index);
                                              },
                                            ), //Icon
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      subjectList[index].subjectName.toString(),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    Flexible(
                                        flex: 5,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(children: [
                                                    Text(
                                                        "RM " +
                                                            double.parse(subjectList[
                                                                        index]
                                                                    .subjectPrice
                                                                    .toString())
                                                                .toStringAsFixed(
                                                                    2),
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w500)),
                                                    Text(
                                                        subjectList[index]
                                                                .subjectSessions
                                                                .toString() +
                                                            " sessions",
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w500)),
                                                    RatingBarIndicator(
                                                      rating: double.parse(
                                                          subjectList[index]
                                                              .subjectRating
                                                              .toString()),
                                                      direction: Axis.horizontal,
                                                      itemCount: 5,
                                                      itemSize: 15,
                                                      itemPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder: (context, _) =>
                                                          const Icon(
                                                        Icons.star_rounded,
                                                        color: Colors.amber,
                                                        size: 2,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                  ],
                                )),
                          );
                        })),
                  //)
                  ),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: numofpage,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if ((curpage - 1) == index) {
                          color = const Color.fromARGB(255, 1, 30, 27);
                        } else {
                          color = const Color.fromARGB(255, 61, 174, 163);
                        }
                        return SizedBox(
                          width: 40,
                          child: TextButton(
                              onPressed: () => {_loadSubjects(index + 1, "", "")},
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(color: color),
                              )),
                        );
                      },
                    ),
                  ),
                ]),
              ),
          ),
    );
  }

  void _loadSubjects(int pageno, String _search, String _arrangement) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_subjects.php"),
        body: {
          'pageno': pageno.toString(),
          'search': _search,
          'arrangement': _arrangement,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);
        if (extractdata['subjects'] != null) {
          subjectList = <Subject>[];
          extractdata['subjects'].forEach((v) {
            subjectList.add(Subject.fromJson(v));
          });
          titlecenter = subjectList.length.toString() + " Subjects Available";
        } else {
          titlecenter = "No Subject Available";
          subjectList.clear();
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Subject Available";
        subjectList.clear();
        setState(() {});
      }
    });
  }

  _loadSubjectDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                // iconTheme: const IconThemeData(
                //   color: Colors.black,
                //   shadows: <Shadow>[
                //     Shadow(
                //       offset: Offset(0, 0),
                //       blurRadius: 5.0,
                //       color: Color.fromARGB(255, 255, 255, 255),
                //     ),
                //   ], //change your color here
                // ),
                pinned: true,
                floating: false,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Stack(
                    children: [
                      Text('Subject Details',
                          style: TextStyle(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = Colors.white)),
                      const Text('Subject Details',
                          style: TextStyle(color: Colors.black))
                    ],
                  ),
                  centerTitle: true,
                  background: Container(
                    color: Colors.white,
                    child: CachedNetworkImage(
                      height: 200.0,
                      imageUrl: CONSTANTS.server +
                          "/mytutor/mobile/assets/courses/" +
                          subjectList[index].subjectId.toString() +
                          '.png',
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      width: resWidth,
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        subjectList[index].subjectName.toString(),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBarIndicator(
                            rating: double.parse(
                                subjectList[index].subjectRating.toString()),
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 50,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                          ),
                          Text(
                            subjectList[index].subjectRating.toString(),
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                const TextSpan(
                                    text: "\nSubject Description: \n",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16)),
                                TextSpan(
                                    text: subjectList[index]
                                        .subjectDesc
                                        .toString(),
                                    style: const TextStyle(fontSize: 16)),
                                const TextSpan(
                                    text: "\n\nTutor: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        subjectList[index].tutorName.toString(),
                                    style: const TextStyle(fontSize: 16)),
                                const TextSpan(
                                    text: "\n\nPrice: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16)),
                                const TextSpan(text: " RM "),
                                TextSpan(
                                    text: double.parse(subjectList[index]
                                            .subjectPrice
                                            .toString())
                                        .toStringAsFixed(2),
                                    style: const TextStyle(fontSize: 16)),
                                const TextSpan(
                                    text: "\n\nSession: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16)),
                                TextSpan(
                                    text: subjectList[index]
                                        .subjectSessions
                                        .toString(),
                                    style: const TextStyle(fontSize: 16)),
                                const TextSpan(
                                    text: " sessions",
                                    style: TextStyle(fontSize: 16))
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  void _loadSearchDialog() {
    searchController.text = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  //height: screenHeight / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search by subject name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Price: ", style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    arrangement = "ASC";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(
                                      255, 220, 243, 241), // background
                                  onPrimary: Colors.grey[700], // foreground
                                ),
                                child: const Text("ASC",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    arrangement = "DESC";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(
                                      255, 220, 243, 241), // background
                                  onPrimary: Colors.grey[700], // foreground
                                ),
                                child: const Text("DESC",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      search = searchController.text;
                      arrangement = arrangement;
                      Navigator.of(context).pop();
                      _loadSubjects(1, search, arrangement);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }

  void _addFavorite(int index) {}
}
