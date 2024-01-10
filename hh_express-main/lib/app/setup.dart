import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'setup.config.dart';

final getIt = GetIt.instance;

// @InjectableInit()
// GetIt configureDependencies(GetIt getIt) => $initGetIt(getIt);

@InjectableInit()
GetIt configureDependencies(GetIt getIt) => getIt.init();
