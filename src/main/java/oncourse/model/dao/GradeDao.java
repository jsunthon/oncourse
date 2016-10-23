package oncourse.model.dao;

import java.util.List;

import oncourse.model.Grade;

public interface GradeDao {
	
	List<Grade> getGrades();
	
	Grade getGrade( Long id);
}
