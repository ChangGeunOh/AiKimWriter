import 'package:aikimwriter/data/database/database_source_impl.dart';
import 'package:aikimwriter/domain/usecase/splash_case.dart';
import 'package:aikimwriter/domain/usecase/use_cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'common/const/color.dart';
import 'common/const/network.dart';
import 'common/router/router.dart';
import 'data/database/local_database.dart';
import 'data/datastore/local_data_store.dart';
import 'data/network/custom_interceptor.dart';
import 'data/network/local_network.dart';
import 'data/datastore/datastore_source_impl.dart';
import 'data/network/network_source_impl.dart';
import 'data/repository/repository.dart';
import 'domain/usecase/gallery_case.dart';
import 'domain/usecase/story_case.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  print('API_KEY: ${dotenv.env['GOOGLE_API_KEY']}');
  runApp(const MyApp());


  Future<void> sendMultipartRequest() async {
    final url = Uri.parse('https://team10-api.azurewebsites.net/api/travel/summary/pictures/async?code=C79kRLGqSxxEmjdevTpETK7HlMUfR7cayozj_ltFUyWMAzFupHr1-A%3D%3D');

    var request = http.MultipartRequest('POST', url)
      ..fields['desc'] = '{"meta":{"theme":"나홀로 여행","vibe":"","days":"2145/2146","dataType":"image"},"datas":[]}';
    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Request sent successfully');
        final responseData = await http.Response.fromStream(response);
        print('Response data: ${responseData.body}');
      } else {
        print('Failed to send request: ${response.statusCode}');
        final responseData = await http.Response.fromStream(response);
        print('Response data: ${responseData.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  await sendMultipartRequest();
}

final rootScaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) {
        final DatabaseSourceImpl  databaseSourceImpl = DatabaseSourceImpl(
          localDatabase: LocalDatabase(),
        );

        final DataStoreSourceImpl dataStoreSourceImpl = DataStoreSourceImpl(
          dataStore: LocalDataStore(),
        );

        final customInterceptor = CustomInterceptor(
          dataStoreSource: dataStoreSourceImpl,
          context: context,
        );

        final LocalNetwork localNetwork = LocalNetwork(customInterceptor);
        final NetworkSourceImpl networkSourceImpl = NetworkSourceImpl(
          localNetwork.dio,
          baseUrl: kNetworkBaseUrl,
        );

        final repository = Repository(
          dataBaseSource: databaseSourceImpl,
          networkSource: networkSourceImpl,
          dataStoreSource: dataStoreSourceImpl,
        );

        return UseCases(
          splashCase: SplashCase(repository: repository),
          galleryCase: GalleryCase(repository: repository),
          storyCase: StoryCase(repository: repository),
        );
      },
      child: MaterialApp.router(
        title: 'AI 김작가',
        scaffoldMessengerKey: rootScaffoldKey,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          primaryColor: primaryColor,
          fontFamily: 'NotoSansKR',
          tabBarTheme: const TabBarTheme(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSansKR',
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: blueGrayColor,
              minimumSize: const Size(double.infinity, 42),
            ),
          ),
          inputDecorationTheme:  InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            hintStyle: TextStyle(
              color: blueGrayColor.withOpacity(0.2),
            ),
            labelStyle: const TextStyle(
              color: blueGrayColor,
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: blueGrayColor,
                width: 1,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: blueGrayColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: blueGrayColor,
                width: 1,
              ),
            ),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.grey,
          ),
        ),
        routerConfig: routerConfig,
      ),
    );
  }



}
