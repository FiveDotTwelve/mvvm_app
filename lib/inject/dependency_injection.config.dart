// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../factory/view_model_factory.dart' as _i4;
import '../repository/todo_repository.dart' as _i3;
import '../screen/create/create_todo_view_model.dart' as _i5;
import '../screen/home/home_view_model.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.TodoRepository>(_i3.TodoRepository());
  gh.singleton<_i4.ViewModelFactory>(_i4.ViewModelFactoryImpl());
  gh.factory<_i5.CreateTodoViewModel>(
      () => _i5.CreateTodoViewModel(get<_i3.TodoRepository>()));
  gh.factory<_i6.HomeViewModel>(
      () => _i6.HomeViewModel(get<_i3.TodoRepository>()));
  return get;
}
