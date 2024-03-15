
import 'package:dio/dio.dart';
const String baseUrl = 'https://ifbdbzawjrqdxbuojwbk.supabase.co/rest/v1/';
const String apiKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlmYmRiemF3anJxZHhidW9qd2JrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0NTA0NTYsImV4cCI6MjAyNjAyNjQ1Nn0.9OYh7N0O165GoxhaVJfRvJ_YVK2TzWe37gMvJZ7boCQ';

final httpClient =
    Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          //final authInfo = AuthRepository.authChangeNotifier.value;
          //if (authInfo != null && authInfo.accessTocken.isNotEmpty) {
            options.headers['Authorization'] =
            'Bearer $apiKey';
            options.headers['apikey'] = apiKey;
          //}
          handler.next(options);
        },
      ));