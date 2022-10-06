class Convenio {
  Convenio({required this.name, required this.cnpj});

  Convenio.fromJson(Map<String, Object?> json)
      : this(name: json['name']! as String, cnpj: json['cnpj']! as String);

  final String name;
  final String cnpj;

  Map<String, Object?> toJson() {
    return {'name': name, 'cnpj': cnpj};
  }
}
