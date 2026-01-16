import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_authentication_repository.dart';

// 1. What does the class depend on
// Answer: AuthenticationRepository
// 2. How can we create a fake version of the dependency
// Answer: Use Mocktail
// 3. How do we control what our dependencies do
// Answer: using the Mocktail's APIs

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  /* setUp roda antes de cada teste.
  Cria o mock e o caso de uso que será testado. */
  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository: repository);
  });

  // Cria parâmetros padrão para o teste.
  const params = CreateUserParams.empty();

  test('should call [AuthRepo.createUser]', () async {
    // 1. Arrange - what we need to work (preparacao)
    /*
    - Diz ao mock o que fazer quando o método createUser for chamado.
    - Aqui, ele vai retornar Right(null), que significa sucesso (sem erro).
    - Use when para dizer ao mock o que ele deve fazer.
    - Purpose: Sets up the mock’s behavior.
    - any(named: ...) means: “Whenever createUser is called with any value for
      these parameters, return Right(null).”
    - It’s flexible: it doesn’t care what values are passed, just that the method is called.
    */
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null)); // null -> void

    // 2. Act | Ação (executa o que quer testar)
    final result = await usecase(params);

    // 3. Assert | Verificação (confirma se funcionou como esperado)
    // Use expect para verificar o resultado.
    // dynamic because I dont need the left value (Failure). put dynamic where you dont need the value
    expect(result, equals(const Right<dynamic, void>(null)));

    // Verifica se o resultado foi sucesso.
    // Use verify para garantir que métodos foram chamados corretamente.
    // Confirma que o método foi chamado com os parâmetros certos, uma vez.
    /*
    - Purpose: Checks that the method was called with specific values.
    - params.createdAt, params.name, etc. means: “Check that createUser was called exactly with these values.”
    - It’s strict: it only passes if the method was called with the exact values you expect
    */
    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);

    // Garante que nenhum outro método do mock foi chamado.
    verifyNoMoreInteractions(repository);
  });
}
