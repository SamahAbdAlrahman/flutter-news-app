// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
//
// import 'addData.dart';
// class update extends StatefulWidget {
//   @override
//   State<update> createState() => _updateState();
// }
//
// class _updateState extends State<update> {
//   List products=[];
//
//   final _formKey = GlobalKey<FormState>();
//
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//
//   Future<void> fetchData() async {
//     Dio dio = Dio();
//
//     // get res
//     Response response = await dio.get('https://myprojtest.free.beeceptor.com/api/products');
//     setState(() {
//       products = response.data;
//     });
//
//   }
//   Future<void> updateData(int id, String name, String description, String price) async {
//     Dio dio = Dio();
//
//     Response response = await dio.put(
//       'https://myprojtest.free.beeceptor.com/api/products/$id',
//       data: {
//         "name": name,
//         "description": description,
//         "price": double.tryParse(price) ?? 0.0,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تحديث البيانات بنجاح!")));
//       fetchData(); // تحديث البيانات بعد التعديل
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchData();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("update data" ,
//
//         style: TextStyle(color: Colors.purple.shade700),),centerTitle: true,
//       ),
//
//
//       body:
//       products.length==0
//           ?Center(child: CircularProgressIndicator())
//           :Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 11),
//         child: ListView.separated(
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             return DecoratedBox(
//               decoration: BoxDecoration(
//                   color: Colors.purple.shade50,
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   boxShadow: [BoxShadow(
//                     color: Colors.grey.shade400,
//
//                   )]
//
//
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Text(products[index]['name'].toString()),
//
//                     Text(products[index]['description'],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
//                     SizedBox(height: 20,),
//                     Text("price : ${products[index]['price'].toString()}",
//                       style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Colors.deepPurple),),
//                     IconButton(onPressed: (){
//
//                     }, icon: Icon(Icons.edit))
//                   ],
//                 ),
//               ),
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return SizedBox(height: 20,);
//           },
//         ),
//
//
//       ),
//     );
//   }
// }