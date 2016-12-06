package oncourse.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import oncourse.model.Department;
import oncourse.model.dao.DepartmentDao;

@Repository
public class DepartmentDaoImpl implements DepartmentDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Department getDepartment( Long id )
    {
        return entityManager.find( Department.class, id );
    }

    @Override
    public List<Department> getDepartments()
    {
        return entityManager
            .createQuery( "from Department order by name", Department.class )
            .getResultList();
    }

    @Override
    @Transactional
    public Department saveDepartment( Department department )
    {
        return entityManager.merge( department );
    }
    
    @Override
    @Transactional
    public void deleteDepartment(Department department) {
    	entityManager.remove(department);
    }

}
