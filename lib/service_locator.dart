import 'package:get_it/get_it.dart';
import 'package:todo_app/features/auth/auth_di.dart';
import 'package:todo_app/features/crud/crud_di.dart';

class ServiceLocator {
  ServiceLocator._();

  static GetIt getIt = GetIt.instance;
}

Future<void> setupServiceLocator() async {
  await CrudeDi().setup();
  await AuthDi().setup();
}
