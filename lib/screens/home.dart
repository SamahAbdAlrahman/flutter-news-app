import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news/screens/updateData.dart';

import '../models/articlesModel.dart';
import 'addData.dart';
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  final _formKey = GlobalKey<FormState>();


  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<Articlemodel> listArticles=[];

  Future<void> getNews() async {
    try {
    Dio dio = Dio();
    // get res
    Response response = await dio.get('https://newsapi.org/v2/everything?q=tesla&from=2025-01-06&sortBy=publishedAt&apiKey=1c36a32af5ab4fd78b2d7dd3511aba16');
      Map<String, dynamic> data= response.data;
      List<dynamic> articles = data["articles"];
      List<Articlemodel> artModel=[];
    for (var item in articles) {
      Articlemodel article = Articlemodel(
        title: item["title"] ?? "title unavailable",
        desc: item["description"] ?? "unavailable",
        image: item["urlToImage"],
      );

      artModel.add(article);
    }
    setState(() {
      listArticles = artModel;
    });
    } catch (e) {
      print("Error fetching news: $e");
    }
  }
  // void delete(id)async{
  //   Dio dio = Dio();
  //
  //   Response response = await dio.delete('https://myprojtest.free.beeceptor.com/api/products/${id}');
  //   fetchData();
  // }
  // void update(id)async{
  //
  //   Dio dio = Dio();
  //
  //   Response response = await dio.patch(
  //     'https://myprojtest.free.beeceptor.com/api/products/$id',
  //     data: {
  //       "name": nameController.text,
  //       "description": descriptionController.text,
  //       "price": double.tryParse(priceController.text),
  //     },
  //   );
  //
  //   fetchData();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("News App" ,

          style: TextStyle(color: Colors.purple.shade700),),centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => add()),
              // );
              // لحتى يحدث
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => add()),
              ).then((value) {
                if (value == true) {
                  getNews(); // إعادة تحميل البيانات بعد الإضافة
                }
              });


            },
            child: Icon(Icons.add , color: Colors.white,size: 26,),
            backgroundColor : Colors.purple
        ),

        body:
        listArticles.length==0
            ?Center(child: CircularProgressIndicator())
            :Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 11),
          child: ListView.separated(
            itemCount: listArticles.length,
            itemBuilder: (context, index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.shade400,

                    )]


                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(listArticles[index].title,
                        textAlign: TextAlign.center,

                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),

                      ),
                      SizedBox(height: 12,),

                      Text(listArticles[index].desc,
                        textAlign: TextAlign.center,
                        // style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.edit)
                          ),

                          IconButton(onPressed: (){
                            // delete(products[index]['id']);
                            setState(() {

                            });
                          }, icon: Icon(Icons.dangerous)),
                        ],
                      )

                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20,);
            },
          ),


        ),
      );
  }
}