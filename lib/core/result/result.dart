import 'package:fpdart/fpdart.dart';

typedef Result<T> = Either<Object, T>;
typedef ResultFuture<T> = TaskEither<Object, T>;
