import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_desgin_expert_task/controllers/order_provider.dart';
import 'package:media_desgin_expert_task/models/product_model.dart';
import 'package:media_desgin_expert_task/utilis/colors.dart';
import 'package:media_desgin_expert_task/widgets/notes_and_images_dialoug.dart';
import 'package:provider/provider.dart';

class NotebookLine extends StatelessWidget {
  final int index;
  final String content;
  final String? id;
  final bool isEmpty;

  const NotebookLine({
    Key? key,
    required this.index,
    required this.content,
    required this.isEmpty,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final provider = Provider.of<OrderProvider>(context, listen: false);
    final product = provider.products[index];
    return GestureDetector(

          onDoubleTap: () => _showNotesDialog(context, index, product),
  onLongPress: () => _showNotesDialog(context, index, product),
  
  child:  Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.teal.withOpacity(0.3), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            // Product ID on the left
            if (!isEmpty && id != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SizedBox(
                  width: 40, // Fixed width for ID column
                  child: Text(
                    id!,
                    style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w300,
                      color: blackColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            else
              const SizedBox(width: 56), 
          
            Container(width: 1, height: 40, color: Colors.teal.withOpacity(0.5)),
      
         
            if (!isEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    content,
                     style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w300,
                      color: blackColor,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (product.hasNotes || product.hasImage) 
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (product.hasNotes)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(Icons.info, color: greyColor, size: 20),
                    ),
                  if (product.hasImage)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(Icons.camera_alt_outlined,color: greyColor, size: 20),
                    ),
                ],
              ),
          
          
            Spacer(),
            if (!isEmpty)
              Consumer<OrderProvider>(
                builder: (context, value, child) {
                  return GestureDetector(
                    onTap: () {
                      value.removeProduct(index, context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Icon(Icons.delete, color: redColor),
                    ),
                  );
                },
              ),
      
            if (isEmpty) const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
  void _showNotesDialog(BuildContext context, int index, ProductModel product) {
    showDialog(
      context: context,
      builder: (context) => NotesAndImagesDialog(
        productIndex: index,
        product: product,
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:media_desgin_expert_task/models/product_model.dart';
// import 'package:media_desgin_expert_task/widgets/notes_and_images_dialoug.dart';
// import 'package:provider/provider.dart';
// import 'package:media_desgin_expert_task/controllers/order_provider.dart';

// class NotebookLine extends StatelessWidget {
//   final int index;
//   final String content;
//   final String id;
//   final bool isEmpty;

//   const NotebookLine({
//     Key? key,
//     required this.index,
//     required this.content,
//     required this.id,
//     required this.isEmpty,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<OrderProvider>(context, listen: false);
//     final product = provider.products[index];

//     return GestureDetector(
//       onDoubleTap: () => _showNotesDialog(context, index, product),
//       onLongPress: () => _showNotesDialog(context, index, product),
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Text('${index + 1}.', style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(width: 8),
//             Expanded(child: Text(content)),
//             if (product.hasNotes || product.hasImage) 
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (product.hasNotes)
//                     Padding(
//                       padding: const EdgeInsets.only(left: 4),
//                       child: Icon(Icons.info, color: Colors.blue, size: 20),
//                     ),
//                   if (product.hasImage)
//                     Padding(
//                       padding: const EdgeInsets.only(left: 4),
//                       child: Icon(Icons.camera_alt, color: Colors.green, size: 20),
//                     ),
//                 ],
//               ),
          
          
//           ],
//         ),
//       ),
//     );
//   }

//   void _showNotesDialog(BuildContext context, int index, ProductModel product) {
//     showDialog(
//       context: context,
//       builder: (context) => NotesAndImagesDialog(
//         productIndex: index,
//         product: product,
//       ),
//     );
//   }
// }