package oncourse.model.dao.jpa;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import oncourse.model.Course;
import oncourse.model.CourseWrapper;
import oncourse.model.dao.CourseDao;

@Repository
public class CourseDaoImpl implements CourseDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Course getCourse( Long id )
    {
        return entityManager.find( Course.class, id );
    }

    @Override
    public List<Course> getCourses()
    {
        String query = "from Course where obsolete = false order by code";

        return entityManager.createQuery( query, Course.class ).getResultList();
    }

    @Override
    @Transactional
    public Course saveCourse( Course course )
    {
        return entityManager.merge( course );
    }
    
    @Override
    public List<CourseWrapper> getCourseSuggestions(String term) {
    	String query = "from Course c where upper(c.code) like ?1";
    	
    	List<Course> courses = entityManager
    			.createQuery(query, Course.class)
    			.setParameter(1, term.toUpperCase() + "%")
    			.getResultList();
    	List<CourseWrapper> courseWrappers = null;
    	
    	if (courses.size() > 0) {
    		courseWrappers = new ArrayList<>();
    	  	for (Course course : courses) {
    	  		String label = course.getCode();
    	  		CourseWrapper courseWrapper = 
    	  				new CourseWrapper(label, label, course.getId());
    	  		courseWrappers.add(courseWrapper);
    	  	}
    	}
    	return courseWrappers;
    }

}
