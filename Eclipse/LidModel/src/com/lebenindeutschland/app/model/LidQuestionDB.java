package com.lebenindeutschland.app.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

public class LidQuestionDB {
	private static final String BUNDESLAND = "Bundesland";

	List<LidQuestion> questions = new ArrayList<>();

	public LidQuestionDB() {
	}

	public void add(LidQuestion q) {
		this.questions.add(q);
	}

	public LidQuestion getQuestion(String num) {
		return this.questions.stream().filter(q -> q.isNum(num)).findAny().orElse(null);
	}

	public Set<String> distinctCategories() {
		Set<String> result = new HashSet<>();

		this.questions.stream().filter(q -> !q.isCategory(BUNDESLAND)).forEach(q -> {
			result.add(q.getCategory());
		});

		return result;
	}

	public Set<String> distinctSubcategories(String category) {
		Set<String> result = new HashSet<>();

		this.questions.stream().filter(q -> category == null || q.isCategory(category)).forEach(q -> {
			result.add(q.getSubcategory());
		});

		return result;
	}

	public Set<String> distinctBundesland() {
		Set<String> result = new HashSet<>();

		this.questions.stream().filter(q -> q.isCategory(BUNDESLAND)).forEach(q -> {
			result.add(q.getSubcategory());
		});

		return result;
	}

	public int size() {
		return this.questions.size();
	}

	public List<LidQuestion> selectQuestionsByAlle300() {
		return this.questions.stream().filter(q -> !q.isCategory(BUNDESLAND)).collect(Collectors.toList());
	}

	public List<LidQuestion> selectQuestionsByBundesland(String bundesland) {
		return this.questions.stream().filter(q -> q.isSubcategory(BUNDESLAND, bundesland))
				.collect(Collectors.toList());
	}

	public List<LidQuestion> selectQuestionsByAlle310(String bundesland) {
		List<LidQuestion> result = this.selectQuestionsByAlle300();
		result.addAll(this.selectQuestionsByBundesland(bundesland));
		return result;
	}

	private static List<LidQuestion> getRandomQuestions(int size, List<LidQuestion> list) {
		List<LidQuestion> result = new ArrayList<>();

		Set<Integer> indexes = new TreeSet<>();
		while (indexes.size() < size) {
			int idx = (int) (Math.random() * list.size());
			indexes.add(idx);
		}

		for (int idx : indexes) {
			result.add(list.get(idx));
		}

		return result;
	}

	public List<LidQuestion> selectQuestionsByRandomExercise(String bundesland, int size) {
		List<LidQuestion> result = getRandomQuestions(size, this.selectQuestionsByAlle310(bundesland));

		return result;
	}

	public List<LidQuestion> selectQuestionsByRandomTest(String bundesland, int size1, int size2) {
		List<LidQuestion> result = getRandomQuestions(size1, this.selectQuestionsByAlle300());
		result.addAll(getRandomQuestions(size2, this.selectQuestionsByBundesland(bundesland)));

		return result;
	}

	public List<LidQuestion> selectQuestionsByCategory(String category, String subcategory) {
		return this.questions.stream().filter(q -> q.isSubcategory(category, subcategory)).collect(Collectors.toList());
	}

	public void sortQuestionsByNumber(List<LidQuestion> list, boolean ascending) {
		list.sort((q1, q2) -> (ascending ? 1 : -1) * q1.getNum().compareTo(q2.getNum()));
	}

	public void sortQuestionsByRating(List<LidQuestion> list, boolean ascending) {
		list.sort((q1, q2) -> (ascending ? 1 : -1) * (int) Math.signum(q1.getRating() - q2.getRating()));
	}

	public void sortQuestionsByRandom(List<LidQuestion> list) {
		Collections.shuffle(list);
	}
}
