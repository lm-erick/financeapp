class Cliente {
  Cliente(
      {required this.name,
      required this.email,
      required this.phone,
      required this.celphone,
      required this.document,
      required this.convenioId});

  Cliente.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          email: json['email']! as String,
          phone: json['phone']! as String,
          celphone: json['cel_phone']! as String,
          document: json['document']! as String,
          convenioId: json['convenioId']! as String,
        );

  final String name;
  final String email;
  final String phone;
  final String celphone;
  final String document;
  final String convenioId;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'celphone': celphone,
      'document': document,
      'convenioId': convenioId
    };
  }
}
