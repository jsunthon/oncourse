package oncourse.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import oncourse.model.Course;
import oncourse.model.dao.CourseDao;

@RestController
public class CourseService {
	@Autowired
	CourseDao courseDao;
	
	@RequestMapping(value = "/service/course/{id}", method = RequestMethod.PUT)
	public void editCourse(@PathVariable Long id, @RequestBody Course course) {
		course.setId(id);
		courseDao.saveCourse(course);
	}
	
	@RequestMapping(value = "/service/course/search", method = RequestMethod.GET)
	public List<String> courseSearch(@RequestParam String term) {
		List<String> courses = null;
		courses = courseDao.suggestCourses(term);
		return courses;
	}
}
