import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_desgin_expert_task/controllers/order_provider.dart';
import 'package:media_desgin_expert_task/utilis/colors.dart';
import 'package:media_desgin_expert_task/utilis/images.dart';
import 'package:media_desgin_expert_task/view/submit_screen.dart';
import 'package:media_desgin_expert_task/widgets/note_book_sheet_widget.dart';
import 'package:provider/provider.dart';

// Add your shimmer import here if custom widget
import 'package:media_desgin_expert_task/widgets/shimmer_widget.dart';

class NotebookSheetUI extends StatefulWidget {
  const NotebookSheetUI({Key? key}) : super(key: key);

  @override
  State<NotebookSheetUI> createState() => _NotebookSheetUIState();
}

class _NotebookSheetUIState extends State<NotebookSheetUI> {
  final String orderNumber = "112096";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<OrderProvider>(context, listen: false).fetchProductData();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async{ 
          return await  Provider.of<OrderProvider>(context, listen: false).fetchProductData();
         },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              /// Top bar: menu + logo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: Image.asset(menuIcon, width: 35.w),
                      onPressed: () {},
                    ),
                    const Spacer(),
                    Image.asset(
                      applogo,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          'MediaDesignExpert',
                          style: TextStyle(
                            color: Colors.purple[800],
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 5),
        
              /// Arrow to Submit screen
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final provider = Provider.of<OrderProvider>(context, listen: false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubmitScreen(
                              orderNumber: orderNumber,
                              totalQuantity: provider.products.length.toString(),
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
        
              /// Order number text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Order # $orderNumber',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
        
              /// Product List
              Expanded(
                child: Consumer<OrderProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    if (value.isLoading) {
                      return ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ShimmerWidget.rectangular(
                            width: double.infinity,
                            height: 50.h,
                            verMargin: 6.0.h,
                            horMargin: 8.0.w,
                          );
                        },
                      );
                    } else if (value.products.isEmpty) {
                      return const Center(
                        child: Text(
                          "No product is found",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return NotebookSheet(apiData: value.products);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
