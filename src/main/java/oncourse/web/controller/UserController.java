package oncourse.web.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import oncourse.model.Course;
import oncourse.model.Grade;
import oncourse.model.GradeRecord;
import oncourse.model.Program;
import oncourse.model.ProgramBlock;
import oncourse.model.User;
import oncourse.model.dao.GradeDao;
import oncourse.model.dao.GradeRecordDao;
import oncourse.model.dao.ProgramDao;
import oncourse.model.dao.UserDao;
import oncourse.security.SecurityUtils;

@Controller
public class UserController {
	
	@Autowired
	private ProgramDao programDao;

	@Autowired
	private GradeRecordDao gradeRecordDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private GradeDao gradeDao;
	
    @RequestMapping("/user/list.html")
    public String list( ModelMap models )
    {
        List<User> users = userDao.getUsers();
        models.put("users", users);
        return "user/list";
    }
    
    // used to view all the grades of a given user.
    @RequestMapping("/user/grades.html")
    public String list( @RequestParam Long id, ModelMap models )
    {
        User user = userDao.getUser(id);
        models.put("user", user);
        return "user/view";
    }
	
	
	@RequestMapping(value = "/user/progress.html", method = RequestMethod.GET)
	public String progress(@RequestParam Long id, ModelMap models) {

		User user = userDao.getUser(id);
		Program program = programDao.getProgram(user.getProgram().getId());

		List<GradeRecord> offTrackGradeRecords = new ArrayList<>();
		List<GradeRecord> gradeRecords = gradeRecordDao.getGradeRecords(user);
		List<ProgramBlock> programBlocks = program.getBlocks();
		List<Grade> grades = gradeDao.getGrades();

		Grade baseLineGrade = null; // C- is the baseline grade.
		for (Grade grade : grades) {
			if (grade.getSymbol().equals("C-")) {
				baseLineGrade = grade;
				break;
			}
		}

		for (GradeRecord gradeRecord : gradeRecords) {
			// For the gradeRecord, assume it's course contributes to program
			// and that it is not a failing course
			boolean goodCourse = false;
			Course gradeRecordCourse = gradeRecord.getCourse();
			for (ProgramBlock programBlock : programBlocks) {
				
				List<Course> courses = programBlock.getCourses();

				if (courses.contains(gradeRecordCourse)) {
					Grade grade = gradeRecord.getGrade();
					if (grade == null) {
						goodCourse = true; // person hasn't received grade yet.
											// give him benefit of the doubt.
					} else if (grade.getValue() >= baseLineGrade.getValue()) {
						goodCourse = true;
					}
				}
			}

			if (!goodCourse) {
				/*
				 * If goodCourse is still false, it means it didn't belong to a
				 * program block or it did but it was a failing class.
				 * Therefore, add it to the list of offTrackCourses
				 */
				offTrackGradeRecords.add(gradeRecord);
			}
		}
		models.put("user", user);
		models.put("offTrackGradeRecords", offTrackGradeRecords);
		models.put("userProgram", program);
		return "user/progress";
	}
}
