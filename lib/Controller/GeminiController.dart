import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:news_app/Config/ApiKeys.dart';

class GeminiController extends GetxController {
  //RxBool isLoading=false.obs;
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: geminiKey,
  );
  Future<String> getDescription(String query) async {
    //isLoading.value = true;
    try {
      final prompt = 'Describe the following news in 60-70 words: $query';
      final response = await model.generateContent([Content.text(prompt)]);
      print(response.text);
      //isLoading.value = false;
      return response.text!; // This may throw an exception if the content is blocked
    } on GenerativeAIException catch (e) {
      // Handle the safety block exception here
      print('Content blocked due to safety concerns: $e');
      //isLoading.value = false;
      return 'The content could not be generated due to safety concerns.';
    } catch (e) {
      // Handle other exceptions here
      print('An error occurred: $e');
      //isLoading.value = false;
      return 'An unexpected error occurred. Please try again.';
    }
  }

  Future<String> getMoreInfo(String query) async {
    //isLoading.value = true;
    try {
      final prompt = 'Describe the following news in detail: $query';
      final response = await model.generateContent([Content.text(prompt)]);
      print(response.text);
      //isLoading.value = false;
      return response.text!; // This may throw an exception if the content is blocked
    } on GenerativeAIException catch (e) {
      // Handle the safety block exception here
      print('Content blocked due to safety concerns: $e');
      //isLoading.value = false;
      return 'The content could not be generated due to safety concerns.';
    } catch (e) {
      // Handle other exceptions here
      print('An error occurred: $e');
      //isLoading.value = false;
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
