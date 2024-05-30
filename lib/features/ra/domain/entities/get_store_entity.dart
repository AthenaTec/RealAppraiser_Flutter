import 'package:equatable/equatable.dart';

class GetStoreEntity extends Equatable {
  final int status;
  final String data;
  final String msg;

  const GetStoreEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}
