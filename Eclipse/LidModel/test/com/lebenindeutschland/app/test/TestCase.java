package com.lebenindeutschland.app.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.lebenindeutschland.app.model.LidQuestion;
import com.lebenindeutschland.app.model.LidQuestionDB;

class TestCase {
	private static AppMain app = new AppMain();
	private static LidQuestionDB db;
	private static Map<String, Integer> categoryCount = new HashMap<>();
	static {
		categoryCount.put("Politik in der Demokratie", 192);
		categoryCount.put("Geschichte und Verantwortung", 89);
		categoryCount.put("Mensch und Gesellschaft", 19);
	}

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		app.loadQuestions();
		app.initMenu();

		db = app.getQuestionDB();
	}

	@Test
	void testDB() {
		assertEquals(300 + 16 * 10, db.size());

		List<LidQuestion> list;
		String bundesland = app.preferences.getBundesland();

		list = app.getQuestionDB().selectQuestionsByAlle300();
		assertEquals(300, list.size());

		list = app.getQuestionDB().selectQuestionsByBundesland(bundesland);
		assertEquals(10, list.size());

		list = app.getQuestionDB().selectQuestionsByAlle310(bundesland);
		assertEquals(310, list.size());

		list = app.getQuestionDB().selectQuestionsByRandomExercise(bundesland, 20);
		assertEquals(20, list.size());

		list = app.getQuestionDB().selectQuestionsByRandomTest(bundesland, 30, 3);
		assertEquals(33, list.size());

		Set<String> categories = db.distinctCategories();
		for (String category : categories) {
			list = app.getQuestionDB().selectQuestionsByCategory(category, null);
			assertEquals(categoryCount.get(category), list.size());
		}
	}

	@Test
	void testDistinct() {
		Set<String> list;

		list = app.getQuestionDB().distinctBundesland();
		assertEquals(16, list.size());

		list = app.getQuestionDB().distinctCategories();
		assertEquals(3, list.size());
	}

	@Test
	void testMenu() {
		AppQuestionList list;

		System.out.println("Questions");
		
		list = app.menu.listAlle300;
		printList(list);
		assertEquals(300, list.getCount());

		list = app.menu.listBundesland;
		printList(list);
		assertEquals(10, list.getCount());

		list = app.menu.listExercise;
		printList(list);
		assertEquals(20, list.getCount());

		list = app.menu.listTest;
		printList(list);
		assertEquals(33, list.getCount());

		System.out.println("\nby Theme");
		
		for (AppQuestionList listTheme : app.menu.listThemes) {
			printList(listTheme);
			assertEquals(categoryCount.get(listTheme.getTitle()), listTheme.getCount());
		}

		System.out.println("\nby Topic");
		
		for (AppQuestionList listTopic : app.menu.listTopics) {
			printList(listTopic);
//			assertEquals(categoryCount.get(listTopic.getTitle()), listTopic.getCount());
		}
	}

	private void printList(AppQuestionList list) {
		System.out.println(String.format("%s (%d) %s", list.getTitle(), list.getCount(), list.getSubtitle()));
		System.out.println(list.getQuestions());
	}

}
