package oncourse.model.dao;

import java.util.List;

import oncourse.model.GradeRecord;
import oncourse.model.User;

public interface GradeRecordDao {

    GradeRecord getGradeRecord( Long id );

    List<GradeRecord> getGradeRecords( User student );

    GradeRecord saveGradeRecord( GradeRecord gradeRecord );
    
    void deleteGradeRecord(GradeRecord gradeRecord);

}
