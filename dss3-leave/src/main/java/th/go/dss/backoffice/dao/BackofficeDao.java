package th.go.dss.backoffice.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface BackofficeDao {

	Integer saveHrVehicleReqform(String orgHead, Integer fiscalYear, 
			Integer empId, String empTitle, 
			Date vehicleRequestDate,
			String vehicleStartTime, String vehicleEndTime, String placeToGo,
			String reasonToGo, String remark);

	List<Map<String, Object>> searchEmployee(String query);

	void saveHrVehicleReqformPassenger(Integer id, Integer[] passengerIds);

	List<Map<String, Object>> findFrmHrVehicleReqForm(Integer id);

	List<Map<String, Object>> findFrmHrVehicleReqFormPassenger(Integer frmId);

	Integer saveHrVehicleOvernightReqform(String orgHead, Integer fiscalYear, Integer empId, String empTitle,
			String empTopOrg, Date startOvernightDate, Date endOvernightDate, String licenseNumber, Integer licenseProvinceId,
			String reason);
	

	List<Map<String, Object>> findAllProvices();

	List<Map<String, Object>> findFrmHrVehicleOvernightReqForm(Integer id);
}
