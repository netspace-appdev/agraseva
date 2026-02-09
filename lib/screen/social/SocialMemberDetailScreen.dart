import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/socialMemberSignUpController.dart';
import '../../utils/constant.dart';

class SocialMemberDetailScreen extends StatelessWidget {
  SocialMemberDetailScreen({super.key});

  final SocialMemberSignupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: kRedColor,
        title: const Text(
          "Social Member Detail",
          style: TextStyle(color: Colors.white, fontSize: 18),
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
        final member = controller.getSocialListResponse.value?.result?.isNotEmpty == true
            ? controller.getSocialListResponse.value!.result![0]
            : null;

        if (member == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [

              /// 🔹 PROFILE IMAGE

              /// 🔹 DETAILS CARD
              Container(
                transform: Matrix4.translationValues(0, -20, 0),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: AspectRatio(
                              aspectRatio: 16 / 9, // 👈 looks best for profile / banner images
                              child: Image.network(
                                '${Constant.base_url}/${member.profilePhoto}',
                                fit: BoxFit.contain,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  );
                                },
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.person, size: 80, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /// GRADIENT
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),

                        /// ID BADGE
                        Positioned(
                          bottom: 20,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: kRedColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "ID: ASSM${member.id}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// NAME
                    const SizedBox(height: 10),

                    _info("Name", member.name),
                    _info("Mobile", member.mobileNumber),
                    _info("DOB", member.dOB),
                    _info("Address", member.address),
                    _info("Job Type", member.jobType),
                    _info("Job Details", member.jobDetails),
                    _info("City", member.cityName),
                    _info("State", member.stateName),

                    const SizedBox(height: 20),

                    /// ACTION BUTTONS
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _info(String label, String? value) {
    if (value == null || value.isEmpty || value == "null") {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              "$label :",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: kTextGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
