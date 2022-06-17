package com.lebenindeutschland.app.model;

public class LidQuestion {
	private LidContext context;

	private String num;
	private String question;
	private String[] options;
	private String solution;
	private String category;
	private String subcategory;
	private String image;

	public LidQuestion(LidContext context, String num, String question, String opt_a, String opt_b, String opt_c,
			String opt_d, String solution, String category, String subcategory, String image, String tags) {
		this.context = context;
		this.num = num;
		this.question = question;
		this.options = new String[] { opt_a, opt_b, opt_c, opt_d };
		this.solution = solution;
		this.category = category;
		this.subcategory = subcategory;
		this.image = image;
		this.addTag(tags);
	}

	public String getNum() {
		return num;
	}

	public boolean isNum(String num) {
		return num.equals(this.getNum());
	}

	public String getQuestion() {
		return question;
	}

	public String[] getOptions() {
		return options;
	}

	public String getSolution() {
		return solution;
	}

	public String getCategory() {
		return category;
	}

	public boolean isCategory(String category) {
		return category.equals(this.getCategory());
	}

	public String getSubcategory() {
		return subcategory;
	}

	public boolean isSubcategory(String category, String subcategory) {
		return this.isCategory(category) && (subcategory == null || subcategory.equals(this.getSubcategory()));
	}

	public String getImage() {
		return image;
	}

	public void addTag(String tag) {

	}

	public void removeTag(String tag) {

	}

	public String[] getTags() {
		// TODO
		return null;
	}

	public boolean hasTags(String values) {
		// TODO
		return false;
	}

	public double getRating() {
		return 1.0;
	}

	@Override
	public String toString() {
		return String.format("%s", this.getNum());
	}
}
