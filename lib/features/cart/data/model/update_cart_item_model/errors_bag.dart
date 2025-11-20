class ErrorsBag {
  List<String>? additionalProp1;
  List<String>? additionalProp2;
  List<String>? additionalProp3;

  ErrorsBag({this.additionalProp1, this.additionalProp2, this.additionalProp3});

  factory ErrorsBag.fromJson(Map<String, dynamic> json) => ErrorsBag(
    additionalProp1: json['additionalProp1'] as List<String>?,
    additionalProp2: json['additionalProp2'] as List<String>?,
    additionalProp3: json['additionalProp3'] as List<String>?,
  );

  Map<String, dynamic> toJson() => {
    'additionalProp1': additionalProp1,
    'additionalProp2': additionalProp2,
    'additionalProp3': additionalProp3,
  };
}
