import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/newsEventController.dart';
import '../../responseModel/GetNewsAndEventsListResponse.dart';
import '../../utils/constant.dart';

class NewEventDetailScreen extends StatelessWidget {
   NewEventDetailScreen({super.key});

  NewsEventController newsEventController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: kRedColor,
        title: const Text(
          "News & Event Detail",
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

        return  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Hero Image
                const SizedBox(height: 5),

                /// 🔹 Title Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    newsEventController.getNewsAndEventsListResponse.value?.result?[0]
                        .title ??
                        '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    children: [
                      Image.network(
                        'https://www.agraseva.com/admin/news/${newsEventController.getNewsAndEventsListResponse.value?.result?[0].image}',
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 220,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: const Icon(Icons.image, size: 60),
                        ),
                      ),

                      /// Gradient overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),

                      /// Upcoming badge
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: kRedColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Upcoming",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



                const SizedBox(height: 16),

                /// 🔹 Details Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsEventController.getNewsAndEventsListResponse.value?.result?[0]
                            .details ??
                            '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );


      }),
    );
  }

}
