part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    // ignore: deprecated_member_use
    anonKey: AppSecrets.supabaseAnonKey,
  );

  Hive.init((await getApplicationDocumentsDirectory()).path);
  await Hive.openBox('blogs');

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => Hive.box('blogs'));
  
  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(serviceLocator()));
}

void _initAuth() {
  // DataSource
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(), 
      serviceLocator(),
      ),
  );

  // UseCases
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  serviceLocator.registerLazySingleton(() => UserLogout(serviceLocator()));

  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  // Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      userLogout: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  // UseCases
  serviceLocator.registerFactory(
    () => GetAllBlogs(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UploadBlog(
      serviceLocator(),
      ),
    );

  // Bloc
  serviceLocator.registerLazySingleton(
  () => BlogBloc(
    uploadBlog: serviceLocator<UploadBlog>(),
    getAllBlogs: serviceLocator<GetAllBlogs>(),
  ),
);
  
  // DataSource
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
    serviceLocator(),
  ));

  serviceLocator.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(
      serviceLocator(),
    ),
  );

// Repository
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
}
