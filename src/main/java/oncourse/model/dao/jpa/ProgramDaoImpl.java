package oncourse.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import oncourse.model.Program;
import oncourse.model.dao.ProgramDao;

@Repository
public class ProgramDaoImpl implements ProgramDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Program getProgram( Long id )
    {
        return entityManager.find( Program.class, id );
    }

    @Override
    public List<Program> getPrograms()
    {
        return entityManager
            .createQuery( "from Program order by department", Program.class )
            .getResultList();
    }

    @Override
    @Transactional
    @PreAuthorize ("hasRole('ROLE_ADMIN')")
    public Program saveProgram( Program program )
    {
        return entityManager.merge( program );
    }
    
    @Override
    @Transactional
    public void deleteProgram( Program program) {
    	entityManager.remove(program);
    }

}
