package oncourse.web.controller;

import java.util.List;

import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import oncourse.model.Course;
import oncourse.model.Grade;
import oncourse.model.GradeRecord;
import oncourse.model.Term;
import oncourse.model.User;
import oncourse.model.dao.CourseDao;
import oncourse.model.dao.GradeDao;
import oncourse.model.dao.GradeRecordDao;
import oncourse.security.SecurityUtils;

@Controller
public class CourseController {

    @Autowired
    private CourseDao courseDao;
    
    @Autowired
    private GradeRecordDao gradeRecordDao;

    @Autowired
    private GradeDao gradeDao;
    
    @RequestMapping("/course/list.html")
    public String list( ModelMap models )
    {
        models.put( "courses", courseDao.getCourses() );
        return "course/list";
    }
    
    
    @RequestMapping("/course/studentGrades.html")
    public String studentGrades( @RequestParam Long id, ModelMap models )
    {
    	Course course = courseDao.getCourse(id);
    	List<GradeRecord> gradeRecords = gradeRecordDao.getCourseGradeRecords(course);
        models.put("gradeRecords", gradeRecords);
        return "course/grades";
    }
    
    @RequestMapping(value = "/course/editGradeRecord.html", method = RequestMethod.GET)
    public String editGR( @RequestParam Long id, ModelMap models )
    {
    	GradeRecord gradeRecord = gradeRecordDao.getGradeRecord(id);
    	List<Grade> grades = gradeDao.getGrades();
        models.put("gradeRecord", gradeRecord);
        models.put("grades", grades);
        return "course/edit-grade";
    }
    
    @RequestMapping(value = "/course/editGradeRecord.html", method = RequestMethod.POST)
    public String editGR( @RequestParam Long gradeRecordId, @RequestParam Long gradeId)
    {
    	Grade grade = gradeDao.getGrade(gradeId);
    	GradeRecord gradeRecord = gradeRecordDao.getGradeRecord(gradeRecordId);
    	gradeRecord.setGrade(grade);
    	gradeRecord = gradeRecordDao.saveGradeRecord(gradeRecord);
    	return "redirect:studentGrades.html?id=" + gradeRecord.getCourse().getId();
    }
    
    @RequestMapping("/studentcourses.html")
    public String studentCourses( ModelMap models )
    {
        models.put( "courses", courseDao.getCourses() );
        return "course/signup";
    }
    
    @RequestMapping("/courseSignup.html")
    public String courseSignUp( @RequestParam Long id )
    {
        User user = SecurityUtils.getUser();
        
        Course course = courseDao.getCourse(id);
        GradeRecord gradeRecord = new GradeRecord();
        gradeRecord.setCourse(course);
        gradeRecord.setStudent(user);
        Term term = new Term();
        gradeRecord.setTerm(term);
        gradeRecordDao.saveGradeRecord(gradeRecord);
        return "redirect:index.html";
    }

}
