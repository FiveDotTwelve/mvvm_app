import 'package:injectable/injectable.dart';
import 'package:mvvm/inject/dependency_injection.dart';
import 'package:mvvm/view_model/view_model.dart';

abstract class ViewModelFactory {
  T create<T extends ViewModel>();
}

@Singleton(as: ViewModelFactory)
class ViewModelFactoryImpl implements ViewModelFactory {
  @override
  T create<T extends ViewModel>() => getIt.get<T>();
}
