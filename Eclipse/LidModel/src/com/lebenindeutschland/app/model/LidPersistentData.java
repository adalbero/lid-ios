package com.lebenindeutschland.app.model;

import java.util.HashMap;
import java.util.Map;

public class LidPersistentData {
	private Map<String, LidQuestionData> questionsData = new HashMap<>();

	public LidQuestionData getQuestionData(String num) {
		LidQuestionData qd = this.questionsData.get(num);

		if (qd == null) {
			qd = new LidQuestionData();
			this.questionsData.put(num, qd);
		}

		return qd;
	}
}
