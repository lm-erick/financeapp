class Servico {
  Servico({required this.name, required this.convenioId, required this.value});

  Servico.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            convenioId: json['convenioId']! as String,
            value: json['value']! as num);

  final String name;
  final String convenioId;
  final num value;

  Map<String, Object?> toJson() {
    return {'name': name, 'convenioId': convenioId, 'value': value};
  }
}
