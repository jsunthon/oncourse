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
import oncourse.model.CourseWrapper;
import oncourse.model.GradeRecord;
import oncourse.model.Term;
import oncourse.model.User;
import oncourse.model.dao.CourseDao;
import oncourse.model.dao.GradeRecordDao;
import oncourse.security.SecurityUtils;

@RestController
public class CourseService{	
	@Autowired
    private CourseDao courseDao;
		
	@RequestMapping(value = "/service/course/search", method = RequestMethod.GET)
	public List<CourseWrapper> getCourseSuggestions(@RequestParam String term) {
		return courseDao.getCourseSuggestions(term);
	}

}
