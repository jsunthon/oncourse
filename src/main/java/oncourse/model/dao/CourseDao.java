package oncourse.model.dao;

import java.util.List;

import oncourse.model.Course;
import oncourse.model.CourseWrapper;

public interface CourseDao {

    Course getCourse( Long id );

    List<Course> getCourses();

    Course saveCourse( Course course );
    
    List<CourseWrapper> getCourseSuggestions(String term);

}
