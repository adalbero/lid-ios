package com.lebenindeutschland.app.model;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class LidQuestionData {
	private Set<String> tags;

	private void clearTags() {
		this.tags = new TreeSet<>();
	}

	private List<String> asList(String tags) {
		String[] vTags = tags.split(",");
		return Arrays.asList(vTags);
	}

	public void initTags(String tags) {
		if (this.tags == null && tags != null) {
			this.setTags(tags);
		}
	}

	public void setTags(String tags) {
		this.clearTags();
		this.addTags(tags);
	}

	public void addTags(String tags) {
		if (this.tags == null) {
			this.clearTags();
		}

		this.tags.addAll(this.asList(tags));
	}

	public void removeTags(String tags) {
		if (this.tags != null) {
			this.tags.removeAll(this.asList(tags));
		}
	}

	public String[] getTags() {
		String[] vTags = this.tags == null ? new String[0] : tags.toArray(new String[0]);

		return vTags;
	}

	public boolean hasAnyTags(String tags) {
		return this.tags != null && !Collections.disjoint(this.tags, this.asList(tags));
	}
}
