import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_desgin_expert_task/controllers/order_provider.dart';
import 'package:media_desgin_expert_task/models/product_model.dart';
import 'package:media_desgin_expert_task/utilis/colors.dart';
import 'package:media_desgin_expert_task/utilis/snackbar_utilis.dart';
import 'package:provider/provider.dart';

class AddProductRow extends StatefulWidget {
  const AddProductRow({super.key});

  @override
  State<AddProductRow> createState() => _AddProductRowState();
}

class _AddProductRowState extends State<AddProductRow> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final productSuggestions = provider.products.map((e) => e.name).toList();

    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 10.w),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "QTY",
                hintStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),
         
          
          const SizedBox(width: 8),
         
          Expanded(
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return productSuggestions.where(
                  (option) => option.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
                );
              },
              onSelected: (String selection) {
                _nameController.text = selection;
              },
              fieldViewBuilder: (
                context,
                controller,
                focusNode,
                onFieldSubmitted,
              ) {
                _nameController.text = controller.text;
                return TextField(
                  controller: _nameController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(hintText: 'Product Name',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  )),
                );
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.green),
            onPressed: () {
              final id = _idController.text;
              final productName = _nameController.text;
              if (id.isEmpty) {
                return SnackbarUtils.showCustomSnackbar(
                  context: context,
                  title: "Error",
                  message: "Please enter a Quantity",
                  backgroundColor: redColor,
                );
              }
              if (productName.isEmpty) {
                return SnackbarUtils.showCustomSnackbar(
                  context: context,
                  title: "Error",
                  message: "Please enter a ProductName",
                  backgroundColor: redColor,
                );
              }
              if (_idController.text.isNotEmpty &&
                  _nameController.text.isNotEmpty) {
                final newProduct = ProductModel(
                  id: int.tryParse(_idController.text) ?? 0,
                  name: _nameController.text,
                );
                provider.addProduct(newProduct, context);

                _idController.clear();
                _nameController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
