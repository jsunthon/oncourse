package oncourse.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import oncourse.model.Course;
import oncourse.model.GradeRecord;
import oncourse.model.Term;
import oncourse.model.User;
import oncourse.model.dao.CourseDao;
import oncourse.model.dao.GradeRecordDao;
import oncourse.security.SecurityUtils;

@Controller
public class CourseController {

    @Autowired
    private CourseDao courseDao;
    
    @Autowired
    private GradeRecordDao gradeRecordDao;

    @RequestMapping("/course/list.html")
    public String list( ModelMap models )
    {
        models.put( "courses", courseDao.getCourses() );
        return "course/list";
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
        return "index.html";
    }

}
