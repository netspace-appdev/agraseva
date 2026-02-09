import 'package:agraseva/responseModel/GetNewsAndEventsListResponse.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../helper.dart';
import '../service/socialRegister.dart';

class NewsEventController extends GetxController {

  var getNewsAndEventsListResponse = Rxn<GetNewsAndEventsListResponse>(); //
  var isLoading=true.obs;


  Future <void> getNewsAndEventResponse() async {
    try {
      isLoading(true);

      var data = await SocialRegister.getNewsAndEventApi();
      getNewsAndEventsListResponse.value = GetNewsAndEventsListResponse.fromJson(data);

      if (getNewsAndEventsListResponse.value?.responseCode== 200) {
        isLoading(false);

      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in updateBankerDetailApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }

  }

  Future <void> getNewsAndEventResponseById(String? id) async {
    try {
      isLoading(true);

      var data = await SocialRegister.getNewsAndEventByIdApi(id!);
      getNewsAndEventsListResponse.value = GetNewsAndEventsListResponse.fromJson(data);

      if (getNewsAndEventsListResponse.value?.responseCode== 200) {
        isLoading(false);

      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in updateBankerDetailApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }

  }

}