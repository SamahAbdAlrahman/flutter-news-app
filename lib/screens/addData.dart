import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class add extends StatefulWidget{
  @override
  addState createState() => addState();

}
class addState extends State<add> {


  final _formKey = GlobalKey<FormState>();


  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  Dio dio = Dio();


  bool isLoader = false;



  Future<void> sendData() async {

    setState(() {
      isLoader = true;
    });

      final response = await dio.post(
        'https://myprojtest.free.beeceptor.com/api/products'
        ,
        data: {
          "name": nameController.text,
          "description": descriptionController.text,
          "price": double.tryParse(priceController.text) ?? 0.0,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data added successfully!")),
        );
        // Navigator.pop(context);
        // لحتى يحدث
        Navigator.pop(context,true); //  true للإشارة إلى أن البيانات تغيرت

      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add data",
        style: TextStyle(color: Colors.purple.shade700),
      ),
        centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, top: 20),
        child: Form(
            key: _formKey,

            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                    labelText: "name"

                  ),
                ),
                SizedBox(height:20),

                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a description";
                    }
                    return null;
                  },
maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "description",

                  ),
                ),
                SizedBox(height:20),

                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a price";
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                    labelText: "price"
                  ),
                ),
                SizedBox(height:35),
                !isLoader?
                ElevatedButton(
                    onPressed: (){

                      if (_formKey.currentState!.validate()) {
                        sendData();
                      }                    },
                    child: Text("add data"))
                    :
                Center(child: CircularProgressIndicator())


              ],
            )
        ),

      ),
    );
  }

}