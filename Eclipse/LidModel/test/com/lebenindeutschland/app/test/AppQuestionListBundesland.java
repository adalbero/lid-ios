package com.lebenindeutschland.app.test;

import com.lebenindeutschland.app.model.LidContext;

public class AppQuestionListBundesland extends AppQuestionList {
	private String bundesland;

	public AppQuestionListBundesland(LidContext context, String bundesland) {
		this.bundesland = bundesland;
		this.questions = bundesland == null ? context.getQuestionDB().selectQuestionsByAlle300()
				: context.getQuestionDB().selectQuestionsByBundesland(bundesland);
	}

	@Override
	public String getTitle() {
		return bundesland == null ? "Alle" : bundesland;
	}

	@Override
	public String getSubtitle() {
		return bundesland == null ? "All general questions" : "Questions specific to your Bundesland";
	}

}
