import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/http/chat_bot_socket.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/breff_controller.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';

import '../models/chat_model.dart';

class ChatScreenController extends GetxController {
  final BreffController breffController = Get.put(BreffController());

  List<ChatModel> geminiChatDataList = [];

  bool isChatLoading = false;

  sendText({required String sendData}) {
    // final gemini = Gemini.instance;

    geminiChatDataList.add(ChatModel(isUser: true, contentName: sendData));
    isChatLoading = true;

    ChatbotSocket.sendBotQuestion(sendData);

    //     .then((value) {
    // // gemini.text(sendData).then((value) {
    //   print(value?.output);
    //
    //   geminiChatDataList
    //       .add(ChatModel(isUser: false, message: ss));
    //   isChatLoading = false;
    //   update();
    // }).catchError((e) => print(e));

    breffController.askanythingoneController.clear();

    update();
  }

  setMessage(ChatModel chatModel){

    if(geminiChatDataList.indexWhere((element)=> (element.id??0)==chatModel.id)==-1) {
      geminiChatDataList
          .add(chatModel);
    }else{
      print("duplicate chat"+chatModel.contentName!);
    }
    isChatLoading = false;

    breffController.askanythingoneController.clear();

    update();
  }
  clearBotHistory(){

    geminiChatDataList=[];

    breffController.askanythingoneController.clear();

    update();
  }
}
