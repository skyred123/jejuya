import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

/// {{name.sentenceCase()}} usecase
class {{name.pascalCase()}}UseCase
    extends BaseUseCase<{{name.pascalCase()}}Request, {{name.pascalCase()}}Response>
    with RepositoryProvider {
  /// Default constructor for the {{name.pascalCase()}}UseCase.
  {{name.pascalCase()}}UseCase();

  @override
  Future<{{name.pascalCase()}}Response> execute({{name.pascalCase()}}Request request) async {
    return {{name.pascalCase()}}Response();
  }
}

/// Request for the {{name.sentenceCase()}} usecase
class {{name.pascalCase()}}Request {
  /// Default constructor for the {{name.pascalCase()}}Request.
  {{name.pascalCase()}}Request();
}

/// Response for the {{name.sentenceCase()}} usecase
class {{name.pascalCase()}}Response {
  /// Default constructor for the {{name.pascalCase()}}Response.
  {{name.pascalCase()}}Response();
}
