package oncourse.model.dao;

import java.util.List;

import oncourse.model.Department;

public interface DepartmentDao {

    Department getDepartment( Long id );

    List<Department> getDepartments();

    Department saveDepartment( Department department );
    
    void deleteDepartment(Department department);

}
