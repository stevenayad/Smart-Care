class MedicalAssistantChatData {
	String? ingredient;
	String? question;
	String? answer;

	MedicalAssistantChatData({this.ingredient, this.question, this.answer});

	factory MedicalAssistantChatData.fromJson(Map<String, dynamic> json) => MedicalAssistantChatData(
				ingredient: json['ingredient'] as String?,
				question: json['question'] as String?,
				answer: json['answer'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'ingredient': ingredient,
				'question': question,
				'answer': answer,
			};
}
