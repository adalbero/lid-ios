package com.lebenindeutschland.app.model;

public interface LidContext {
	public LidQuestionDB getQuestionDB();

	public LidPersistentData getPersistentData();

	public void savePersistentData();
}
