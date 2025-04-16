import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:media_desgin_expert_task/models/product_model.dart';
import 'package:media_desgin_expert_task/utilis/constant.dart';

class ProductService {
  static const String _url = baseUrl;

  static Future<List<ProductModel>> fetchProducts() async {
   try{
     final response = await http.get(Uri.parse(_url),
    headers: {
      "Content-Type":"application/json"
    });
    print(":::: the status code is here :${response.statusCode}");
        print(":::: the response is  is here :${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data.entries
          .map((entry) => ProductModel.fromMapEntry(entry))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
   }
on TimeoutException{
  throw Exception("Timeout excepton");
}
on SocketException{
  throw Exception("Internet Exception");
}
   catch(e){
  throw Exception("Error while fetching the products ${e.toString()}");
   }
  }
}
