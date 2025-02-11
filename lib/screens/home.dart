import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news/screens/updateData.dart';
import 'package:news/services/newServices.dart';

import '../models/articlesModel.dart';
import 'addData.dart';
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String selectedCategory = 'general';
  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

String errMsg='';
  List<Articlemodel> listArticles=[];
  final NewServises newservises = NewServises();
  Future<void> fetchNews() async {
    try{
      List<Articlemodel> articles= await newservises.getNews(selectedCategory);
      setState(() {
        listArticles=articles;
      });
    }
    catch(err){
setState(() {

  errMsg = err.toString();

});
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text("News App" ,

          style: TextStyle(color: Colors.purple.shade700),),centerTitle: true,

          actions: [
            DropdownButton(
                items: categories.map((category){
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );

                }).toList(),
                onChanged: (value){
                  if(value != null){
                    selectedCategory=value;
                    fetchNews();
                  }
                })
          ],
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
                  fetchNews(); // إعادة تحميل البيانات بعد الإضافة
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