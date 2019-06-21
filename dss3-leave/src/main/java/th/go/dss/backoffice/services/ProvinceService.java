package th.go.dss.backoffice.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import gitex.utility.Database;
import th.go.dss.backoffice.dao.BackofficeDao;
import th.go.dss.backoffice.dao.BackofficeDaoJdbc;

public class ProvinceService {


	public String getProviceListJSON() {

		Database db = new Database();
		String sql = ""
				+ "SELECT province_id, province_name "
				+ "FROM GLB_PROVINCE "
				+ "ORDER BY NLSSORT(PROVINCE_NAME, 'NLS_SORT = THAI_DICTIONARY') asc";
		
		ArrayList<String> s = new ArrayList<String>();
		s.add("PROVINCE_ID");
		s.add("PROVINCE_NAME");
		
		List provinces = db.getResultSet(sql, s, null);
		
		
		
		ObjectMapper objectMapper = new ObjectMapper();

		String json;
		try {
			json = objectMapper.writeValueAsString(provinces);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			json = null;
		}
		
		return json;
	}

}
