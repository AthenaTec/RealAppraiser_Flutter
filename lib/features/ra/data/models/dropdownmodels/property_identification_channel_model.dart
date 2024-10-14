class PropertyIdentificationChannel {
  int? propertyIdentificationChannelId;
  String? name;
  String? createdOn;
  int? createdBy;
  String? modifiedOn;
  int? modifiedBy;
  bool? isActive;

  PropertyIdentificationChannel({
    this.propertyIdentificationChannelId,
    this.name,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
    this.isActive,
  });

  // Factory method to create an instance from a JSON map
  factory PropertyIdentificationChannel.fromJson(Map<String, dynamic> json) {
    return PropertyIdentificationChannel(
      propertyIdentificationChannelId: json['PropertyIdentificationChannelId'],
      name: json['Name'],
      createdOn: json['CreatedOn'],
      createdBy: json['CreatedBy'],
      modifiedOn: json['ModifiedOn'],
      modifiedBy: json['ModifiedBy'],
      isActive: json['IsActive'],
    );
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'PropertyIdentificationChannelId': propertyIdentificationChannelId,
      'Name': name,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
    };
  }
}
