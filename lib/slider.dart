import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//String url = 'http://updatejewelry.com/rural_munici/image_api/imagejson.php';
//
//Post postFromJson(String str) {
//  final jsonData = json.decode(str);
//  return Post.fromJson(jsonData);
//}
//
//String postToJson(Post data) {
//  final dyn = data.toJson();
//  return json.encode(dyn);
//}
//
//
//List<Post> allPostsFromJson(String str) {
//  final jsonData = json.decode(str);
//  return new List<Post>.from(jsonData.map((x) => Post.fromJson(x)));
//}
//
//String allPostsToJson(List<Post> data) {
//  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
//  return json.encode(dyn);
//}
//
//class Post {
//  int id;
//  String name;
//  String image;
//
//  Post({
//    this.id,
//    this.name,
//    this.image,
//  });
//
//  factory Post.fromJson(Map<String, dynamic> json) => new Post(
//    id: json["id"],
//    name: json["name"],
//    image: json["image"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "id": id,
//    "name": name,
//    "image": image,
//  };
//}
//
//
//List<String> imgList;
//
//Future<Post> getPost() async{
//  final response = await http.get('$url');
//  return postFromJson(response.body);
//}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

void main() => runApp(CarouselChangeReasonDemo());

class CarouselChangeReasonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselChangeReasonDemoState();
  }
}

class _CarouselChangeReasonDemoState extends State<CarouselChangeReasonDemo> {
  String reason = '';
  final CarouselController _controller = CarouselController();

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: MediaQuery.of(context).size.height / 4,
              onPageChanged: onPageChange,
              autoPlay: true,
            ),
            carouselController: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: RaisedButton(
                  onPressed: () => _controller.previousPage(),
                  child: Text('←'),
                ),
              ),
              Flexible(
                child: RaisedButton(
                  onPressed: () => _controller.nextPage(),
                  child: Text('→'),
                ),
              ),
              ...Iterable<int>.generate(imgList.length).map(
                (int pageIndex) => Flexible(
                  child: RaisedButton(
                    onPressed: () => _controller.animateToPage(pageIndex),
                    child: Text("$pageIndex"),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                Text('page change reason: '),
                Text(reason),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
//                child: Text(
//                  'No. ${imgList.indexOf(item)} image',
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
