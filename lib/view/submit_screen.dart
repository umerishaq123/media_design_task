import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_desgin_expert_task/controllers/order_provider.dart';
import 'package:media_desgin_expert_task/utilis/colors.dart';
import 'package:media_desgin_expert_task/utilis/images.dart';
import 'package:media_desgin_expert_task/widgets/custom_buttom_widget.dart';
import 'package:media_desgin_expert_task/widgets/order_settings_row_widget.dart';
import 'package:provider/provider.dart';

class SubmitScreen extends StatelessWidget {
  final String orderNumber;
  final String totalQuantity;
  const SubmitScreen({super.key,required this.orderNumber,required this.totalQuantity});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<OrderProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          Center(
            child:        Image.asset(
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
                 
          ),
       
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,size: 25,color: greyColor,)),
          ),
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               OrderSettingsRowWidget(title: "Order#", detail: orderNumber),
                 SizedBox(height: 20,),
                OrderSettingsRowWidget(title: "Order name", detail: "Joe’s catering"),
                SizedBox(height: 20,),
                OrderSettingsRowWidget(title: "Delivery date", detail: "May 4th 2024"),
                SizedBox(height: 20,),
                Consumer<OrderProvider>(builder: (context,value,child){
                  return                 OrderSettingsRowWidget(title: "Total quantity", detail: value.products.length.toString(),ischngeColor: true,);

                }),
                SizedBox(height: 20,),
                OrderSettingsRowWidget(title: "Estimated total", detail: "\$1402.96",ischngeColor: true,),
                       SizedBox(height: 20,),
                OrderSettingsRowWidget(title: "Location", detail: "355 onderdonk st Marina Dubai, UAE",ischngeColor: true,islocation: true,),
                    SizedBox(height: 20,),
                    Text("Delivery instructions ...",style: GoogleFonts.publicSans(fontSize: 14.sp,
                    fontWeight: FontWeight.w600),),

                        SizedBox(height: 10,),
   
                        CustomElevatedButton(label: "Submitt", width: double.infinity, height: 60.h, radius: 15.r, onTap: (){}, paddingTop: 10, bgColor: greyColor, labelColor: whiteColor)

,SizedBox(height: 5,),
TextButton(onPressed: (){

}, child: Text("Save as draft",
 style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: greyColor,
            ),))
              ],
            ),
          )
     
        ],
      ),
    );
  }
}