import 'package:agraseva/responseModel/GetNewsAndEventsListResponse.dart';
import 'package:agraseva/screen/social/newsEventDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/newsEventController.dart';
import '../../utils/constant.dart';

class NewAndEventScreen extends StatelessWidget {
   NewAndEventScreen({super.key});

  NewsEventController newsEventController = Get.find();


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         toolbarHeight: 70,
         centerTitle: true,
         backgroundColor: kRedColor,
         title: const Text(
           "News & Event",
           style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
               fontSize: 18),
         ),
         leading: IconButton(
           icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
           onPressed: () => Navigator.pop(context),
         ),
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
         ),
       ),

       body: Obx(() {
         if (newsEventController.isLoading.value) {
           return const Center(child: CircularProgressIndicator());
         }

         if (newsEventController.getNewsAndEventsListResponse.value?.result?.length==0) {
           return const Center(child: Text('No News Event Found'));
         }

         return ListView.builder(
           padding: const EdgeInsets.all(12),
           itemCount: newsEventController.getNewsAndEventsListResponse.value?.result?.length,
           itemBuilder: (context, index) {
             return _eventCard(newsEventController.getNewsAndEventsListResponse.value?.result?[index],context);
           },
         );
       }),
     );
   }

   Widget _eventCard(Result? result, BuildContext context) {
     return Card(
       margin: const EdgeInsets.only(bottom: 16),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(12),
       ),
       elevation: 4,
       clipBehavior: Clip.antiAlias,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           /// Event Image
           SizedBox(
             height: 200,
             width: double.infinity,
             child: Image.network(
               'https://www.agraseva.com/admin/news/${result?.image}',
               fit: BoxFit.cover,
               errorBuilder: (_, __, ___) => Container(
                 color: Colors.grey.shade300,
                 child: const Icon(Icons.image, size: 60),
               ),
             ),
           ),

           /// Event Details
           Padding(
             padding: const EdgeInsets.all(12),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   result?.title.toString()??'',
                   style: const TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                   ),
                 ),

                 const SizedBox(height: 8),

                 Text(
                   result?.details.toString()??'',
                   style: const TextStyle(
                     fontSize: 14,
                     color: Colors.black54,
                   ),
                 ),

                 const SizedBox(height: 12),

                 InkWell(
                   onTap: (){
                     newsEventController.getNewsAndEventResponseById(result?.newsId);
                     Navigator.push(context, MaterialPageRoute(builder:
                         (BuildContext context) => NewEventDetailScreen()));
                   },
                   child: const Text(
                     'READ MORE >',
                     style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.bold,
                       color: Colors.red,
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),
     );
   }

}
