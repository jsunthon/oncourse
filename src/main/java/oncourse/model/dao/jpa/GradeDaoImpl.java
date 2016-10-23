package oncourse.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import oncourse.model.Grade;
import oncourse.model.dao.GradeDao;

@Repository
public class GradeDaoImpl implements GradeDao {

    @PersistenceContext
    private EntityManager entityManager;
    
    @Override
    public Grade getGrade(Long id) {
    	return entityManager.find(Grade.class, id);
    }
    
    @Override
    public List<Grade> getGrades() {
    	String query = "from Grade";
    	return entityManager.createQuery(query, Grade.class).getResultList();
    }
}
