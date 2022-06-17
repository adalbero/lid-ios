package com.lebenindeutschland.app.test;

import com.lebenindeutschland.app.model.LidContext;

public class AppQuestionListRandom extends AppQuestionList {
	private int size;

	public AppQuestionListRandom(LidContext context, String bundesland, int size) {
		this.size = size;
		this.questions = size == 0 ? context.getQuestionDB().selectQuestionsByRandomTest(bundesland, 30, 3)
				: context.getQuestionDB().selectQuestionsByRandomExercise(bundesland, size);
	}

	@Override
	public String getTitle() {
		return size == 0 ? "Test" : "Execrcise";
	}

	@Override
	public String getSubtitle() {
		return size == 0 ? "Exam simulator. 33 Random questions" : "Random questions not answered yet";
	}
}
