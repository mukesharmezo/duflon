package com.armezo.duflon.ServicesImpl;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.armezo.duflon.Entities.EmergencyContact;
import com.armezo.duflon.Entities.FamilyDetails;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Repositories.EmergencyContactRepo;
import com.armezo.duflon.Repositories.FamilyDetailsRepo;
import com.armezo.duflon.Repositories.HreRepository;
import com.armezo.duflon.Repositories.LineManagerRepository;
import com.armezo.duflon.Repositories.ParticipantRepository;
import com.armezo.duflon.Repositories.WorkExperienceRepo;
@Service
public class ParticipantServiceImpl  {
	@Autowired
	ParticipantRepository participantrepository;
	@Autowired
	FamilyDetailsRepo familyDetailsRepo;
	@Autowired
	EmergencyContactRepo emergencyContactRepo;
	@Autowired
	WorkExperienceRepo workExperienceRepo;
	@Autowired
	LineManagerRepository fsdmRepo;
	@Autowired
	HreRepository hreRepo;
	// save Participants
	// save Participants
	public ParticipantRegistration saveData(ParticipantRegistration participant) {
		return participantrepository.save(participant);
	}
	public ParticipantRegistration saveLoginDetails(ParticipantRegistration participantRegistration) {
		return participantrepository.save(participantRegistration);
	}
	// Get all Participants Family_details
	public List<FamilyDetails> getAllFamilyDetails() {
		return familyDetailsRepo.findAll();
	}
	// Get all Participants Emergency_Contact
	public List<EmergencyContact> getAllEmergencyContact() {
		return emergencyContactRepo.findAll();
	}
	// Get all Participants Work_Experience
	public List<WorkExperience> getAllWorkExperience() {
		return workExperienceRepo.findAll();
	}
	public ParticipantRegistration saveFiles(ParticipantRegistration partupload) {
		return participantrepository.save(partupload);
	}
	public Optional<ParticipantRegistration> findByAccesskey(String accesskey) {
		return participantrepository.findByAccessKey(accesskey);
	}
	public void deleteParticpant(ParticipantRegistration Participant) {
		 participantrepository.delete(Participant);;
	}
	public List<ParticipantRegistration> getEmployee(Long hreId, String hiredStatus, LocalDate from, LocalDate to) {
		return participantrepository.getEmployee(hreId, hiredStatus,from,to);
	}
	public FamilyDetails getOneFamilyDetailsById(Long fid) {
		return familyDetailsRepo.findById(fid).get();
	}
	public List<ParticipantRegistration> getParticipantInpprocessForHRE(Long hreId, LocalDate from, LocalDate to) {
		return participantrepository.getParticipantInpprocessForHRE(hreId,from,to);
	}
	public List<ParticipantRegistration> getParticipantInpprocessLM(LocalDate from, LocalDate to) {
		return participantrepository.getParticipantInpprocessHo(from,to);
	}
	public List<ParticipantRegistration> getParticipantEmployeeLM(LocalDate from, LocalDate to) {
		return participantrepository.getParticipantEmployeeHo(from,to);
	}
	public List<ParticipantRegistration> getParticipantHoldLM(LocalDate from, LocalDate to) {
		return participantrepository.getParticipantHoldHo(from,to);
	}
	public List<ParticipantRegistration> getParticipantByhreIdLsit(List<Long> hreIds) {
		return participantrepository.findByHreIdIn(hreIds);
	}
	public List<ParticipantRegistration> getHoldEmployee(long hreId, String status) {
		return participantrepository.getHoldEmployee(hreId, status);
	}
	public List<ParticipantRegistration> findAllHoldParticipantsOnHO(String status) {
		return participantrepository.findAllHoldParticipantByStatusOnHO(status);
		//return new ArrayList<ParticipantRegistration>();
	}
	
	
	
	
	
	
	
	
	/*
	public Optional<ParticipantRegistration> getParticipantByFirstNameAndLastNameAndEmail(String fistName,
			String lastName, String email, Long hreId) {
		return participantrepository.findTop1ByFirstNameIgnoreCaseAndLastNameIgnoreCaseAndEmailIgnoreCaseAndhreId(
				fistName, lastName, email, hreId);
	}
	*/
	public Optional<ParticipantRegistration> getParticipantByAccesskey(String accesskey) {
		return participantrepository.findByAccessKey(accesskey);
	}
	public void deleteById(Long fid) {
		familyDetailsRepo.deleteById(fid);
	}
	public EmergencyContact getEmergencyContactById(Long id) {
		return emergencyContactRepo.findById(id).get();
	}
	/*
	
	public void saveFamily(FamilyDetails familyDetails) {
		familyDetailsRepo.save(familyDetails);
	}
	public void deleteById1(Long eid) {
		emergencyContactRepo.deleteById(eid);
	}
	public void saveEmergency(EmergencyContact emergencyContact) {
		emergencyContactRepo.save(emergencyContact);
	}
	public void deleteById2(Long wid) {
		workExperienceRepo.deleteById(wid);
	}
	public void saveWorkExperience(WorkExperience workExperience) {
		workExperienceRepo.save(workExperience);
	}
	public List<ParticipantRegistration> getParticipantByhreId(long hreId) {
		return participantrepository.findByhreIdOrderByModifiedDateDesc(hreId);
	}
	
	public List<ParticipantRegistration> getAllParticipant() {
		return participantrepository.findAll();
	}
	
	
	public List<ParticipantRegistration> getParticipantByOutletCodeAndDesg(String outletCode, String designation) {
		Optional<List<ParticipantRegistration>> participantOptional = participantrepository
				.getParticipantByOutletCodeAndDesg(outletCode, designation);
		return participantOptional.get();
	}
	public List<ParticipantRegistration> getParticipantByFilterData(String outletCode, String candidateName,
			String designation, String mspin, List<Integer> passFailStatus, Date dateFrom, Date dateTo) {
		List<ParticipantRegistration> part = participantrepository.getParticipantByFilterData(outletCode, candidateName,
				designation, mspin, passFailStatus, dateFrom, dateTo);
		return part;
	}
	public List<ParticipantRegistration> findByDateRange(Date dateFrom, Date dateTo) {
		return participantrepository.findByDateRange(dateFrom, dateTo);
	}
	public List<ParticipantRegistration> findParticipantsByCompletionFilter(String assessment, String interview) {
		return participantrepository.findParticipantsByCompletionFilter(assessment, interview);
	}
	
	
	public List<ParticipantRegistration> getParticipantByFilterData(String outletCode, String candidateName,
			String designation, String mspin, List<Integer> passFailStatus, String uniqueCode, Long hreId,
			Date dateFrom, Date dateTo) {
		List<ParticipantRegistration> part = participantrepository.getParticipantByFilterData(outletCode, candidateName,
				designation, mspin, passFailStatus, uniqueCode, hreId, dateFrom, dateTo);
		return part;
	}
	public List<ParticipantRegistration> getParticipantForNotification(List<Long> hreId, String prarambhStatus,
			String testStatus) {
		return participantrepository.findByhreIdInAndPrarambhStatusAndTestStatusOrderByModifiedDateDesc(hreId,
				prarambhStatus, testStatus);
	}
	public List<ParticipantRegistration> findAllByTestStatus() {
		return participantrepository.findAllParticipantWhoseTestIsCompleted();
	}
	public List<ParticipantRegistration> getParticipantByHOFilters(List<String> stList) {
		return participantrepository.getParticipantByHOFilters(stList);
	}
	
	public List<ParticipantRegistration> getAllFSDMApprovedParticipantOnHO(String fsdmApproveStatus) {
		return new ArrayList<ParticipantRegistration>();
	}
	public List<ParticipantRegistration> getParticipantByFilterData(String outletCode, String candidateName,
			String designation, String mspin, List<Integer> passFailStatus, Long hreId) {
		return null;
	}
	public List<ParticipantRegistration> getParticipantCSVInpprocess(long hreId) {
		return participantrepository.getParticipantCSVInpprocess(hreId);
	}
	public List<ParticipantRegistration> getParticipantCSVHold(long hreId) {
		return participantrepository.getParticipantCSVHold(hreId);
	}
	public List<ParticipantRegistration> getParticipantCSVImployee(long hreId) {
		return participantrepository.getParticipantCSVImployee(hreId);
	}
	public List<ParticipantRegistration> getParticipantByFilterData2(String outletCode, String candidateName,
			String designation, String mspin, List<Integer> passFailStatus, Long hreId, String uniqueCode) {
		return participantrepository.getParticipantByFilterData2(outletCode, candidateName, designation, mspin,
				passFailStatus, hreId, uniqueCode);
	}
	public List<ParticipantRegistration> getAllParticipantNotInWithAccessKeyList(List<String> accessKeyList,
			String holdStatus) {
		return participantrepository.getAllParticipantNotInWithAccessKeyList(accessKeyList, holdStatus);
	}
	public List<ParticipantRegistration> getAllParticipantNotHold(String status) {
		return participantrepository.getAllParticipantNotHold(status);
	}
	public List<ParticipantRegistration> getAllParticipantNotInWithAccessKeyListWithHold(List<String> accessKeyList) {
		return participantrepository.getAllParticipantNotInWithAccessKeyListWithHold(accessKeyList);
	}
	public List<ParticipantRegistration> findAllParticipantsOnHONotHold() {
		return participantrepository.findAllParticipantsOnHONotHold();
	}
	public List<ParticipantRegistration> getParticipantByhreIdListAndDate(List<Long> list, Date fromDate,
			Date toDate) {
		return participantrepository.getParticipantByhreIdListAndDate(list, fromDate, toDate);
	}
	
	
	public List<ParticipantRegistration> getParticipantOnHoldByFilterData(String outletCode, String candidateName,
			String designation, String mspin, List<Integer> passFailStatus, String uniqueCode, Long hreId,
			Date dateFrom, Date dateTo, String status) {
		return participantrepository.getParticipantOnHoldByFilterData(outletCode, candidateName, designation, mspin,
				passFailStatus, uniqueCode, hreId, dateFrom, dateTo, status);
	}
	public List<ParticipantRegistration> getParticipantOnHoldByFilterData2(String outletCode, String candidateName,
			String designation, String mspin, List<Integer> passFailStatus, Long hreId, String uniqueCode,
			String status) {
		return participantrepository.getParticipantOnHoldByFilterData2(outletCode, candidateName, designation, mspin,
				passFailStatus, uniqueCode, hreId, status);
	}
	public List<ParticipantRegistration> getParticipantByFilterDataForFSDM(String outletCode, String candidateName,
			String designation, String mspin, List<Integer> passFailStatus, String uniqueCode, List<Long> list,
			Date dateFrom, Date dateTo) {
		return participantrepository.getParticipantByFilterDataForFSDM(outletCode, candidateName, designation, mspin,
				passFailStatus, uniqueCode, list, dateFrom, dateTo);
	}
	public List<ParticipantRegistration> getParticipantByFilterDataForFSDM2(String outletCode, String candidateName,
			String designation, String mspin, List<Integer> passFailStatus, List<Long> list, String uniqueCode) {
		return participantrepository.getParticipantByFilterDataForFSDM2(outletCode, candidateName, designation, mspin,
				passFailStatus, list, uniqueCode);
	}
	public List<ParticipantRegistration> getParticipantOnEmployeeMasterDealerByFilterData(String outletCode,
			String candidateName, String designation, String mspin, List<Integer> passFailStatus, String uniqueCode,
			Long hreId, Date dateFrom, Date dateTo, String fsdmApprovalStatus) {
		return participantrepository.getParticipantOnEmployeeMasterDealerByFilterData(outletCode, candidateName,
				designation, mspin, passFailStatus, uniqueCode, hreId, dateFrom, dateTo, fsdmApprovalStatus);
	}
	public List<ParticipantRegistration> getParticipantOnEmployeeMasterDealerByFilterData2(String outletCode,
			String candidateName, String designation, String mspin, List<Integer> passFailStatus, Long hreId,
			String uniqueCode) {
		return participantrepository.getParticipantOnEmpMasterDealerByFilterData2(outletCode, candidateName,
				designation, mspin, passFailStatus, uniqueCode, hreId);
	}
	
	public List<ParticipantRegistration> getParticipantCSVPendingApprovel(List<Long> hreId, Date dateFrom,
			Date dateTo) {
		return participantrepository.getParticipantCSVPendingApprovel(hreId, dateFrom, dateTo);
	}
	public List<ParticipantRegistration> getParticipantCSVImployee(List<Long> hreId, Date dateFrom, Date dateTo) {
		return participantrepository.getParticipantCSVImployee(hreId, dateFrom, dateTo);
	}
	public List<ParticipantRegistration> getParticipantCSVHold(List<Long> hreId, Date dateFrom, Date dateTo) {
		return participantrepository.getParticipantCSVHold(hreId, dateFrom, dateTo);
	}
	public List<ParticipantRegistration> getParticipantCSVInpprocess(List<Long> hreId, Date dateFrom, Date dateTo) {
		return participantrepository.getParticipantCSVInpprocess(hreId, dateFrom, dateTo);
	}
	
	
	public List<ParticipantRegistration> getParticipantPendingApprovel() {
		return participantrepository.getParticipantPendingApprovel();
	}
	public List<ParticipantRegistration> getParticipantCSVInpprocess(List<Long> hreId) {
		return participantrepository.getParticipantCSVInpprocess(hreId);
	}
	public List<ParticipantRegistration> getParticipantCSVImployee(List<Long> hreId) {
		return participantrepository.getParticipantCSVImployee(hreId);
	}
	public List<ParticipantRegistration> getParticipantCSVHold(List<Long> hreId) {
		return participantrepository.getParticipantCSVHold(hreId);
	}
	public List<ParticipantRegistration> getParticipantCSVPendingApprovel(List<Long> hreId) {
		return participantrepository.getParticipantCSVPendingApprovel(hreId);
	}
	public List<ParticipantRegistration> getParticipantCSVPendingApprovel(long hreId) {
		List<Long> list = new ArrayList<Long>();
		list.add(hreId);
		return participantrepository.getParticipantCSVPendingApprovel(list);
	}
	public List<ParticipantRegistration> getParticipantCSVInpprocess(long hreId, Date dateFrom, Date dateTo) {
		return participantrepository.getParticipantCSVInpprocess(hreId, dateFrom, dateTo);
	}
	*/
	/* filter dealer */
	/*
	public List<ParticipantRegistration> getParticipantFilterInpprocess(String outletCode, String name,
			String designation, String mspin, List<Integer> passFailStatus, String accessKey, Long hreId,
			Date dateFrom, Date dateTo) {
		return participantrepository.getParticipantFilterInpprocess(outletCode, name, designation, mspin,
				passFailStatus, accessKey, hreId, dateFrom, dateTo);
	}
	public List<ParticipantRegistration> getParticipantFilterEmployee(String outletCode, String name,
			String designation, String mspin, List<Integer> passFailStatus, String accessKey, Long hreId,
			Date dateFrom, Date dateTo,String fsdmApprovalStatus) {
		List<ParticipantRegistration> list =participantrepository.getParticipantFilterEmployee(outletCode, name, designation, mspin, passFailStatus,
				accessKey, hreId, dateFrom, dateTo,fsdmApprovalStatus);
		return list;
	}
	public List<ParticipantRegistration> getParticipantOnEmployeeMasterDealerByFilterData(String outletCode,
			String name, String designation, String mspin, List<Integer> passFailStatus, String accessKey,
			Long hreId, String fsdmApprovalStatus) {
		return participantrepository.getParticipantOnEmployeeMasterDealerByFilterData(outletCode, name, designation,
				mspin, passFailStatus, accessKey, hreId, fsdmApprovalStatus);
	}
	*/
	public int updateModifiedDate(String accesskey) {
		int result = participantrepository.updateModifiedDate(accesskey);
		return result;
	}
	public List<ParticipantRegistration> getParticipant() {
		return   participantrepository.getParticipant();
	}
	/*
	public List<ParticipantRegistration> findByhreIdInFSDM(List<Long> hreId) {
		return participantrepository.findByhreIdPendinApproverFSDM(hreId);
	}
	public List<ParticipantRegistration> findByhreIdInprocessFSDM(List<Long> hreId) {
		return participantrepository.findByhreIdInprocessFSDM(hreId);
	}
	public List<ParticipantRegistration> findByhreIdEmployeeFSDM(List<Long> hreId) {
		return participantrepository.findByhreIdEmployeeFSDM(hreId);
	}
	public int updateProductivityRefID(String empProductivityRefId, String accesskey) {
		return participantrepository.updateProductivityRefID(empProductivityRefId, accesskey);
	}
	public List<ParticipantRegistration> getOldMSPIN(String oldMspin) {
		return participantrepository.getOldMSPIN(oldMspin);
	}
	public List<ParticipantRegistration> findParticipantsByCompletionFilterInProcess(Integer interviewSearch,
			String praraambhSearch, List<String> fsdmSearch, List<Long> hreIdList) {
		List<ParticipantRegistration> list= new ArrayList<ParticipantRegistration>();
		if(fsdmSearch.isEmpty() || fsdmSearch==null) {
			list=participantrepository.findParticipantsByCompletionFilterInProcessWithoutFSDM(interviewSearch,praraambhSearch,hreIdList);
		}else {
			list= participantrepository.findParticipantsByCompletionFilterInProcess(interviewSearch,praraambhSearch,fsdmSearch, hreIdList);
		}
		return list;
	}
	public List<ParticipantRegistration> findParticipantsByCompletionFilterOnHold(Integer interviewSearch,
			String praraambhSearch, List<String> fsdmSearch, List<Long> hreIdList) {
		List<ParticipantRegistration> list= new ArrayList<ParticipantRegistration>();
		if(fsdmSearch.isEmpty() || fsdmSearch==null) {
			list=participantrepository.findParticipantsByCompletionFilterOnHoldWithoutFSDM(interviewSearch,praraambhSearch,hreIdList);
		}else {
			list= participantrepository.findParticipantsByCompletionFilterOnHold(interviewSearch,praraambhSearch,fsdmSearch,hreIdList);
		}
		return list;
	}
	public List<ParticipantRegistration> findParticipantsByCompletionFilterPendingApprovalFSDM(String praraambhSearch,
			List<Long> hreIdList) {
		return participantrepository.findParticipantsByCompletionFilterPendingApprovalFSDM(praraambhSearch,hreIdList);
	}
	public List<ParticipantRegistration> getCandidateMPINnotGerate() {
		// TODO Auto-generated method stub
		return participantrepository.getCandidateMPINnotGerate();
	}
	
	
	public List<ParticipantRegistration> getParticipantByhreId(List<Long> hreIdList) {
		// TODO Auto-generated method stub
		return   participantrepository.getParticipantByhreId(hreIdList);
	}
	public List<ParticipantRegistration> getParticipantByhreId() {
		// TODO Auto-generated method stub
		return   participantrepository.getParticipantByhreId();
	}
	public List<ParticipantRegistration> getParticipantByhreId(List<Long> hreIdList, Date dateFrom, Date dateTo) {
		// TODO Auto-generated method stub
		return participantrepository.getParticipantByhreId(hreIdList,dateFrom,dateTo);
	}
	public int updatePraaarambhtStatus(String mspin) {
		// TODO Auto-generated method stub
		return participantrepository.updatePraaarambhtStatus( mspin);
	}
	public List<ParticipantRegistration> updateOnHold(Date dateFrom, Date dateTo) {
		// TODO Auto-generated method stub
		return participantrepository.updateOnHold( dateFrom, dateTo );
	}
	public List<ParticipantRegistration> updateAll(List<ParticipantRegistration> list) {
		// TODO Auto-generated method stub
		return participantrepository.saveAll(list);
	}
	public List<ParticipantRegistration> findByhreIdPendinApproverFSDM(List<Long> hreId, Date dateFrom,
			Date dateTo) {
		// TODO Auto-generated method stub
		return participantrepository.findByhreIdPendinApproverFSDM(hreId,dateFrom,dateTo);
	}
	
	public Optional<ParticipantRegistration> findByMSPIN(String mspin) {
		// TODO Auto-generated method stub
		return participantrepository.findByMSPIN(mspin);
	}
	public List<ParticipantRegistration> findByMSPIN() {
		// TODO Auto-generated method stub
		return participantrepository.findByMSPIN();
	}
	public int updatePraaarambhtStatus(String mspin, Date d) {
		 participantrepository.updatePraaarambhtStatus(mspin,d);
		return 1;
	}
	public List<ParticipantRegistration> getAllPraaramStatusPendin() {
		// TODO Auto-generated method stub
		return participantrepository.getAllPraaramStatusPendin();
	}
	*/
	public List<ParticipantRegistration> findAllParticipantsByYear(LocalDate fromDate, LocalDate toDate) {
		return participantrepository.findAllParticipantsByYear(fromDate, toDate);
	}
	
	public List<ParticipantRegistration> getParticipantForDetailedByYears(Long adminId, LocalDate fromDate, LocalDate toDate) {
		return participantrepository.getParticipantForDetailedByYears(adminId, fromDate, toDate);
	}
	public int updateQuestionReportStatus(String accesskey) {
		return participantrepository.updateQuestionReportStatus(accesskey);
	}
	public Optional<ParticipantRegistration> findByEmployeeCode(String employeeCode,Long hreId) {
		return participantrepository.findByEmployeeCode( employeeCode,hreId);
	}
	
	public List<ParticipantRegistration> getHoldEmployee(long hreId, String status, LocalDate dateFrom, LocalDate dateTo) {
		return  participantrepository.getHoldEmployee( hreId,  status, dateFrom, dateTo);
	}
	public List<ParticipantRegistration> getHoldParticipantsByFilterHRE(long hreId, LocalDate from,
			LocalDate to) {
		return participantrepository.getHoldParticipantsByFilterHRE(hreId,from,to);
	}
	public List<ParticipantRegistration> getAllParticipantsPendingForApproval(LocalDate fromDate, LocalDate toDate) {
		return participantrepository.getParticipantPendingApproval(fromDate, toDate);
	}
	
	
	
}
