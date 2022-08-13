import 'dart:convert';

import 'package:assignment_4/models/news.dart';
import 'package:assignment_4/models/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<News>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getNewsData();
  }

  Future<List<News>> getNewsData() async {
    final response = await http.get(Uri.parse('https://api.nytimes.com/svc/topstories/v2/world.json?api-key=Hj6Dggr3aCeqMTkIGBqqWuSKRJArUkUA'));
    if (response.statusCode == 200) {
      print(response.body);
      var json = jsonDecode(response.body);
      var results = json['results'] as List<dynamic>?;
      if (results != null) {
        var items = results.map((item)=> News.fromJson(item));
        var newsItems = items.where((item) {
          return item.abstract != null && item.abstract!.isNotEmpty && item.multimedia != null && item.multimedia!.isNotEmpty;
        });
        return newsItems.toList();
      } else {
        throw Exception('Data parsing error');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder<List<News>>(
          future: futureData,
          builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data != null){
                  var data = snapshot.data!;
                  return Center(
                    child: ListView.builder(
                      itemBuilder: (context, index){
                        var item = data[index];
                       return Container(
                         margin: const EdgeInsets.only(top:10),
                         child: Card(
                           shape: RoundedRectangleBorder(
                             side: const BorderSide(color: Colors.white70, width: 1),
                             borderRadius: BorderRadius.circular(10),
                           ),
                           elevation: 5,
                           shadowColor: Colors.black,
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                               child: Column(
                                 children: [
                                   SizedBox(height:150, child: FadeInImage.assetNetwork(placeholderFit: BoxFit.contain, placeholder: "assets/images/placeholder.png",image: item.multimedia![0], height: 150, width: double.infinity, fit: BoxFit.cover,)),
                                   Container(
                                     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                     child: Text('${item.title}', style: const TextStyle(
                                       fontSize: 17,
                                       fontWeight: FontWeight.w600
                                     ),),
                                   ),
                                   Container(
                                       margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                       child: Text('${item.abstract}')),
                                 ],
                               )),  ),
                       );
                      },
                      itemCount: data.length,
                    ),
                  );
                }else{
                  return const Center(child: Text('No Data'));
                }

              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
