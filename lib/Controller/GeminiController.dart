import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:news_app/Config/ApiKeys.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'dart:convert';

class GeminiController extends GetxController {
  RxBool geminiLoading = false.obs;

  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: geminiKey,
  );

  Future<String> getDescription(String query) async {
    try {
      final prompt = 'Describe the following news in 60-70 words: $query';
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text!;
    } on GenerativeAIException catch (e) {
      print('Content blocked due to safety concerns: $e');
      return 'The content could not be generated due to safety concerns.';
    } catch (e) {
      print('An error occurred: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  Future<String> getMoreInfo(String query) async {
    try {
      final prompt = 'Describe the following news in detail: $query';
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text!;
    } on GenerativeAIException catch (e) {
      print('Content blocked due to safety concerns: $e');
      return 'The content could not be generated due to safety concerns.';
    } catch (e) {
      print('An error occurred: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  Future<String> getSearchResult(List<NewsModel> newsList) async {
    try {
      geminiLoading.value = true;

      // Convert the list of news items to a JSON string
      final newsJson = jsonEncode(newsList.map((news) => news.toJson()).toList());
      final prompt = 'Provide a brief summary from the following news articles: $newsJson';

      final response = await model.generateContent([Content.text(prompt)]);
      geminiLoading.value = false;

      return response.text!;
    } on GenerativeAIException catch (e) {
      print('Content blocked due to safety concerns: $e');
      geminiLoading.value = false;
      return 'The content could not be generated due to safety concerns.';
    } catch (e) {
      print('An error occurred: $e');
      geminiLoading.value = false;
      return 'An unexpected error occurred. Please try again.';
    }
  }

  Future<String> getHighlight(List<NewsModel> newsList) async {
    try {
      geminiLoading.value = true;

      // Convert the list of news items to a JSON string
      final newsJson = jsonEncode(newsList.map((news) => news.toJson()).toList());
      final prompt = 'Provide a brief highlight from the following news articles: $newsJson';

      final response = await model.generateContent([Content.text(prompt)]);
      geminiLoading.value = false;

      return response.text!;
    } on GenerativeAIException catch (e) {
      print('Content blocked due to safety concerns: $e');
      geminiLoading.value = false;
      return 'The content could not be generated due to safety concerns.';
    } catch (e) {
      print('An error occurred: $e');
      geminiLoading.value = false;
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
