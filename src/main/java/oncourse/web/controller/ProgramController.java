package oncourse.web.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import oncourse.model.Course;
import oncourse.model.Department;
import oncourse.model.GradeRecord;
import oncourse.model.Program;
import oncourse.model.ProgramBlock;
import oncourse.model.User;
import oncourse.model.dao.DepartmentDao;
import oncourse.model.dao.GradeRecordDao;
import oncourse.model.dao.ProgramDao;
import oncourse.model.dao.UserDao;
import oncourse.security.SecurityUtils;

@Controller
@SessionAttributes({ "program" })
public class ProgramController {
	Logger logger = Logger.getLogger(ProgramController.class);
	@Autowired
	private DepartmentDao departmentDao;

	@Autowired
	private ProgramDao programDao;

	@Autowired
	private GradeRecordDao gradeRecordDao;

	@Autowired
	private UserDao userDao;

	@RequestMapping("/program/list.html")
	public String list(ModelMap models) {
		models.put("programs", programDao.getPrograms());
		return "program/list";
	}

	@RequestMapping("/program/view.html")
	public String view(@RequestParam Long id, ModelMap models) {
		models.put("program", programDao.getProgram(id));
		return "program/view";
	}

	@RequestMapping(value = "/program/add.html", method = RequestMethod.GET)
	public String addProgram(ModelMap models) {
		models.put("addProgram", new Program());
		List<Department> departments = departmentDao.getDepartments();
		models.put("departments", departments);
		return "program/add";
	}

	@RequestMapping(value = "/program/edit.html", method = RequestMethod.GET)
	public String editProgram(@RequestParam Long id, ModelMap models) {
		models.put("program", programDao.getProgram(id));
		List<Department> departments = departmentDao.getDepartments();
		models.put("departments", departments);
		return "program/edit";
	}

	@RequestMapping(value = "/program/edit.html", method = RequestMethod.POST)
	public String editProgram(@RequestParam Long id, @RequestParam String name, @RequestParam String description,
			@RequestParam Long departmentId) {
		Program program = programDao.getProgram(id);
		program.setName(name);
		program.setDescription(description);
		Department department = departmentDao.getDepartment(departmentId);
		program.setDepartment(department);
		programDao.saveProgram(program);
		return "redirect:list.html";
	}

	@RequestMapping(value = "/program/delete.html", method = RequestMethod.GET)
	public String deleteProgram(@RequestParam Long id) {
		Program program = programDao.getProgram(id);
		programDao.deleteProgram(program);
		return "redirect:list.html";
	}

	@RequestMapping(value = "/program/add.html", method = RequestMethod.POST)
	public String addProgram(@RequestParam String name, @RequestParam String description,
			@RequestParam Long departmentId) {
		Program program = new Program();
		program.setName(name);
		program.setDescription(description);
		Department department = departmentDao.getDepartment(departmentId);
		program.setDepartment(department);
		programDao.saveProgram(program);
		return "redirect:list.html";
	}

	@RequestMapping(value = "/progress.html", method = RequestMethod.GET)
	public String progress(ModelMap models) {
		User user = SecurityUtils.getUser();
		List<Course> offTrackCourses = new ArrayList<>();

		List<GradeRecord> gradeRecords = gradeRecordDao.getGradeRecords(user);

		Program program = programDao.getProgram(user.getProgram().getId());
		List<ProgramBlock> programBlocks = program.getBlocks();
				
		for (GradeRecord gradeRecord : gradeRecords) {
			//For the gradeRecord, assume it's course contributes to program, unless otherwise found, as follows.
			boolean goodCourse = false;
			Course gradeRecordCourse = gradeRecord.getCourse();
			for (ProgramBlock programBlock : programBlocks) {
				List<Course> courses = programBlock.getCourses();
				if (courses.contains(gradeRecordCourse)) {
					goodCourse = true;
				}
			}
			if (!goodCourse) {
				/* If goodCourse is still false, it means it didn't belong to a program block.
				 * Therefore, add it to the list of offTrackCourses*/
				offTrackCourses.add(gradeRecordCourse);
			}
		}
		models.put("offTrackCourses", offTrackCourses);
		models.put("userProgram", program);
		return "program/progress";
	}

	@RequestMapping(value = "/studentprograms.html", method = RequestMethod.GET)
	public String studentPrograms(ModelMap models) {
		List<Program> programs = programDao.getPrograms();
		models.put("programs", programs);
		return "program/signup";
	}

	@RequestMapping(value = "/signup.html", method = RequestMethod.GET)
	public String studentPrograms(@RequestParam Long id) {
		Program program = programDao.getProgram(id);
		User user = SecurityUtils.getUser();
		user.setProgram(program);
		userDao.saveUser(user);
		return "redirect:progress.html";
	}
}
