package oncourse.model;

public class CourseWrapper {
	private String label;
	private String value;
	private Long id;
	
	public CourseWrapper(String label, String value, Long id) {
		this.label = label;
		this.value = value;
		this.id = id;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	

}
