import 'package:dartz/dartz.dart';
import 'package:failure_stack/failure_stack.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
