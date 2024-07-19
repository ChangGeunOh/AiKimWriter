import 'package:aikimwriter/data/database/database_source_impl.dart';
import 'package:aikimwriter/domain/usecase/splash_case.dart';
import 'package:aikimwriter/domain/usecase/use_cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

Future<void> main() async {
  runApp(const MyApp());
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
