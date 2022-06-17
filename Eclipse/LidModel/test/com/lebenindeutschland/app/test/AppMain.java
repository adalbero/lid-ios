package com.lebenindeutschland.app.test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Set;
import java.util.stream.Stream;

import com.lebenindeutschland.app.model.LidContext;
import com.lebenindeutschland.app.model.LidPersistentData;
import com.lebenindeutschland.app.model.LidQuestion;
import com.lebenindeutschland.app.model.LidQuestionDB;

public class AppMain implements LidContext {
	public LidQuestionDB db = new LidQuestionDB();
	public LidPersistentData persistentData = new LidPersistentData();
	public AppMenu menu = new AppMenu();
	public AppPreferences preferences = new AppPreferences();

	private final int NUM = 0;
	private final int QUESTION = 1;
	private final int OPT_A = 2;
	private final int OPT_B = 3;
	private final int OPT_C = 4;
	private final int OPT_D = 5;
	private final int SOLUTION = 6;
//	private final int AREA_CODE = 7;
	private final int AREA = 8;
	private final int THEME = 9;
	private final int IMAGE = 10;
	private final int TAGS = 11;

	public void loadQuestions() throws IOException {

		try (Stream<String> stream = Files.lines(Paths.get("assets/questions.csv"))) {
			stream.forEach(line -> {
				String[] args = line.split(";");
//				System.out.println(line);
				if (!args[NUM].equals("num")) {
//					System.out.println(args.length);
//					System.out.println(Arrays.asList(args));
					String tags = TAGS < args.length ? args[TAGS] : null;
					this.db.add(new LidQuestion(this, args[NUM], args[QUESTION], args[OPT_A], args[OPT_B], args[OPT_C],
							args[OPT_D], args[SOLUTION], args[AREA], args[THEME], args[IMAGE], tags));
				}
			});
		}
	}

	public LidQuestionDB getQuestionDB() {
		return this.db;
	}

	public LidPersistentData getPersistentData() {
		return this.persistentData;
	};

	public void savePersistentData() {
		// noop
	}

	public void initMenu() {
		this.menu.listAlle300 = new AppQuestionListBundesland(this, null);
		this.menu.listBundesland = new AppQuestionListBundesland(this, preferences.getBundesland());
		this.menu.listExercise = new AppQuestionListRandom(this, preferences.getBundesland(), 20);
		this.menu.listTest = new AppQuestionListRandom(this, preferences.getBundesland(), 0);

		Set<String> categories = db.distinctCategories();
		for (String category : categories) {
			this.menu.listThemes.add(new AppQuestionListCategory(this, category, null));
			Set<String> subcategories = db.distinctSubcategories(category);
			for (String subcategory : subcategories) {
				this.menu.listTopics.add(new AppQuestionListCategory(this, category, subcategory));
			}
		}
		this.menu.listThemes.sort((list1, list2) -> list2.getCount() - list1.getCount());
	}

}
