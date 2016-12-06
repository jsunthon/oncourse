package oncourse.web.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import oncourse.model.Department;
import oncourse.model.dao.DepartmentDao;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentDao departmentDao;

    @RequestMapping("/department/list")
    public String list( ModelMap models )
    {	
    	List<Department> departments = departmentDao.getDepartments();
    	List<Department> openedDepts = new ArrayList<>();
    	for (Department department: departments) {
    		if (!department.isDeleted()) {
    			openedDepts.add(department);
    		}
    	}
        models.put( "departments", openedDepts );
        return "department/list";
    }

}
