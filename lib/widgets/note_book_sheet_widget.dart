import 'package:flutter/material.dart';
import 'package:media_desgin_expert_task/controllers/order_provider.dart';
import 'package:media_desgin_expert_task/models/product_model.dart';
import 'package:media_desgin_expert_task/view/product%20_screen.dart';
import 'package:media_desgin_expert_task/widgets/add_product_row_widget.dart';
import 'package:media_desgin_expert_task/widgets/custom_note_book_line_widget.dart';
import 'package:provider/provider.dart';

class NotebookSheet extends StatelessWidget {
  final List<ProductModel> apiData;

  const NotebookSheet({Key? key, required this.apiData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final allProducts = [...apiData];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: allProducts.length + 1,
            itemBuilder: (context, index) {
              print("::::the length isd here:${allProducts.length.toString()}");
              if (index == allProducts.length) {
                return AddProductRow(); 
              }
              final item = allProducts[index];
              return NotebookLine(
                index: index,
                content: item.name,
                id: item.id.toString(),
                isEmpty: false,
              );
            },
          ),
        ),
      ],
    );
  }
}


