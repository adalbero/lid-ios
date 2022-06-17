package com.lebenindeutschland.app.test;

import com.lebenindeutschland.app.model.LidContext;

public class AppQuestionListCategory extends AppQuestionList {
	private String category;
	private String subcategory;

	public AppQuestionListCategory(LidContext context, String category, String subcategory) {
		this.category = category;
		this.subcategory = subcategory;
		this.questions = context.getQuestionDB().selectQuestionsByCategory(category, subcategory);
	}

	@Override
	public String getTitle() {
		return subcategory == null ? category : subcategory;
	}

	@Override
	public String getSubtitle() {
		return subcategory == null ? "by Theme" : category;
	}

}
