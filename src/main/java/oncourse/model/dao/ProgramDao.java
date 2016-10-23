package oncourse.model.dao;

import java.util.List;

import oncourse.model.Program;

public interface ProgramDao {

    Program getProgram( Long id );

    List<Program> getPrograms();

    Program saveProgram( Program program );
    
    void deleteProgram( Program program );

}
