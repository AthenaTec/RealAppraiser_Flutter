import 'package:equatable/equatable.dart';

class FsTrackerEntity  extends Equatable{
  final int status;
  final dynamic data;
  final String msg;

  const FsTrackerEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status,data,msg];

}
