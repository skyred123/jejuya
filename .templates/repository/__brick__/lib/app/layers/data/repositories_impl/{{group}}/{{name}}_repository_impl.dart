import 'package:jejuya/app/layers/domain/repositories/{{group}}/{{name}}_repository.dart';
import 'package:jejuya/core/arch/data/network/api_service_provider.dart';
import 'package:jejuya/core/local_storage/local_storage_provider.dart';

/// Implementation of the [{{name.pascalCase()}}Repository] interface.
class {{name.pascalCase()}}RepositoryImpl extends {{name.pascalCase()}}Repository
    with LocalStorageProvider, ApiServiceProvider {
}
