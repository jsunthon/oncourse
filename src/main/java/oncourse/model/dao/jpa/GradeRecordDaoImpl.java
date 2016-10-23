package oncourse.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import oncourse.model.GradeRecord;
import oncourse.model.User;
import oncourse.model.dao.GradeRecordDao;

@Repository
public class GradeRecordDaoImpl implements GradeRecordDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public GradeRecord getGradeRecord( Long id )
    {
        return entityManager.find( GradeRecord.class, id );
    }

    @Override
    public List<GradeRecord> getGradeRecords( User student )
    {
        String query = "from GradeRecord where student = :student order by term";

        return entityManager.createQuery( query, GradeRecord.class )
            .setParameter( "student", student )
            .getResultList();
    }

    @Override
    @Transactional
    public GradeRecord saveGradeRecord( GradeRecord gradeRecord )
    {
        return entityManager.merge( gradeRecord );
    }

}
