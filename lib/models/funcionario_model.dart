class Funcionario {
  Funcionario(
      {required this.name,
      required this.email,
      required this.phone,
      required this.celphone,
      required this.document});

  Funcionario.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          email: json['email']! as String,
          phone: json['phone']! as String,
          celphone: json['cel_phone']! as String,
          document: json['document']! as String,
        );

  final String name;
  final String email;
  final String phone;
  final String celphone;
  final String document;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'celphone': celphone,
      'document': document,
    };
  }
}
