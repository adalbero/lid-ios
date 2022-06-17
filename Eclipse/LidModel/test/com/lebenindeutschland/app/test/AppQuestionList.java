package com.lebenindeutschland.app.test;

import java.util.List;

import com.lebenindeutschland.app.model.LidQuestion;

public abstract class AppQuestionList {
	protected List<LidQuestion> questions;

	public List<LidQuestion> getQuestions() {
		return this.questions;
	}

	public int getCount() {
		return this.questions.size();
	}
	
	public abstract String getTitle();

	public abstract String getSubtitle();
}
