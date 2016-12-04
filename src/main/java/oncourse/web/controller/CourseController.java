package oncourse.web.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import oncourse.model.Course;
import oncourse.model.GradeRecord;
import oncourse.model.User;
import oncourse.model.dao.CourseDao;
import oncourse.model.dao.GradeRecordDao;
import oncourse.security.SecurityUtils;

@Controller
@SessionAttributes("course")
public class CourseController {

	@Autowired
	private CourseDao courseDao;
	
	@Autowired
	private GradeRecordDao gradeRecordDao;

	@RequestMapping("/course/list")
	public String list(ModelMap models) {
		models.put("courses", courseDao.getCourses());
		return "course/list";
	}

	@RequestMapping(value = "/course/add", method = RequestMethod.GET)
	public String add(ModelMap models) {
		models.put("course", new Course());
		return "course/add";
	}

	@RequestMapping(value = "/course/add", method = RequestMethod.POST)
	public String add(@ModelAttribute Course course) {
		course = courseDao.saveCourse(course);
		return "redirect:list";
	}

	@RequestMapping(value = "/course/edit", method = RequestMethod.GET)
	public String edit(@RequestParam Long id, ModelMap models) {
		models.put("course", courseDao.getCourse(id));
		return "course/edit";
	}

	@RequestMapping(value = "/course/edit", method = RequestMethod.POST)
	public String edit(@ModelAttribute Course course) {
		course = courseDao.saveCourse(course);
		return "redirect:list";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(ModelMap models) {
		int year = Calendar.getInstance().get(Calendar.YEAR);
		List<Integer> years = new ArrayList<Integer>();
		for (int i = 0; i < 4; ++i)
			years.add(year - i);
		models.put("years", years);
		
		List<String> seasons = new ArrayList<>();
		seasons.add("SPRING");
		seasons.add("SUMMER");
		seasons.add("WINTER");
		seasons.add("FALL");
		models.put("seasons", seasons);
		
		User user = SecurityUtils.getUser();
		List<GradeRecord> gradeRecords = gradeRecordDao.getGradeRecords(user);
		models.put("gradeRecords", gradeRecords);
	
		return "course/signup";
	}
}
