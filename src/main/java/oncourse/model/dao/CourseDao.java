package oncourse.model.dao;

import java.util.List;

import oncourse.model.Course;

public interface CourseDao {

    Course getCourse( Long id );

    List<Course> getCourses();

    Course saveCourse( Course course );
    
    List<String> suggestCourses(String term);

}
