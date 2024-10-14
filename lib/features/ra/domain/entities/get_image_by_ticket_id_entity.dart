import 'package:equatable/equatable.dart';

class GetImageByTicketIdEntity extends Equatable {
  final int status;
  final List<Datum> data;
  final String msg;

  const GetImageByTicketIdEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class Datum extends Equatable {
  final int id;
  final int ticketId;
  final String filePath;
  final String image;
  final String fileName;

  const Datum({
    required this.id,
    required this.ticketId,
    required this.filePath,
    required this.image,
    required this.fileName,
  });

  @override
  List<Object?> get props => [id, ticketId, filePath, image, fileName];
}
