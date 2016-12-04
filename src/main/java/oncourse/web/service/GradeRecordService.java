package oncourse.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import oncourse.model.GradeRecord;
import oncourse.model.dao.GradeRecordDao;

@RestController
public class GradeRecordService {
	private static final Logger logger = LoggerFactory.getLogger(GradeRecordService.class);
	
	@Autowired
	GradeRecordDao gradeRecordDao;
	
	@RequestMapping(value = "/service/grade/{id}", method = RequestMethod.DELETE)
	public void deleteGrade(@PathVariable Long id) {
		logger.info("recevied grade id: " + id);
		gradeRecordDao.deleteGradeRecord(gradeRecordDao.getGradeRecord(id));
	}
}
