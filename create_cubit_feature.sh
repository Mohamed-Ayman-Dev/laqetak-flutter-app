#!/bin/bash
FEATURE=$1
FEATURE_PASCAL=$(python3 -c "print(''.join(w.capitalize() for w in '${FEATURE}'.split('_')))")
BASE="lib/src/features/$FEATURE"
PACKAGE="invastro"

mkdir -p $BASE/data/datasources
mkdir -p $BASE/data/models
mkdir -p $BASE/data/repositories
mkdir -p $BASE/domain/entities
mkdir -p $BASE/domain/repositories
mkdir -p $BASE/domain/usecases
mkdir -p $BASE/presentation/cubit
mkdir -p $BASE/presentation/screens
mkdir -p $BASE/presentation/widgets

# ─── Model ───────────────────────────────────────────────
cat > $BASE/data/models/${FEATURE}_model.dart << EOF
import 'package:equatable/equatable.dart';

class ${FEATURE_PASCAL}Model extends Equatable {
  const ${FEATURE_PASCAL}Model({
    this.id,
    this.name,
  });

  factory ${FEATURE_PASCAL}Model.fromJson(dynamic json) {
    return ${FEATURE_PASCAL}Model(
      id: json['id'],
      name: json['name'],
    );
  }

  final num? id;
  final String? name;

  ${FEATURE_PASCAL}Model copyWith({
    num? id,
    String? name,
  }) => ${FEATURE_PASCAL}Model(
    id: id ?? this.id,
    name: name ?? this.name,
  );

  @override
  List<Object?> get props => [id, name];
}
EOF

# ─── Remote Data Source ──────────────────────────────────
cat > $BASE/data/datasources/${FEATURE}_remote_data_source.dart << EOF
import '../models/${FEATURE}_model.dart';

abstract class ${FEATURE_PASCAL}RemoteDataSource {
  Future<List<${FEATURE_PASCAL}Model>> get${FEATURE_PASCAL}s();
  Future<String?> add${FEATURE_PASCAL}(Map<String, dynamic> data);

}
EOF

# ─── Remote Data Source Impl ─────────────────────────────
cat > $BASE/data/datasources/${FEATURE}_remote_data_source_impl.dart << EOF
import 'package:${PACKAGE}/src/core/network/api_service.dart';
import 'package:${PACKAGE}/src/core/network/end_points.dart';
import '../models/${FEATURE}_model.dart';
import '${FEATURE}_remote_data_source.dart';

class ${FEATURE_PASCAL}RemoteDataSourceImpl implements ${FEATURE_PASCAL}RemoteDataSource {
  final ApiRemoteService _apiService;

  ${FEATURE_PASCAL}RemoteDataSourceImpl(this._apiService);

  @override
  Future<List<${FEATURE_PASCAL}Model>> get${FEATURE_PASCAL}s() async {
    final response = await _apiService.get("EndPoints.get${FEATURE_PASCAL}s");
    return response.dataOrThrow(
      (data) => data['data']
          .map<${FEATURE_PASCAL}Model>((e) => ${FEATURE_PASCAL}Model.fromJson(e))
          .toList(),
    );
  }
  @override
  Future<String?> add${FEATURE_PASCAL}(Map<String, dynamic> data) async {
    final response = await _apiService.post("EndPoints.add${FEATURE_PASCAL}s", data: data);
    return response.dataOrThrow((data) => data['message']);
  }
}
EOF

# ─── Repository Interface ─────────────────────────────────
cat > $BASE/domain/repositories/${FEATURE}_repository.dart << EOF
import 'package:${PACKAGE}/src/core/network/api_result.dart';
import '../../data/models/${FEATURE}_model.dart';

abstract class ${FEATURE_PASCAL}Repository {
//  Future<ApiResult<List<${FEATURE_PASCAL}Model>>> get${FEATURE_PASCAL}s();
//  Future<ApiResult<String>> add${FEATURE_PASCAL}(Map<String, dynamic> data);
}
EOF

# ─── Repository Impl ─────────────────────────────────────
cat > $BASE/data/repositories/${FEATURE}_repository_impl.dart << EOF
import 'package:${PACKAGE}/src/core/error/api_exception.dart';
import 'package:${PACKAGE}/src/core/network/api_result.dart';
import 'package:${PACKAGE}/generated/l10n.dart';
import '../datasources/${FEATURE}_remote_data_source.dart';
import '../models/${FEATURE}_model.dart';
import '../../domain/repositories/${FEATURE}_repository.dart';

class ${FEATURE_PASCAL}RepositoryImpl implements ${FEATURE_PASCAL}Repository {
  final ${FEATURE_PASCAL}RemoteDataSource _remoteDataSource;

  ${FEATURE_PASCAL}RepositoryImpl(this._remoteDataSource);

//  @override
//  Future<ApiResult<List<${FEATURE_PASCAL}Model>>> get${FEATURE_PASCAL}s() async {
//    try {
//      final models = await _remoteDataSource.get${FEATURE_PASCAL}s();
//     return ApiResult.success(models);
//    } catch (e) {
//      return ApiResult.failure(
//       e is ApiException ? e : ApiException(message: e.toString()),
//     );
//    }
//  }

//  @override
//  Future<ApiResult<String>> add${FEATURE_PASCAL}(Map<String, dynamic> data) async {
//    try {
//      // TODO: implement add${FEATURE_PASCAL}
//      return ApiResult.success(S.current.successMessage);
//    } catch (e) {
//      return ApiResult.failure(
//        e is ApiException ? e : ApiException(message: e.toString()),
//      );
//    }
//  }
}
EOF

# ─── Get UseCase ─────────────────────────────────────────
cat > $BASE/domain/usecases/get_${FEATURE}s_use_case.dart << EOF
import 'package:${PACKAGE}/src/core/network/api_result.dart';
import '../repositories/${FEATURE}_repository.dart';
import '../../data/models/${FEATURE}_model.dart';

class Get${FEATURE_PASCAL}sUseCase {
  final ${FEATURE_PASCAL}Repository _repository;

  Get${FEATURE_PASCAL}sUseCase(this._repository);

//  Future<ApiResult<List<${FEATURE_PASCAL}Model>>> call() {
//     return _repository.get${FEATURE_PASCAL}s();
//   }
}
EOF

# ─── Add UseCase ─────────────────────────────────────────
cat > $BASE/domain/usecases/add_${FEATURE}_use_case.dart << EOF
import 'package:${PACKAGE}/src/core/network/api_result.dart';
import '../repositories/${FEATURE}_repository.dart';

class Add${FEATURE_PASCAL}UseCase {
  final ${FEATURE_PASCAL}Repository _repository;

  Add${FEATURE_PASCAL}UseCase(this._repository);

//   Future<ApiResult<String>> call(Map<String, dynamic> data) {
//     return _repository.add${FEATURE_PASCAL}(data);
//   }
}
EOF

# ─── State ───────────────────────────────────────────────
cat > $BASE/presentation/cubit/${FEATURE}_state.dart << EOF
import 'package:equatable/equatable.dart';
import '../../data/models/${FEATURE}_model.dart';

sealed class ${FEATURE_PASCAL}State extends Equatable {
  const ${FEATURE_PASCAL}State();
}

class ${FEATURE_PASCAL}Initial extends ${FEATURE_PASCAL}State {
  const ${FEATURE_PASCAL}Initial();

  @override
  List<Object?> get props => [];
}

class ${FEATURE_PASCAL}Loading extends ${FEATURE_PASCAL}State {
  final String? message;

  const ${FEATURE_PASCAL}Loading({this.message});

  @override
  List<Object?> get props => [message];
}

class ${FEATURE_PASCAL}Loaded extends ${FEATURE_PASCAL}State {
  final List<${FEATURE_PASCAL}Model> items;

  const ${FEATURE_PASCAL}Loaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ${FEATURE_PASCAL}ActionSuccess extends ${FEATURE_PASCAL}State {
  final String message;
  final String? desc;

  const ${FEATURE_PASCAL}ActionSuccess({required this.message, this.desc});

  @override
  List<Object?> get props => [message];
}

class ${FEATURE_PASCAL}Error extends ${FEATURE_PASCAL}State {
  final String error;

  const ${FEATURE_PASCAL}Error(this.error);

  @override
  List<Object?> get props => [error];
}
EOF

# ─── Cubit ───────────────────────────────────────────────
cat > $BASE/presentation/cubit/${FEATURE}_cubit.dart << EOF
import 'package:${PACKAGE}/src/core/bloc_helpers/base_cubit.dart';
import 'package:${PACKAGE}/generated/l10n.dart';
import '../../data/models/${FEATURE}_model.dart';
import '../../domain/usecases/add_${FEATURE}_use_case.dart';
import '../../domain/usecases/get_${FEATURE}s_use_case.dart';
import '${FEATURE}_state.dart';

class ${FEATURE_PASCAL}Cubit extends BaseCubit<${FEATURE_PASCAL}State> {
  final Add${FEATURE_PASCAL}UseCase _add${FEATURE_PASCAL}UseCase;
  final Get${FEATURE_PASCAL}sUseCase _get${FEATURE_PASCAL}sUseCase;

  ${FEATURE_PASCAL}Cubit(
    this._add${FEATURE_PASCAL}UseCase,
    this._get${FEATURE_PASCAL}sUseCase,
  ) : super(const ${FEATURE_PASCAL}Initial());

//  List<${FEATURE_PASCAL}Model> _items = [];

//  Future<void> get${FEATURE_PASCAL}s() async {
//    try {
//      final result = await _get${FEATURE_PASCAL}sUseCase();
//      result.whenOrThrowError(
//        success: (items) {
//          _items = items;
//          emit(${FEATURE_PASCAL}Loaded(_items));
//        },
//      );
//    } catch (e) {
//      handleError(e, (message) {
//        emit(${FEATURE_PASCAL}Error(message));
//      });
//    }
//  }

//  Future<void> add${FEATURE_PASCAL}(Map<String, dynamic> data) async {
//    try {
//      emit(${FEATURE_PASCAL}Loading(message: S.current.loading));
//      final result = await _add${FEATURE_PASCAL}UseCase(data);
//      result.whenOrThrowError(
//        success: (message) async {
//          emit(
//            ${FEATURE_PASCAL}ActionSuccess(
//              message: message,
//              desc: S.current.successMessage,
//            ),
//          );
//          await get${FEATURE_PASCAL}s();
//        },
//      );
//    } catch (e) {
//      handleError(e, (message) {
//        emit(${FEATURE_PASCAL}Error(message));
//      });
//    }
//  }
}
EOF
# ─── Screen ──────────────────────────────────────────────
cat > $BASE/presentation/screens/${FEATURE}_screen.dart << EOF
import 'package:flutter/material.dart';

class ${FEATURE_PASCAL}Screen extends StatelessWidget {
  static const routeName = '/${FEATURE}_screen';

  const ${FEATURE_PASCAL}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: []));
  }
}
EOF
# ─── DI ──────────────────────────────────────────────────
cat > $BASE/${FEATURE}_di.dart << EOF
// import 'package:${PACKAGE}/features/${FEATURE}/data/datasources/${FEATURE}_remote_data_source.dart';
// import 'package:${PACKAGE}/features/${FEATURE}/data/datasources/${FEATURE}_remote_data_source_impl.dart';
// import 'package:${PACKAGE}/features/${FEATURE}/data/repositories/${FEATURE}_repository_impl.dart';
// import 'package:${PACKAGE}/features/${FEATURE}/domain/repositories/${FEATURE}_repository.dart';
// import 'package:${PACKAGE}/features/${FEATURE}/domain/usecases/add_${FEATURE}_use_case.dart';
// import 'package:${PACKAGE}/features/${FEATURE}/domain/usecases/get_${FEATURE}s_use_case.dart';
// import 'package:${PACKAGE}/features/${FEATURE}/presentation/cubit/${FEATURE}_cubit.dart';
// import '../../src/core/di/locator.dart';

// class ${FEATURE_PASCAL}DI {
//   static void init() {
//     /// ---------------- Data Sources ----------------
//     sl.registerLazySingleton<${FEATURE_PASCAL}RemoteDataSource>(
//       () => ${FEATURE_PASCAL}RemoteDataSourceImpl(sl()),
//     );

//     /// ---------------- Repositories ----------------
//     sl.registerLazySingleton<${FEATURE_PASCAL}Repository>(
//       () => ${FEATURE_PASCAL}RepositoryImpl(sl()),
//     );

//     /// ---------------- UseCases ----------------
//     sl.registerLazySingleton<Get${FEATURE_PASCAL}sUseCase>(
//       () => Get${FEATURE_PASCAL}sUseCase(sl()),
//     );
//     sl.registerLazySingleton<Add${FEATURE_PASCAL}UseCase>(
//       () => Add${FEATURE_PASCAL}UseCase(sl()),
//     );

//     /// ---------------- Cubit ----------------
//     sl.registerFactory<${FEATURE_PASCAL}Cubit>(
//       () => ${FEATURE_PASCAL}Cubit(sl(), sl()),
//     );
//   }
// }
EOF
echo "✅ Feature '${FEATURE_PASCAL}' created with full boilerplate!"
echo "🔴 Don't forget to update PACKAGE name in the script and register DI in ${FEATURE}_di.dart"