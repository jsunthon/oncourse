package oncourse.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import oncourse.model.Department;
import oncourse.model.dao.DepartmentDao;

@RestController
public class DepartmentService {
	@Autowired
	DepartmentDao departmentDao;
	
	@RequestMapping(value = "/service/department/{name}", method = RequestMethod.POST)
    public Department addCourse(@PathVariable String name){
		System.out.println("Adding department: " + name);
		Department department = new Department();
		department.setName(name);
        return departmentDao.saveDepartment(department);
    }
	
	@RequestMapping(value = "/service/department/{id}", method = RequestMethod.DELETE)
	public void deleteDepartment(@PathVariable Long id) {
		System.out.println("Deleting department id: " + id);
		Department department = departmentDao.getDepartment(id);
		if (department.getPrograms().size() > 0) {
			System.out.println(department.getPrograms().size());
			department.setDeleted(true);
			departmentDao.saveDepartment(department);
		} else {
			departmentDao.deleteDepartment(department);
		}
	}
}
