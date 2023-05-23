package com.armezo.duflon.csv;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.DataList;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.LineManager;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.Region;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Services.AccessKeyMasterService;
import com.armezo.duflon.Services.DataListService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.WorkExperienceService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class NewCandidate{
	/*
}
    @Autowired
    AccessKeyMasterService accessKeyMasterService;
    @Autowired
    ParticipantServiceImpl participantService;
    @Autowired
    HREService hreService;
    @Autowired
    InterviewScoreService interviewScoreService;
    @Autowired
    WorkExperienceService workExperienceService;
    @Autowired
    DataListService dataListService;
    
    @PostMapping({ "/onHoldCSV" })
    @ResponseBody
    public ResponseEntity<?> getCSVOnHold(@RequestParam("outlet") String outletCode, @RequestParam("candidate") String candidateName, @RequestParam("unique") String uniqueCode, @RequestParam("desig") String designation, @RequestParam("mspinS") String mspin, @RequestParam("pass") final String passFailStatus, @RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, @RequestParam(required = false) final String interview, @RequestParam(required = false) final String prarambh, @RequestParam(required = false) final String fsdm, final HttpSession session, final Model model) throws FileNotFoundException {
        if (session.getAttribute("userId") != null) {
            final XSSFWorkbook workbook = new XSSFWorkbook();
            final XSSFSheet sheet = workbook.createSheet("On Hold");
            final XSSFCellStyle style = workbook.createCellStyle();
            final XSSFFont font = workbook.createFont();
            font.setBold(true);
            style.setFont((Font)font);
            Row row = null;
            row = (Row)sheet.createRow(0);
            Cell cell = null;
            cell = row.createCell(0);
            cell.setCellValue("S. No.");
            cell = row.createCell(1);
            cell.setCellValue("Region");
            cell = row.createCell(2);
            cell.setCellValue("Dealer Code");
            cell = row.createCell(3);
            cell.setCellValue("Dealer City");
            cell = row.createCell(4);
            cell.setCellValue("Dealer Name");
            cell = row.createCell(5);
            cell.setCellValue("State");
            cell = row.createCell(6);
            cell.setCellValue("Employee Code");
            cell = row.createCell(7);
            cell.setCellValue("Title");
            cell = row.createCell(8);
            cell.setCellValue("Candidate Name");
            cell = row.createCell(9);
            cell.setCellValue("Profile");
            cell = row.createCell(10);
            cell.setCellValue("Designation Code");
            cell = row.createCell(11);
            cell.setCellValue("Designation Description");
            cell = row.createCell(12);
            cell.setCellValue("MSPIN");
            cell = row.createCell(13);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(14);
            cell.setCellValue("Email Id");
            cell = row.createCell(15);
            cell.setCellValue("Access Key");
            cell = row.createCell(16);
            cell.setCellValue("Registration Date");
            cell = row.createCell(17);
            cell.setCellValue("Assessment Completion Date");
            cell = row.createCell(18);
            cell.setCellValue("Aptitude");
            cell = row.createCell(19);
            cell.setCellValue("Attitude");
            cell = row.createCell(20);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(21);
            cell.setCellValue("Re-attemp");
            cell = row.createCell(22);
            cell.setCellValue("Interview Date");
            cell = row.createCell(23);
            cell.setCellValue("Interview Score");
            cell = row.createCell(24);
            cell.setCellValue("Registration Form");
            cell = row.createCell(25);
            cell.setCellValue("Praarambh Status");
            cell = row.createCell(26);
            cell.setCellValue("FSDM Approval");
            cell = row.createCell(27);
            cell.setCellValue("Recruitment Stage");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            Date dateFrom = null;
            Date dateTo = null;
            final List<Integer> passFStatus = new ArrayList<Integer>();
            final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                if (dateFromm != null && dateFromm != "") {
                    dateFrom = sdf.parse(dateFromm);
                }
                if (dateToo != null && dateToo != "") {
                    dateTo = sdf.parse(dateToo);
                    dateTo = DataProccessor.addTimeInDate(dateTo);
                }
            }
            catch (ParseException e) {
                e.printStackTrace();
            }
            if (outletCode == null) {
                outletCode = "";
            }
            if (candidateName == null) {
                candidateName = "";
            }
            if (uniqueCode == null) {
                uniqueCode = "";
            }
            if (designation == null) {
                designation = "";
            }
         
            if (passFailStatus == "" || passFailStatus == ",") {
                passFStatus.add(1);
                passFStatus.add(0);
            }
            else {
                
                passFStatus.add(Integer.valueOf(passFailStatus));
            }
         
            final String role = session.getAttribute("role").toString();
            final String status = "H";
            List<ParticipantRegistration> participantList = new ArrayList<ParticipantRegistration>();
            if (role.equalsIgnoreCase("HRE")) {
                final Long hreId = Long.parseLong(session.getAttribute("userId").toString());
                if (dateFrom != null && dateTo != null) {
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantOnHoldByFilterData(outletCode, candidateName, designation, mspin, (List)passFStatus, uniqueCode, hreId, dateFrom, dateTo, "H");
                }
                else {
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantOnHoldByFilterData2(outletCode, candidateName, designation, mspin, (List)passFStatus, hreId, uniqueCode, "H");
                }
            }
                
            int count = 1;
            final Map<String, String> desgMap = new HashMap<String, String>();
            
            final Map<String, String> listMap = new HashMap<String, String>();
            final List<DataList> listDms = (List<DataList>)this.dataListService.getAllDataList();
            for (final DataList list3 : listDms) {
                listMap.put(list3.getListCode(), list3.getListDesc());
            }
            if (interview.equalsIgnoreCase("interview")) {
                final List<ParticipantRegistration> intList = new ArrayList<ParticipantRegistration>();
                for (final ParticipantRegistration p2 : participantList) {
                    if (p2.getInterviewScore() != null && p2.getInterviewScore() > 0) {
                        intList.add(p2);
                    }
                }
            }
                participantList.clear();
                participantList.addAll(intList);
            
          /*  if (prarambh.equalsIgnoreCase("prarambh") || prarambh.length() > 5) {
                final List<ParticipantRegistration> pList = new ArrayList<ParticipantRegistration>();
                for (final ParticipantRegistration p2 : participantList) {
                    if (p2.getPrarambhStatus() != null && p2.getPrarambhStatus().equals("2")) {
                        pList.add(p2);
                    }
                }
                participantList.clear();
                participantList.addAll(pList);
            }
            if (fsdm.equalsIgnoreCase("fsdm")) {
                final List<ParticipantRegistration> fList = new ArrayList<ParticipantRegistration>();
                for (final ParticipantRegistration p2 : participantList) {
                    if (p2.getFsdmApprovalStatus() != null && p2.getFsdmApprovalStatus().equals("1")) {
                        fList.add(p2);
                    }
                }
                participantList.clear();
                participantList.addAll(fList);
            }
            for (final ParticipantRegistration pr : participantList) {
                row = (Row)sheet.createRow(count);
                cell = row.createCell(0);
                cell.setCellValue((double)count);
                final Optional<Outlet> ot = (Optional<Outlet>)this.outletService.getOutletByOutletCodeAndhreId(pr.getOutletCode(), pr.gethreId());
                Outlet outlet4 = null;
                if (ot.isPresent()) {
                    outlet4 = ot.get();
                }
                if (outlet4 != null) {
                    cell = row.createCell(1);
                    cell.setCellValue(outlet4.getRegion().getRegionCode());
                    cell = row.createCell(2);
                    cell.setCellValue(outlet4.getOutletCode());
                    cell = row.createCell(3);
                    cell.setCellValue(outlet4.getCity().getCityName());
                    cell = row.createCell(4);
                    cell.setCellValue(outlet4.getOutletName());
                    cell = row.createCell(5);
                    cell.setCellValue(outlet4.getState().getStateName());
                }
                else {
                    cell = row.createCell(1);
                    cell.setCellValue("");
                    cell = row.createCell(2);
                    cell.setCellValue("");
                    cell = row.createCell(3);
                    cell.setCellValue("");
                    cell = row.createCell(4);
                    cell.setCellValue("");
                    cell = row.createCell(5);
                    cell.setCellValue("");
                }
                cell = row.createCell(6);
                cell.setCellValue(pr.getEmployeeCode());
                cell = row.createCell(7);
                if (pr.getTitle() != null && pr.getTitle() != "") {
                    cell.setCellValue((String)listMap.get(pr.getTitle()));
                }
                else {
                    cell.setCellValue("");
                }
                String name = pr.getFirstName();
                if (pr.getMiddleName() != null) {
                    name = String.valueOf(name) + " " + pr.getMiddleName();
                }
                name = String.valueOf(name) + " " + pr.getLastName();
                cell = row.createCell(8);
                cell.setCellValue(name);
                cell = row.createCell(9);
                cell.setCellValue(pr.getDesignation());
                cell = row.createCell(10);
                cell.setCellValue(pr.getFinalDesignation());
                cell = row.createCell(11);
                if (pr.getFinalDesignation() != null && pr.getFinalDesignation() != "") {
                    cell.setCellValue((String)desgMap.get(pr.getFinalDesignation()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(12);
                cell.setCellValue(pr.getMspin());
                cell = row.createCell(13);
                cell.setCellValue(pr.getMobile());
                cell = row.createCell(14);
                cell.setCellValue(pr.getEmail());
                cell = row.createCell(15);
                cell.setCellValue(pr.getAccessKey());
                cell = row.createCell(16);
                if (pr.getRegistration_date() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getRegistration_date()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(17);
                if (pr.getTestCompletionDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
                }
                else {
                    cell.setCellValue("");
                }
                if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales")) {
                    cell = row.createCell(18);
                    cell.setCellValue((double)pr.getAptitudeScore());
                    cell = row.createCell(19);
                    cell.setCellValue((double)pr.getAttitudeScore());
                    cell = row.createCell(20);
                    if (pr.getTestStatus() != null && pr.getTestStatus().equalsIgnoreCase("3")) {
                        if (pr.getPassFailStatus() == 1) {
                            cell.setCellValue("Pass");
                        }
                        else if (pr.getPassFailStatus() == 0) {
                            cell.setCellValue("Fail");
                        }
                    }
                    else {
                        cell.setCellValue("");
                    }
                }
                else if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales Support")) {
                    cell = row.createCell(18);
                    cell.setCellValue("NA");
                    cell = row.createCell(19);
                    cell.setCellValue("NA");
                    cell = row.createCell(20);
                    cell.setCellValue("NA");
                }
                cell = row.createCell(21);
                if (pr.getReAtampStatus() == null) {
                    cell.setCellValue("No");
                }
                else {
                    cell.setCellValue("Yes");
                }
                cell = row.createCell(22);
                if (pr.getInterviewDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(23);
                final Optional<InterviewScore> intScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(pr.getAccessKey());
                if (intScore.isPresent()) {
                    cell.setCellValue(intScore.get().getTotal());
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(24);
                if (pr.getRegStatus() != null) {
                    cell.setCellValue("Yes");
                }
                else {
                    cell.setCellValue("No");
                }
                cell = row.createCell(25);
                String praarambhStatus = "";
                if (pr.getPrarambhStatus() != null && pr.getPrarambhStatus() != "") {
                    if (pr.getPrarambhStatus().equals("1")) {
                        praarambhStatus = "Pending";
                    }
                    if (pr.getPrarambhStatus().equals("2")) {
                        praarambhStatus = "Completed";
                    }
                }
                cell.setCellValue(praarambhStatus);
                cell = row.createCell(26);
                if (pr.getFsdmApprovalStatus() != null) {
                    if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 1) {
                        cell.setCellValue("Rejected");
                    }
                    else if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 3) {
                        cell.setCellValue("Pending");
                    }
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(27);
                String recruitmentStage = "";
                if (pr.getTestStatus() != null && (pr.getTestStatus().equals("1") || pr.getTestStatus().equals("2") || pr.getTestStatus().equals("3"))) {
                    recruitmentStage = "In Progress";
                }
                if (pr.getStatus() != null && pr.getStatus().equalsIgnoreCase("H")) {
                    recruitmentStage = "On Hold";
                }
                if (pr.getFsdmApprovalStatus() != null && pr.getFsdmApprovalStatus().equalsIgnoreCase("2")) {
                    recruitmentStage = "Approved";
                }
                cell.setCellValue(recruitmentStage);
                ++count;
            }
            
            String fileName = DataProccessor.getReportName("On Hold");
            String responseExcelUrl = fileName+".csv";
         			try (FileOutputStream outputStream = new FileOutputStream(responseExcelUrl)) {
         				workbook.write(outputStream);
         			} catch (Exception e) {
         				e.printStackTrace();
         			}
                     final File file = new File(fileName+".csv");
                     final HttpHeaders header = new HttpHeaders();
                     header.add("Content-Disposition", "attachment; filename= "+fileName+".csv");
                     header.add("Cache-Control", "no-cache, no-store, must-revalidate");
                     header.add("Pragma", "no-cache");
                     header.add("Expires", "0");
                     final InputStreamResource resource = new InputStreamResource((InputStream)new FileInputStream(file));
                     return (ResponseEntity<?>)((ResponseEntity.BodyBuilder)ResponseEntity.ok().headers(header)).contentLength(file.length()).contentType(MediaType.parseMediaType("application/octet-stream")).body((Object)resource);
                 
        }
        return null;
    }
    
    @PostMapping({ "/inProgressCSV" })
    @ResponseBody
    public ResponseEntity<?> inProgressCandidate(@RequestParam("outlet") String outletCode, @RequestParam("candidate") String candidateName, @RequestParam("unique") String uniqueCode, @RequestParam("desig") String designation, @RequestParam("mspinS") String mspin, @RequestParam("pass") final String passFailStatus, @RequestParam("dateFromm") final String dateFromm, @RequestParam(required = false) final String interview, @RequestParam(required = false) final String prarambh, @RequestParam(required = false) final String fsdm, @RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model) throws FileNotFoundException {
        if (session.getAttribute("userId") != null) {
            final XSSFWorkbook workbook = new XSSFWorkbook();
            final XSSFSheet sheet = workbook.createSheet("In Progress");
            final XSSFCellStyle style = workbook.createCellStyle();
            final XSSFFont font = workbook.createFont();
            font.setBold(true);
            style.setFont((Font)font);
            Row row = null;
            row = (Row)sheet.createRow(0);
            Cell cell = null;
            cell = row.createCell(0);
            cell.setCellValue("S. No.");
            cell = row.createCell(1);
            cell.setCellValue("Region");
            cell = row.createCell(2);
            cell.setCellValue("Dealer Code");
            cell = row.createCell(3);
            cell.setCellValue("Dealer City");
            cell = row.createCell(4);
            cell.setCellValue("Dealer Name");
            cell = row.createCell(5);
            cell.setCellValue("State");
            cell = row.createCell(6);
            cell.setCellValue("Employee Code");
            cell = row.createCell(7);
            cell.setCellValue("Title");
            cell = row.createCell(8);
            cell.setCellValue("Candidate Name");
            cell = row.createCell(9);
            cell.setCellValue("Profile");
            cell = row.createCell(10);
            cell.setCellValue("Designation Code");
            cell = row.createCell(11);
            cell.setCellValue("Designation Description");
            cell = row.createCell(12);
            cell.setCellValue("MSPIN");
            cell = row.createCell(13);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(14);
            cell.setCellValue("Email Id");
            cell = row.createCell(15);
            cell.setCellValue("Access Key");
            cell = row.createCell(16);
            cell.setCellValue("Registration Date");
            cell = row.createCell(17);
            cell.setCellValue("Assessment Completion Date");
            cell = row.createCell(18);
            cell.setCellValue("Aptitude");
            cell = row.createCell(19);
            cell.setCellValue("Attitude");
            cell = row.createCell(20);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(21);
            cell.setCellValue("Re-attempt");
            cell = row.createCell(22);
            cell.setCellValue("Interview Date");
            cell = row.createCell(23);
            cell.setCellValue("Interview Score");
            cell = row.createCell(24);
            cell.setCellValue("Registration Form");
            cell = row.createCell(25);
            cell.setCellValue("Praarambh Status");
            cell = row.createCell(26);
            cell.setCellValue("FSDM Approval");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            Date dateFrom = null;
            Date dateTo = null;
            final List<Integer> passFStatus = new ArrayList<Integer>();
            final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                if (dateFromm.length() > 5) {
                    dateFrom = sdf.parse(dateFromm);
                }
                if (dateToo.length() > 5) {
                    dateTo = sdf.parse(dateToo);
                    dateTo = DataProccessor.addTimeInDate(dateTo);
                }
            }
            catch (ParseException e) {
                e.printStackTrace();
            }
            if (outletCode == null) {
                outletCode = null;
            }
            if (candidateName == null) {
                candidateName = null;
            }
            if (uniqueCode == null) {
                uniqueCode = null;
            }
            if (designation == null) {
                designation = null;
            }
            if (mspin == null || mspin.equals("")) {
               
            }
            mspin = null;
         
            if (passFailStatus.equals("1") || passFailStatus.equals("0")) {
                passFStatus.add(Integer.valueOf(passFailStatus));
            }
            else {
                passFStatus.add(1);
                passFStatus.add(0);
            }
            final String role = session.getAttribute("role").toString();
            List<ParticipantRegistration> partList = new ArrayList<ParticipantRegistration>();
            List<Outlet> outletList = null;
            if (role.equalsIgnoreCase("HRE")) {
                final Long hreId = Long.parseLong(session.getAttribute("userId").toString());
                if (dateFrom != null && dateTo != null) {
                    partList = (List<ParticipantRegistration>)this.participantService.getParticipantFilterInpprocess(outletCode, candidateName, designation, mspin, (List)passFStatus, uniqueCode, hreId, dateFrom, dateTo);
                }
                else {
                    partList = (List<ParticipantRegistration>)this.participantService.getParticipantByFilterData2(outletCode, candidateName, designation, mspin, (List)passFStatus, hreId, uniqueCode);
                }
            }
            else if (role.equalsIgnoreCase("LM")) {
                final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
                final List<Long> list = new ArrayList<Long>();
                final Optional<LineManager> f = (Optional<LineManager>)this.fsdmservice.getFSDM(fsdmId);
                for (final Region r : f.get().getRegion()) {
                    outletList = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
                    for (final Outlet outlet3 : outletList) {
                        list.add(outlet3.getDealer().getId());
                    }
                }
                List<ParticipantRegistration> participantList = new ArrayList<ParticipantRegistration>();
                if (dateFrom != null && dateTo != null) {
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantByFilterDataForFSDM(outletCode, candidateName, designation, mspin, (List)passFStatus, uniqueCode, (List)list, dateFrom, dateTo);
                }
                else {
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantByFilterDataForFSDM2(outletCode, candidateName, designation, mspin, (List)passFStatus, (List)list, uniqueCode);
                }
                for (final ParticipantRegistration p : participantList) {
                    if (p.getTestStatus() != null && Integer.parseInt(p.getTestStatus()) == 3 && (p.getFsdmApprovalStatus() == null || Integer.parseInt(p.getFsdmApprovalStatus()) == 1) && (p.getStatus() == null || !p.getStatus().equals("H"))) {
                        partList.add(p);
                    }
                }
            }
            final Map<String, String> desgMap = new HashMap<String, String>();
            final List<Designation> listDesg = (List<Designation>)this.designationService.getAll();
            for (final Designation list2 : listDesg) {
                desgMap.put(list2.getDesignationCode(), list2.getDesignationName());
            }
            final Map<String, String> listMap = new HashMap<String, String>();
            final List<ListDms> listDms = (List<ListDms>)this.listService.getAllListDms();
            for (final ListDms list3 : listDms) {
                listMap.put(list3.getListCode(), list3.getListDesc());
            }
            if (interview.equalsIgnoreCase("interview")) {
                final List<ParticipantRegistration> intList = new ArrayList<ParticipantRegistration>();
                for (final ParticipantRegistration p2 : partList) {
                    if (p2.getInterviewScore() != null && p2.getInterviewScore() > 0) {
                        intList.add(p2);
                    }
                }
                partList.clear();
                partList.addAll(intList);
            }
            if (prarambh.equalsIgnoreCase("prarambh") || prarambh.length() > 5) {
                final List<ParticipantRegistration> pList = new ArrayList<ParticipantRegistration>();
                for (final ParticipantRegistration p2 : partList) {
                    if (p2.getPrarambhStatus() != null && p2.getPrarambhStatus().equals("2")) {
                        pList.add(p2);
                    }
                }
                partList.clear();
                partList.addAll(pList);
            }
            if (fsdm.equalsIgnoreCase("fsdm")) {
                final List<ParticipantRegistration> fList = new ArrayList<ParticipantRegistration>();
                for (final ParticipantRegistration p2 : partList) {
                    if (p2.getFsdmApprovalStatus() != null && p2.getFsdmApprovalStatus().equals("1")) {
                        fList.add(p2);
                    }
                }
                partList.clear();
                partList.addAll(fList);
            }
            int count = 1;
            for (final ParticipantRegistration pr : partList) {
                row = (Row)sheet.createRow(count);
                cell = row.createCell(0);
                cell.setCellValue((double)count);
                final Optional<Outlet> ot = (Optional<Outlet>)this.outletService.getOutletByOutletCodeAndhreId(pr.getOutletCode(), pr.gethreId());
                Outlet outlet4 = null;
                if (ot.isPresent()) {
                    outlet4 = ot.get();
                }
                if (outlet4 != null) {
                    cell = row.createCell(1);
                    cell.setCellValue(outlet4.getRegion().getRegionCode());
                    cell = row.createCell(2);
                    cell.setCellValue(outlet4.getOutletCode());
                    cell = row.createCell(3);
                    cell.setCellValue(outlet4.getCity().getCityName());
                    cell = row.createCell(4);
                    cell.setCellValue(outlet4.getOutletName());
                    cell = row.createCell(5);
                    cell.setCellValue(outlet4.getState().getStateName());
                }
                else {
                    cell = row.createCell(1);
                    cell.setCellValue("");
                    cell = row.createCell(2);
                    cell.setCellValue("");
                    cell = row.createCell(3);
                    cell.setCellValue("");
                    cell = row.createCell(4);
                    cell.setCellValue("");
                    cell = row.createCell(5);
                    cell.setCellValue("");
                }
                cell = row.createCell(6);
                cell.setCellValue(pr.getEmployeeCode());
                cell = row.createCell(7);
                if (pr.getTitle() != null && pr.getTitle() != "") {
                    cell.setCellValue((String)listMap.get(pr.getTitle()));
                }
                else {
                    cell.setCellValue("");
                }
                String name = pr.getFirstName();
                if (pr.getMiddleName() != null) {
                    name = String.valueOf(name) + " " + pr.getMiddleName();
                }
                name = String.valueOf(name) + " " + pr.getLastName();
                cell = row.createCell(8);
                cell.setCellValue(name);
                cell = row.createCell(9);
                cell.setCellValue(pr.getDesignation());
                cell = row.createCell(10);
                cell.setCellValue(pr.getFinalDesignation());
                cell = row.createCell(11);
                if (pr.getFinalDesignation() != null && pr.getFinalDesignation() != "") {
                    cell.setCellValue((String)desgMap.get(pr.getFinalDesignation()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(12);
                cell.setCellValue(pr.getMspin());
                cell = row.createCell(13);
                cell.setCellValue(pr.getMobile());
                cell = row.createCell(14);
                cell.setCellValue(pr.getEmail());
                cell = row.createCell(15);
                cell.setCellValue(pr.getAccessKey());
                cell = row.createCell(16);
                if (pr.getRegistration_date() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getRegistration_date()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(17);
                if (pr.getTestCompletionDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
                }
                else {
                    cell.setCellValue("");
                }
                if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales")) {
                    cell = row.createCell(18);
                    cell.setCellValue((double)pr.getAptitudeScore());
                    cell = row.createCell(19);
                    cell.setCellValue((double)pr.getAttitudeScore());
                    cell = row.createCell(20);
                    if (pr.getTestStatus() != null && pr.getTestStatus().equalsIgnoreCase("3")) {
                        if (pr.getPassFailStatus() == 1) {
                            cell.setCellValue("Pass");
                        }
                        else if (pr.getPassFailStatus() == 0) {
                            cell.setCellValue("Fail");
                        }
                    }
                    else {
                        cell.setCellValue("");
                    }
                }
                else if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales Support")) {
                    cell = row.createCell(18);
                    cell.setCellValue("NA");
                    cell = row.createCell(19);
                    cell.setCellValue("NA");
                    cell = row.createCell(20);
                    cell.setCellValue("NA");
                }
                cell = row.createCell(21);
                if (pr.getReAtampStatus() == null) {
                    cell.setCellValue("No");
                }
                else {
                    cell.setCellValue("Yes");
                }
                cell = row.createCell(22);
                if (pr.getInterviewDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(23);
                final Optional<InterviewScore> intScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(pr.getAccessKey());
                if (intScore.isPresent()) {
                    cell.setCellValue(intScore.get().getTotal());
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(24);
                if (pr.getRegStatus() != null) {
                    cell.setCellValue("Yes");
                }
                else {
                    cell.setCellValue("No");
                }
                cell = row.createCell(25);
                String praarambhStatus = "";
                if (pr.getPrarambhStatus() != null && pr.getPrarambhStatus() != "") {
                    if (pr.getPrarambhStatus().equals("1")) {
                        praarambhStatus = "Pending";
                    }
                    if (pr.getPrarambhStatus().equals("2")) {
                        praarambhStatus = "Completed";
                    }
                }
                cell.setCellValue(praarambhStatus);
                cell = row.createCell(26);
                if (pr.getFsdmApprovalStatus() != null) {
                    if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 1) {
                        cell.setCellValue("Rejected");
                    }
                    else if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 3) {
                        cell.setCellValue("Pending");
                    }
                }
                else {
                    cell.setCellValue("");
                }
                ++count;
            }
            
            String  fileName = DataProccessor.getReportName("In Progress");
            String responseExcelUrl = fileName+".csv";
			try (FileOutputStream outputStream = new FileOutputStream(responseExcelUrl)) {
				workbook.write(outputStream);
			} catch (Exception e) {
				e.printStackTrace();
			}
            final File file = new File(fileName+".csv");
            final HttpHeaders header = new HttpHeaders();
            header.add("Content-Disposition", "attachment; filename= "+fileName+".csv");
            header.add("Cache-Control", "no-cache, no-store, must-revalidate");
            header.add("Pragma", "no-cache");
            header.add("Expires", "0");
            final InputStreamResource resource = new InputStreamResource((InputStream)new FileInputStream(file));
            return (ResponseEntity<?>)((ResponseEntity.BodyBuilder)ResponseEntity.ok().headers(header)).contentLength(file.length()).contentType(MediaType.parseMediaType("application/octet-stream")).body((Object)resource);
        }
        return null;
    }
    
    @PostMapping({ "/csvEmployee" })
    @ResponseBody
    public ResponseEntity<?> getCSVEmployee(@RequestParam("outlet") String outletCode, @RequestParam("candidate") String candidateName, @RequestParam("unique") String uniqueCode, @RequestParam("desig") String designation, @RequestParam("mspinS") String mspin, @RequestParam("pass") final String passFailStatus, @RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model) throws FileNotFoundException {
        if (session.getAttribute("userId") != null) {
            final XSSFWorkbook workbook = new XSSFWorkbook();
            final XSSFSheet sheet = workbook.createSheet("Employee Master");
            final XSSFCellStyle style = workbook.createCellStyle();
            final XSSFFont font = workbook.createFont();
            font.setBold(true);
            style.setFont((Font)font);
            Row row = null;
            row = (Row)sheet.createRow(0);
            Cell cell = null;
            cell = row.createCell(0);
            cell.setCellValue("S. No.");
            cell = row.createCell(1);
            cell.setCellValue("Region");
            cell = row.createCell(2);
            cell.setCellValue("Dealer Code");
            cell = row.createCell(3);
            cell.setCellValue("Dealer City");
            cell = row.createCell(4);
            cell.setCellValue("Dealer Name");
            cell = row.createCell(5);
            cell.setCellValue("State");
            cell = row.createCell(6);
            cell.setCellValue("Employee Code");
            cell = row.createCell(7);
            cell.setCellValue("Title");
            cell = row.createCell(8);
            cell.setCellValue("Candidate Name");
            cell = row.createCell(9);
            cell.setCellValue("Profile");
            cell = row.createCell(10);
            cell.setCellValue("Designation Code");
            cell = row.createCell(11);
            cell.setCellValue("Designation Description");
            cell = row.createCell(12);
            cell.setCellValue("MSPIN");
            cell = row.createCell(13);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(14);
            cell.setCellValue("Email Id");
            cell = row.createCell(15);
            cell.setCellValue("Access Key");
            cell = row.createCell(16);
            cell.setCellValue("Registration Date");
            cell = row.createCell(17);
            cell.setCellValue("Assessment Completion Date");
            cell = row.createCell(18);
            cell.setCellValue("Aptitude");
            cell = row.createCell(19);
            cell.setCellValue("Attitude");
            cell = row.createCell(20);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(21);
            cell.setCellValue("Re-attemp");
            cell = row.createCell(22);
            cell.setCellValue("Interview Date");
            cell = row.createCell(23);
            cell.setCellValue("Interview Score");
            cell = row.createCell(24);
            cell.setCellValue("Registration Form");
            cell = row.createCell(25);
            cell.setCellValue("Praarambh Status");
            cell = row.createCell(26);
            cell.setCellValue("FSDM Approval");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            Date dateFrom = null;
            Date dateTo = null;
            final Long hreId = Long.parseLong(session.getAttribute("userId").toString());
            final List<Integer> passFStatus = new ArrayList<Integer>();
            final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                if (dateFromm != null && dateFromm != "") {
                    dateFrom = sdf.parse(dateFromm);
                }
                if (dateToo != null && dateToo != "") {
                    dateTo = sdf.parse(dateToo);
                    dateTo = DataProccessor.addTimeInDate(dateTo);
                }
            }
            catch (ParseException e) {
                e.printStackTrace();
            }
            if (outletCode == null) {
                outletCode = "";
            }
            if (candidateName == null) {
                candidateName = "";
            }
            if (uniqueCode == null) {
                uniqueCode = "";
            }
            if (designation == null) {
                designation = "";
            }
            if (mspin == null || mspin == "") {
                mspin = "";
            }
            if (passFailStatus == "" || passFailStatus == ",") {
                passFStatus.add(1);
                passFStatus.add(0);
            }
            else {
               
                passFStatus.add(Integer.valueOf(passFailStatus));
            }
            final String fsdmApprovalStatus = "2";
            final String role = session.getAttribute("role").toString();
            List<ParticipantRegistration> participantList = null;
            List<Outlet> outletList = null;
            if (role.equalsIgnoreCase("HRE")) {
                outletList = (List<Outlet>)this.outletService.getOutletByhreId(hreId);
                if (dateFrom != null && dateTo != null) {
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantOnEmployeeMasterDealerByFilterData(outletCode, candidateName, designation, mspin, (List)passFStatus, uniqueCode, hreId, dateFrom, dateTo, "2");
                }
                else {
                  
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantOnEmployeeMasterDealerByFilterData(outletCode, candidateName, designation, mspin, (List)passFStatus, uniqueCode, hreId, "2");
                }
            }
            else if (role.equalsIgnoreCase("LM")) {
                final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
                final List<Long> list = new ArrayList<Long>();
                final Optional<LineManager> f = (Optional<LineManager>)this.fsdmservice.getFSDM(fsdmId);
                for (final Region r : f.get().getRegion()) {
                    outletList = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
                    for (final Outlet outlet3 : outletList) {
                        list.add(outlet3.getDealer().getId());
                    }
                }
                if (dateFrom != null && dateTo != null) {
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantByFilterDataForFSDM(outletCode, candidateName, designation, mspin, (List)passFStatus, uniqueCode, (List)list, dateFrom, dateTo);
                }
                else {
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantByFilterDataForFSDM2(outletCode, candidateName, designation, mspin, (List)passFStatus, (List)list, uniqueCode);
                }
            }
            final List<ParticipantRegistration> partList = new ArrayList<ParticipantRegistration>();
            for (final ParticipantRegistration p : participantList) {
                if (p.getTestStatus() != null && Integer.parseInt(p.getTestStatus()) == 3 && p.getFsdmApprovalStatus() != null && Integer.parseInt(p.getFsdmApprovalStatus()) == 2) {
                    partList.add(p);
                }
            }
            final Map<String, String> desgMap = new HashMap<String, String>();
            final List<Designation> listDesg = (List<Designation>)this.designationService.getAll();
            for (final Designation list2 : listDesg) {
                desgMap.put(list2.getDesignationCode(), list2.getDesignationName());
            }
            final Map<String, String> listMap = new HashMap<String, String>();
            final List<ListDms> listDms = (List<ListDms>)this.listService.getAllListDms();
            for (final ListDms list3 : listDms) {
                listMap.put(list3.getListCode(), list3.getListDesc());
            }
            int count = 1;
            for (final ParticipantRegistration pr : partList) {
                row = (Row)sheet.createRow(count);
                cell = row.createCell(0);
                cell.setCellValue((double)count);
                final Optional<Outlet> ot = (Optional<Outlet>)this.outletService.getOutletByOutletCodeAndhreId(pr.getOutletCode(), pr.gethreId());
                Outlet outlet4 = null;
                if (ot.isPresent()) {
                    outlet4 = ot.get();
                }
                if (outlet4 != null) {
                    cell = row.createCell(1);
                    cell.setCellValue(outlet4.getRegion().getRegionCode());
                    cell = row.createCell(2);
                    cell.setCellValue(outlet4.getOutletCode());
                    cell = row.createCell(3);
                    cell.setCellValue(outlet4.getCity().getCityName());
                    cell = row.createCell(4);
                    cell.setCellValue(outlet4.getOutletName());
                    cell = row.createCell(5);
                    cell.setCellValue(outlet4.getState().getStateName());
                }
                else {
                    cell = row.createCell(1);
                    cell.setCellValue("");
                    cell = row.createCell(2);
                    cell.setCellValue("");
                    cell = row.createCell(3);
                    cell.setCellValue("");
                    cell = row.createCell(4);
                    cell.setCellValue("");
                    cell = row.createCell(5);
                    cell.setCellValue("");
                }
                cell = row.createCell(6);
                cell.setCellValue(pr.getEmployeeCode());
                cell = row.createCell(7);
                if (pr.getTitle() != null && pr.getTitle() != "") {
                    cell.setCellValue((String)listMap.get(pr.getTitle()));
                }
                else {
                    cell.setCellValue("");
                }
                String name = pr.getFirstName();
                if (pr.getMiddleName() != null) {
                    name = String.valueOf(name) + " " + pr.getMiddleName();
                }
                name = String.valueOf(name) + " " + pr.getLastName();
                cell = row.createCell(8);
                cell.setCellValue(name);
                cell = row.createCell(9);
                cell.setCellValue(pr.getDesignation());
                cell = row.createCell(10);
                cell.setCellValue(pr.getFinalDesignation());
                cell = row.createCell(11);
                if (pr.getFinalDesignation() != null && pr.getFinalDesignation() != "") {
                    cell.setCellValue((String)desgMap.get(pr.getFinalDesignation()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(12);
                cell.setCellValue(pr.getMspin());
                cell = row.createCell(13);
                cell.setCellValue(pr.getMobile());
                cell = row.createCell(14);
                cell.setCellValue(pr.getEmail());
                cell = row.createCell(15);
                cell.setCellValue(pr.getAccessKey());
                cell = row.createCell(16);
                if (pr.getRegistration_date() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getRegistration_date()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(17);
                if (pr.getTestCompletionDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
                }
                else {
                    cell.setCellValue("");
                }
                if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales")) {
                    cell = row.createCell(18);
                    cell.setCellValue((double)pr.getAptitudeScore());
                    cell = row.createCell(19);
                    cell.setCellValue((double)pr.getAttitudeScore());
                    cell = row.createCell(20);
                    if (pr.getTestStatus() != null && pr.getTestStatus().equalsIgnoreCase("3")) {
                        if (pr.getPassFailStatus() == 1) {
                            cell.setCellValue("Pass");
                        }
                        else if (pr.getPassFailStatus() == 0) {
                            cell.setCellValue("Fail");
                        }
                    }
                    else {
                        cell.setCellValue("");
                    }
                }
                else if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales Support")) {
                    cell = row.createCell(18);
                    cell.setCellValue("NA");
                    cell = row.createCell(19);
                    cell.setCellValue("NA");
                    cell = row.createCell(20);
                    cell.setCellValue("NA");
                }
                cell = row.createCell(21);
                if (pr.getReAtampStatus() == null) {
                    cell.setCellValue("No");
                }
                else {
                    cell.setCellValue("Yes");
                }
                cell = row.createCell(22);
                if (pr.getInterviewDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(23);
                final Optional<InterviewScore> intScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(pr.getAccessKey());
                if (intScore.isPresent()) {
                    cell.setCellValue(intScore.get().getTotal());
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(24);
                if (pr.getRegStatus() != null) {
                    cell.setCellValue("Yes");
                }
                else {
                    cell.setCellValue("No");
                }
                cell = row.createCell(25);
                String praarambhStatus = "";
                if (pr.getPrarambhStatus() != null && pr.getPrarambhStatus() != "") {
                    if (pr.getPrarambhStatus().equals("1")) {
                        praarambhStatus = "Pending";
                    }
                    if (pr.getPrarambhStatus().equals("2")) {
                        praarambhStatus = "Completed";
                    }
                }
                cell.setCellValue(praarambhStatus);
                cell = row.createCell(26);
                if (pr.getFsdmApprovalStatus() != null) {
                    if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 1) {
                        cell.setCellValue("Rejected");
                    }
                    else if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 3) {
                        cell.setCellValue("Pending");
                    }
                    else if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 2) {
                        cell.setCellValue("Approved");
                    }
                }
                else {
                    cell.setCellValue("");
                }
                ++count;
            }
            
            String  fileName = DataProccessor.getReportName("Employee Master");
            String responseExcelUrl = fileName+".csv";
			try (FileOutputStream outputStream = new FileOutputStream(responseExcelUrl)) {
				workbook.write(outputStream);
			} catch (Exception e) {
			e.printStackTrace();
			}
            final File file = new File(fileName+".csv");
            final HttpHeaders header = new HttpHeaders();
            header.add("Content-Disposition", "attachment; filename= "+fileName+".csv");
            header.add("Cache-Control", "no-cache, no-store, must-revalidate");
            header.add("Pragma", "no-cache");
            header.add("Expires", "0");
            final InputStreamResource resource = new InputStreamResource((InputStream)new FileInputStream(file));
            return (ResponseEntity<?>)((ResponseEntity.BodyBuilder)ResponseEntity.ok().headers(header)).contentLength(file.length()).contentType(MediaType.parseMediaType("application/octet-stream")).body((Object)resource);
        }
        return null;
    }
    
    @PostMapping({ "/getCSVPendingApprovel" })
    @ResponseBody
    public ResponseEntity<?> getCSVPendingApprovel(@RequestParam("outlet") String outletCode, @RequestParam("candidate") String candidateName, @RequestParam("unique") String uniqueCode, @RequestParam("desig") String designation, @RequestParam("mspinS") String mspin, @RequestParam("pass") final String passFailStatus, @RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model) throws FileNotFoundException {
        if (session.getAttribute("userId") != null) {
            final XSSFWorkbook workbook = new XSSFWorkbook();
            final XSSFSheet sheet = workbook.createSheet("Pending Approval");
            final XSSFCellStyle style = workbook.createCellStyle();
            final XSSFFont font = workbook.createFont();
            font.setBold(true);
            style.setFont((Font)font);
            Row row = null;
            row = (Row)sheet.createRow(0);
            Cell cell = null;
            cell = row.createCell(0);
            cell.setCellValue("S. No.");
            cell = row.createCell(1);
            cell.setCellValue("Region");
            cell = row.createCell(2);
            cell.setCellValue("Dealer Code");
            cell = row.createCell(3);
            cell.setCellValue("Dealer City");
            cell = row.createCell(4);
            cell.setCellValue("Dealer Name");
            cell = row.createCell(5);
            cell.setCellValue("State");
            cell = row.createCell(6);
            cell.setCellValue("Employee Code");
            cell = row.createCell(7);
            cell.setCellValue("Title");
            cell = row.createCell(8);
            cell.setCellValue("Candidate Name");
            cell = row.createCell(9);
            cell.setCellValue("Profile");
            cell = row.createCell(10);
            cell.setCellValue("Designation Code");
            cell = row.createCell(11);
            cell.setCellValue("Designation Description");
            cell = row.createCell(12);
            cell.setCellValue("MSPIN");
            cell = row.createCell(13);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(14);
            cell.setCellValue("Email Id");
            cell = row.createCell(15);
            cell.setCellValue("Access Key");
            cell = row.createCell(16);
            cell.setCellValue("Registration Date");
            cell = row.createCell(17);
            cell.setCellValue("Assessment Completion Date");
            cell = row.createCell(18);
            cell.setCellValue("Aptitude");
            cell = row.createCell(19);
            cell.setCellValue("Attitude");
            cell = row.createCell(20);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(21);
            cell.setCellValue("Re-attemp");
            cell = row.createCell(22);
            cell.setCellValue("Interview Date");
            cell = row.createCell(23);
            cell.setCellValue("Interview Score");
            cell = row.createCell(24);
            cell.setCellValue("Registration Form");
            cell = row.createCell(25);
            cell.setCellValue("Praarambh Status");
            cell = row.createCell(26);
            cell.setCellValue("FSDM Approval");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            Date dateFrom = null;
            Date dateTo = null;
            final List<Integer> passFStatus = new ArrayList<Integer>();
            final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
            	System.out.println("cal...................."+dateFromm+"...."+dateToo);
                if (dateFromm != null && dateFromm.length()>1) {
                	System.out.println("cal.....if...............");
                    dateFrom = sdf.parse(dateFromm);
                }
                if (dateToo != null && dateToo.length()>1) {
                    dateTo = sdf.parse(dateToo);
                    dateTo = DataProccessor.addTimeInDate(dateTo);
                }
                System.out.println("cal...................");
            }
           
            catch (ParseException e) {
                e.printStackTrace();
            }
            if (outletCode == null) {
                outletCode = "";
            }
            if (candidateName == null) {
                candidateName = "";
            }
            if (uniqueCode == null) {
                uniqueCode = "";
            }
            if (designation == null) {
                designation = "";
            }
            if (mspin == null || mspin == "") {
               
            }
            mspin = "";
           
            if (passFailStatus == "" || passFailStatus == ",") {
                passFStatus.add(1);
                passFStatus.add(0);
            }
            else {
             
                passFStatus.add(Integer.valueOf(passFailStatus));
            }
            String role = "";
            List<ParticipantRegistration> partList = new ArrayList<ParticipantRegistration>();
            if (session.getAttribute("role") != null) {
                role = session.getAttribute("role").toString().trim();
            }
            if (role.equalsIgnoreCase("LM")) {
                int fsdmId = 0;
                if (session.getAttribute("userId") != null) {
                    fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
                }
                final Optional<LineManager> f = (Optional<LineManager>)this.fsdmservice.getFSDM(fsdmId);
                final List<Long> list = new ArrayList<Long>();
                for (final Region r : f.get().getRegion()) {
                    final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
                    for (final Outlet outlet : outletLsit) {
                        list.add(outlet.getDealer().getId());
                    }
                }
                List<ParticipantRegistration> fsdmPart = null;
                if (dateFrom != null && dateTo != null) {
                    fsdmPart = (List<ParticipantRegistration>)this.participantService.getParticipantByFilterDataForFSDM(outletCode, candidateName, designation, mspin, (List)passFStatus, uniqueCode, (List)list, dateFrom, dateTo);
                }
                else {
                    fsdmPart = (List<ParticipantRegistration>)this.participantService.getParticipantByFilterDataForFSDM2(outletCode, candidateName, designation, mspin, (List)passFStatus, (List)list, uniqueCode);
                }
                for (final ParticipantRegistration p : fsdmPart) {
                    if (p.getTestStatus() != null && Integer.parseInt(p.getTestStatus()) == 3 && p.getFsdmApprovalStatus() != null && Integer.parseInt(p.getFsdmApprovalStatus()) == 3 && (p.getStatus() == null || !p.getStatus().equals("H"))) {
                        partList.add(p);
                    }
                }
            }
            else if (role.equalsIgnoreCase("HO")) {
                partList = (List<ParticipantRegistration>)this.participantService.getParticipantPendingApprovel();
            }
            int count = 1;
            final Map<String, String> desgMap = new HashMap<String, String>();
            final List<Designation> listDesg = (List<Designation>)this.designationService.getAll();
            for (final Designation list2 : listDesg) {
                desgMap.put(list2.getDesignationCode(), list2.getDesignationName());
            }
            final Map<String, String> listMap = new HashMap<String, String>();
            final List<ListDms> listDms = (List<ListDms>)this.listService.getAllListDms();
            for (final ListDms list3 : listDms) {
                listMap.put(list3.getListCode(), list3.getListDesc());
            }
            for (final ParticipantRegistration pr : partList) {
                row = (Row)sheet.createRow(count);
                cell = row.createCell(0);
                cell.setCellValue((double)count);
                final Optional<Outlet> ot = (Optional<Outlet>)this.outletService.getOutletByOutletCodeAndhreId(pr.getOutletCode(), pr.gethreId());
                Outlet outlet2 = null;
                if (ot.isPresent()) {
                    outlet2 = ot.get();
                }
                if (outlet2 != null) {
                    cell = row.createCell(1);
                    cell.setCellValue(outlet2.getRegion().getRegionCode());
                    cell = row.createCell(2);
                    cell.setCellValue(outlet2.getOutletCode());
                    cell = row.createCell(3);
                    cell.setCellValue(outlet2.getCity().getCityName());
                    cell = row.createCell(4);
                    cell.setCellValue(outlet2.getOutletName());
                    cell = row.createCell(5);
                    cell.setCellValue(outlet2.getState().getStateName());
                }
                else {
                    cell = row.createCell(1);
                    cell.setCellValue("");
                    cell = row.createCell(2);
                    cell.setCellValue("");
                    cell = row.createCell(3);
                    cell.setCellValue("");
                    cell = row.createCell(4);
                    cell.setCellValue("");
                    cell = row.createCell(5);
                    cell.setCellValue("");
                }
                cell = row.createCell(6);
                cell.setCellValue(pr.getEmployeeCode());
                cell = row.createCell(7);
                if (pr.getTitle() != null && pr.getTitle() != "") {
                    cell.setCellValue((String)listMap.get(pr.getTitle()));
                }
                else {
                    cell.setCellValue("");
                }
                String name = pr.getFirstName();
                if (pr.getMiddleName() != null) {
                    name = String.valueOf(name) + " " + pr.getMiddleName();
                }
                name = String.valueOf(name) + " " + pr.getLastName();
                cell = row.createCell(8);
                cell.setCellValue(name);
                cell = row.createCell(9);
                cell.setCellValue(pr.getDesignation());
                cell = row.createCell(10);
                cell.setCellValue(pr.getFinalDesignation());
                cell = row.createCell(11);
                if (pr.getFinalDesignation() != null && pr.getFinalDesignation() != "") {
                    cell.setCellValue((String)desgMap.get(pr.getFinalDesignation()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(12);
                cell.setCellValue(pr.getMspin());
                cell = row.createCell(13);
                cell.setCellValue(pr.getMobile());
                cell = row.createCell(14);
                cell.setCellValue(pr.getEmail());
                cell = row.createCell(15);
                cell.setCellValue(pr.getAccessKey());
                cell = row.createCell(16);
                if (pr.getRegistration_date() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getRegistration_date()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(17);
                if (pr.getTestCompletionDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
                }
                else {
                    cell.setCellValue("");
                }
                if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales")) {
                    cell = row.createCell(18);
                    cell.setCellValue((double)pr.getAptitudeScore());
                    cell = row.createCell(19);
                    cell.setCellValue((double)pr.getAttitudeScore());
                    cell = row.createCell(20);
                    if (pr.getTestStatus() != null && pr.getTestStatus().equalsIgnoreCase("3")) {
                        if (pr.getPassFailStatus() == 1) {
                            cell.setCellValue("Pass");
                        }
                        else if (pr.getPassFailStatus() == 0) {
                            cell.setCellValue("Fail");
                        }
                    }
                    else {
                        cell.setCellValue("");
                    }
                }
                else if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales Support")) {
                    cell = row.createCell(18);
                    cell.setCellValue("NA");
                    cell = row.createCell(19);
                    cell.setCellValue("NA");
                    cell = row.createCell(20);
                    cell.setCellValue("NA");
                }
                cell = row.createCell(21);
                if (pr.getReAtampStatus() == null) {
                    cell.setCellValue("No");
                }
                else {
                    cell.setCellValue("Yes");
                }
                cell = row.createCell(22);
                if (pr.getInterviewDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(23);
                final Optional<InterviewScore> intScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(pr.getAccessKey());
                if (intScore.isPresent()) {
                    cell.setCellValue(intScore.get().getTotal());
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(24);
                if (pr.getRegStatus() != null) {
                    cell.setCellValue("Yes");
                }
                else {
                    cell.setCellValue("No");
                }
                cell = row.createCell(25);
                String praarambhStatus = "";
                if (pr.getPrarambhStatus() != null && pr.getPrarambhStatus() != "") {
                    if (pr.getPrarambhStatus().equals("1")) {
                        praarambhStatus = "Pending";
                    }
                    if (pr.getPrarambhStatus().equals("2")) {
                        praarambhStatus = "Completed";
                    }
                }
                cell.setCellValue(praarambhStatus);
                cell = row.createCell(26);
                if (pr.getFsdmApprovalStatus() != null) {
                    if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 1) {
                        cell.setCellValue("Rejected");
                    }
                    else if (Integer.parseInt(pr.getFsdmApprovalStatus()) == 3) {
                        cell.setCellValue("Pending");
                    }
                }
                else {
                    cell.setCellValue("");
                }
                ++count;
            }
            String fileName = DataProccessor.getReportName("Pending Approval");
            String responseExcelUrl = fileName+".csv";
         			try (FileOutputStream outputStream = new FileOutputStream(responseExcelUrl)) {
         				workbook.write(outputStream);
         			} catch (Exception e) {
         				e.printStackTrace();
         			}
                     final File file = new File(fileName+".csv");
                     final HttpHeaders header = new HttpHeaders();
                     header.add("Content-Disposition", "attachment; filename= "+fileName+".csv");
                     header.add("Cache-Control", "no-cache, no-store, must-revalidate");
                     header.add("Pragma", "no-cache");
                     header.add("Expires", "0");
                     final InputStreamResource resource = new InputStreamResource((InputStream)new FileInputStream(file));
                     return (ResponseEntity<?>)((ResponseEntity.BodyBuilder)ResponseEntity.ok().headers(header)).contentLength(file.length()).contentType(MediaType.parseMediaType("application/octet-stream")).body((Object)resource);
                 
        }
        return null;
    }
    
    @GetMapping({ "/detailedCSV" })
    public ResponseEntity<?> getReportDetailed(@RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model) throws FileNotFoundException {
       
    	Date date1 = null;
        Date date2 = null;
        String fileName="";
        Calendar cal = Calendar.getInstance();
        DateFormat srcDf = new SimpleDateFormat("yyyy-MM-dd");
        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            if (dateFromm != null && dateFromm != "") {
                date1 = sdf.parse(dateFromm);
            }
            if (dateToo != null && dateToo != "") {
                date2 = sdf.parse(dateToo);
                date2 = DataProccessor.addTimeInDate(date2);
            }
        }
        catch (ParseException e) {
            e.printStackTrace();
        }
        if (session.getAttribute("userId") != null) {
            final XSSFWorkbook workbook = new XSSFWorkbook();
            final XSSFSheet sheet = workbook.createSheet("Detailed");
            final XSSFCellStyle style = workbook.createCellStyle();
            final XSSFFont font = workbook.createFont();
            font.setBold(true);
            style.setFont((Font)font);
            
            
            CellStyle cellStyle = workbook.createCellStyle();
            CreationHelper createHelper = workbook.getCreationHelper();
            cellStyle.setDataFormat(
            createHelper.createDataFormat().getFormat("dd-MM-yyyy"));
            Row row = null;
            row = (Row)sheet.createRow(0);
            Cell cell = null;
            cell = row.createCell(0);
            cell.setCellValue("S. No.");
            cell = row.createCell(1);
            cell.setCellValue("Region");
            cell = row.createCell(2);
            cell.setCellValue("Dealer Code");
            cell = row.createCell(3);
            cell.setCellValue("Dealer City");
            cell = row.createCell(4);
            cell.setCellValue("Dealer Name");
            cell = row.createCell(5);
            cell.setCellValue("State");
            cell = row.createCell(6);
            cell.setCellValue("Employee Code");
            cell = row.createCell(7);
            cell.setCellValue("Title");
            cell = row.createCell(8);
            cell.setCellValue("Candidate Name");
            cell = row.createCell(9);
            cell.setCellValue("Profile");
            cell = row.createCell(10);
            cell.setCellValue("Designation Code");
            cell = row.createCell(11);
            cell.setCellValue("Designation Description");
            cell = row.createCell(12);
            cell.setCellValue("MSPIN");
            cell = row.createCell(13);
            cell.setCellValue("Old MSPIN");
            cell = row.createCell(14);
            cell.setCellValue("Gender");
            cell = row.createCell(15);
            cell.setCellValue("DOB");
            cell = row.createCell(16);
            cell.setCellValue("DOJ");
            cell = row.createCell(17);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(18);
            cell.setCellValue("Alternative Contact No.");
            cell = row.createCell(19);
            cell.setCellValue("Email Id");
            cell = row.createCell(20);
            cell.setCellValue("Candidate Status");
            cell = row.createCell(21);
            cell.setCellValue("Recruitment Stage");
            cell = row.createCell(22);
            cell.setCellValue("Remarks");
            cell = row.createCell(23);
            cell.setCellValue("Age (in years)");
            cell = row.createCell(24);
            cell.setCellValue("Pincode");
            cell = row.createCell(25);
            cell.setCellValue("Candidate City");
            cell = row.createCell(26);
            cell.setCellValue("Tehsil");
            cell = row.createCell(27);
            cell.setCellValue("Village");
            cell = row.createCell(28);
            cell.setCellValue("Highest Qualification");
            cell = row.createCell(29);
            cell.setCellValue("Primary Language");
            cell = row.createCell(30);
            cell.setCellValue("Secondary Language");
            cell = row.createCell(31);
            cell.setCellValue("Access Key");
            cell = row.createCell(32);
            cell.setCellValue("Registration Date");
            cell = row.createCell(33);
            cell.setCellValue("Assessment Completion Date");
            cell = row.createCell(34);
            cell.setCellValue("Aptitude Score");
            cell = row.createCell(35);
            cell.setCellValue("Attitude Score");
            cell = row.createCell(36);
            cell.setCellValue("Total Marks");
            cell = row.createCell(37);
            cell.setCellValue("Marks Obtained");
            cell = row.createCell(38);
            cell.setCellValue("Percentage");
            cell = row.createCell(39);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(40);
            cell.setCellValue("Interview Date");
            cell = row.createCell(41);
            cell.setCellValue("Interview Score");
            cell = row.createCell(42);
            cell.setCellValue("Interview Status");
            cell = row.createCell(43);
            cell.setCellValue("Praarambh Status");
            cell = row.createCell(44);
            cell.setCellValue("FSDM Approval Status");
            cell = row.createCell(45);
            cell.setCellValue("FSDM Rejection Reason");
            cell = row.createCell(46);
            cell.setCellValue("FSDM Approval Date");
            cell = row.createCell(47);
            cell.setCellValue("Ownership of Two Wheeler");
            cell = row.createCell(48);
            cell.setCellValue("Ownership of Four Wheeler");
            cell = row.createCell(49);
            cell.setCellValue("Knows driving Two Wheeler");
            cell = row.createCell(50);
            cell.setCellValue("Knows driving Four Wheeler");
            cell = row.createCell(51);
            cell.setCellValue("MDS Certified");
            cell = row.createCell(52);
            cell.setCellValue("Driving License");
            cell = row.createCell(53);
            cell.setCellValue("License Number");
            cell = row.createCell(54);
            cell.setCellValue("Validity of License");
            cell = row.createCell(55);
            cell.setCellValue("Work Experience");
            cell = row.createCell(56);
            cell.setCellValue("Total Work Experience (in months)");
            cell = row.createCell(57);
            cell.setCellValue("Worked with MSIL Before");
            cell = row.createCell(58);
            cell.setCellValue("MSIL Experience (in months)");
            cell = row.createCell(59);
            cell.setCellValue("Auto Industry Background");
            cell = row.createCell(60);
            cell.setCellValue("Experience in Automobile Industry (in months)");
            cell = row.createCell(61);
            cell.setCellValue("Experience in Non-Automobile Industry (in months)");
            cell = row.createCell(62);
            cell.setCellValue("Previous Company");
            cell = row.createCell(63);
            cell.setCellValue("Recruitment Source");
            cell = row.createCell(64);
            cell.setCellValue("ID Proof");
            cell = row.createCell(65);
            cell.setCellValue("ID Proof Number");
            cell = row.createCell(66);
            cell.setCellValue("Emp Salary (Per Month)");
            cell = row.createCell(67);
            cell.setCellValue("Data Science Ref ID");
            cell = row.createCell(68);
            cell.setCellValue("Data Science Prediction");
            cell = row.createCell(69);
            cell.setCellValue("Interview Based on Data Science");
            cell = row.createCell(70);
            cell.setCellValue("Reason (data science)");
            cell = row.createCell(71);
            cell.setCellValue("PF Number");
            cell = row.createCell(72);
            cell.setCellValue("Bank A/C number");
            cell = row.createCell(73);
            cell.setCellValue("ESI number");
            cell = row.createCell(74);
            cell.setCellValue("Marital Status");
            cell = row.createCell(75);
            cell.setCellValue("Blood Group");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            final Long adminId = Long.parseLong(session.getAttribute("userId").toString());
            List<ParticipantRegistration> partList = new ArrayList<ParticipantRegistration>();
            final Map<String, String> cityMap = new HashMap<String, String>();
            final Map<String, String> listMap = new HashMap<String, String>();
            final List<StateCityPinDms> cities = (List<StateCityPinDms>)this.scpServiceDms.getAllStateCityPinDms();
            final List<ListDms> listDms = (List<ListDms>)this.listService.getAllListDms();
            for (final StateCityPinDms c : cities) {
                cityMap.put(c.getCityCode(), c.getCityDesc());
            }
            for (final ListDms list : listDms) {
                listMap.put(list.getListCode(), list.getListDesc());
            }
            final Map<String, String> desgMap = new HashMap<String, String>();
            final List<Designation> listDesg = (List<Designation>)this.designationService.getAll();
            for (final Designation list2 : listDesg) {
                desgMap.put(list2.getDesignationCode(), list2.getDesignationName());
            }
            final List<TehsilVillage> tvList = (List<TehsilVillage>)this.tehsilVillageService.getAllTehsilVillages();
            final Map<String, String> tehsilMap = new HashMap<String, String>();
            final Map<String, String> villageMap = new HashMap<String, String>();
            for (final TehsilVillage t : tvList) {
                tehsilMap.put(t.getTehsilCode(), t.getTehsilDesc());
                villageMap.put(t.getVillageCode(), t.getVillageName());
            }
            List<Outlet> outletList = null;
            Date fromDate = new Date();
            Date toDate = new Date();
            final LocalDate currentDate = LocalDate.now();
            final int currentMonthvalue = currentDate.getMonthValue();
            final int yearValue = currentDate.getYear();
            LocalDate yearStartDate = null;
            if (date1 != null && date2 != null) {
                fromDate = date1;
                toDate = date2;
            }
            else if (currentMonthvalue < 4) {
                final YearMonth yearMonth = YearMonth.of(yearValue - 1, 4);
                yearStartDate = yearMonth.atDay(1);
                fromDate = Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
            }
            else {
                final YearMonth yearMonth = YearMonth.of(yearValue, 4);
                yearStartDate = yearMonth.atDay(1);
                fromDate = Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
            }
            final String role = session.getAttribute("role").toString();
            if (role.equalsIgnoreCase("HRE")) {
                partList = (List<ParticipantRegistration>)this.participantService.getParticipantForDetailedByYears(adminId, fromDate, toDate);
                outletList = (List<Outlet>)this.outletService.getOutletByhreId(adminId);
            }
            else if (role.equalsIgnoreCase("LM")) {
                final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
                final List<Long> list3 = new ArrayList<Long>();
                final Optional<LineManager> f = (Optional<LineManager>)this.fsdmservice.getFSDM(fsdmId);
                for (final Region r : f.get().getRegion()) {
                    outletList = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
                    for (final Outlet outlet3 : outletList) {
                        list3.add(outlet3.getDealer().getId());
                    }
                }
                partList = participantService.getParticipantByhreIdListAndDate(list3, fromDate, toDate);
            }
            else {
                partList = (List<ParticipantRegistration>)this.participantService.findAllParticipantsByYear(fromDate, toDate);
                outletList = (List<Outlet>)this.outletService.getAllOutlets();
            }
            final List<ParticipantRegistration> participants = new ArrayList<ParticipantRegistration>();
            if (role.equalsIgnoreCase("DL") ) {
                participants.addAll(partList);
            }
            else if (role.equalsIgnoreCase("FS") || role.equalsIgnoreCase("HO") || role.equalsIgnoreCase("SA")) {
                for (final ParticipantRegistration p : partList) {
                    Optional<InterviewScore> interviewOptional = interviewScoreService.findByAccesskey(p.getAccessKey());
                	if(interviewOptional.isPresent()){
                		InterviewScore iScore = interviewOptional.get();
                		if((iScore.getStatus()!=null && iScore.getStatus().equalsIgnoreCase("final"))
                				&& (iScore.getPass_fail_status()!=null && iScore.getPass_fail_status().equalsIgnoreCase("pass"))
                				&& (p.getStatus() == null || p.getStatus().equals("") || !p.getStatus().equalsIgnoreCase("H"))
                				) {
                						participants.add(p);
                		}
                    }
                }
            }
            final SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            int count = 1;
            for (final ParticipantRegistration pr : participants) {
                if (pr.getRegStatus() != null && pr.getRegStatus() != "" && (pr.getStatus()==null || !pr.getStatus().equalsIgnoreCase("H")) ) {
                	System.out.println("accesskey......................."+pr.getAccessKey());
                    DataScience dataScience = null;
                    final Optional<DataScience> dataScienceOpt = (Optional<DataScience>)this.dataService.findByAccesskey(pr.getAccessKey());
                    final Optional<InterviewScore> intScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(pr.getAccessKey());
                    if(!intScore.isPresent()) {
                      continue;	
                    }
                    if (dataScienceOpt.isPresent()) {
                        dataScience = dataScienceOpt.get();
                    }
                    else {
                        dataScience = new DataScience();
                    }
                    Outlet outlet4 = null;
                    row = (Row)sheet.createRow(count);
                    cell = row.createCell(0);
                    cell.setCellValue((double)count);
                    for (final Outlet o : outletList) {
                        if (o.getOutletCode().equalsIgnoreCase(pr.getOutletCode())) {
                            outlet4 = o;
                        }
                    }
                    if (outlet4 != null) {
                        cell = row.createCell(1);
                        cell.setCellValue(outlet4.getRegion().getRegionCode());
                        cell = row.createCell(2);
                        cell.setCellValue(outlet4.getOutletCode());
                        cell = row.createCell(3);
                        cell.setCellValue(outlet4.getCity().getCityName());
                        cell = row.createCell(4);
                        cell.setCellValue(outlet4.getOutletName());
                        cell = row.createCell(5);
                        cell.setCellValue(outlet4.getState().getStateName());
                    }
                    else {
                        cell = row.createCell(1);
                        cell.setCellValue("");
                        cell = row.createCell(2);
                        cell.setCellValue("");
                        cell = row.createCell(3);
                        cell.setCellValue("");
                        cell = row.createCell(4);
                        cell.setCellValue("");
                        cell = row.createCell(5);
                        cell.setCellValue("");
                    }
                    cell = row.createCell(6);
                    cell.setCellValue(pr.getEmployeeCode());
                    cell = row.createCell(7);
                    if (pr.getTitle() != null && pr.getTitle() != "") {
                        cell.setCellValue((String)listMap.get(pr.getTitle()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    String name = pr.getFirstName();
                    if (pr.getMiddleName() != null) {
                        name = String.valueOf(name) + " " + pr.getMiddleName();
                    }
                    name = String.valueOf(name) + " " + pr.getLastName();
                    cell = row.createCell(8);
                    cell.setCellValue(name);
                    cell = row.createCell(9);
                    cell.setCellValue(pr.getDesignation());
                    cell = row.createCell(10);
                    cell.setCellValue(pr.getFinalDesignation());
                    cell = row.createCell(11);
                    if (pr.getFinalDesignation() != null && pr.getFinalDesignation() != "") {
                        cell.setCellValue((String)desgMap.get(pr.getFinalDesignation()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(12);
                    cell.setCellValue(pr.getMspin());
                    cell = row.createCell(13);
                    cell.setCellValue(pr.getOldMspin());
                    cell = row.createCell(14);
                    if (pr.getGender() != null && pr.getGender() != "") {
                        cell.setCellValue((String)listMap.get(pr.getGender()));
                    }
                    cell = row.createCell(15);
                    if (pr.getBirthDate() != null) {
                        final Date birthDate = DataProccessor.parseDate2(pr.getBirthDate()); 
                        if (birthDate != null) {                   	 
                           // cell.setCellValue(sdfDate.format(birthDate));	
                        	cell.setCellValue(birthDate);
                        	cell.setCellStyle(cellStyle);
                        }
                        else {
                            cell.setCellValue("");
                        }
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(16);
                    
                    if (pr.getJoiningDate() != null) {
                    	try {
                    		Date newDate = null;
                    		try {
                    			DateFormat srcDf1 = new SimpleDateFormat("dd/MM/yyyy");
                    			newDate = srcDf1.parse(pr.getJoiningDate());
                    		} catch (Exception e) {
                    			System.out.println("cal............."+e);
                    		}  
                    		System.out.println("dd........"+sdf.format(newDate));
                    		cell.setCellValue(srcDf.parse(sdf.format(newDate)));
                        	cell.setCellStyle(cellStyle);
                			
                		} catch (Exception e) {
                			cell.setCellValue("");	
                		}
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(17);
                    cell.setCellValue(pr.getMobile());
                    cell = row.createCell(18);
                    if (pr.getAlternateContactNumber() != null) {
                        cell.setCellValue(pr.getAlternateContactNumber().toString());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(19);
                    cell.setCellValue(pr.getEmail());
                    cell = row.createCell(20);
                    String candidateStatus = "";
                    if (pr.getAccessKey() != null) {
                        candidateStatus = "Registered";
                    }
                    if (pr.getTestStatus() != null && pr.getTestStatus().equalsIgnoreCase("3") && pr.getPassFailStatus() != 0 && pr.getPassFailStatus() == 1) {
                        candidateStatus = "Passed";
                    }
                    if (pr.getInterviewScore() != null && intScore.get().getPass_fail_status() != null && intScore.get().getPass_fail_status() != "" && intScore.get().getPass_fail_status().equalsIgnoreCase("pass")) {
                        candidateStatus = "Offered";
                    }
                    if (pr.getFsdmApprovalStatus() != null && pr.getFsdmApprovalStatus().equalsIgnoreCase("2")) {
                        candidateStatus = "Recruited";
                    }
                    cell.setCellValue(candidateStatus);
                    cell = row.createCell(21);
                    String recruitmentStage = "";
                    String remarks = "";
                    if (pr.getAccessKey() != null) {
                        recruitmentStage = "In Progress";
                        remarks = "Assessment Not Cleared";
                    }
                    if (pr.getTestStatus() != null) {
                        if (pr.getTestStatus().equals("1") || pr.getTestStatus().equals("2")) {
                            recruitmentStage = "In Progress";
                            remarks = "Assessment Not Cleared";
                        }
                        if (pr.getTestStatus().equals("3") && pr.getPassFailStatus() == 0) {
                            remarks = "Assessment Not Cleared";
                        }
                        if (pr.getTestStatus().equals("3") && pr.getPassFailStatus() == 1) {
                            remarks = "Interview Not Cleared";
                        }
                        if (pr.getTestStatus().equals("3") && pr.getPassFailStatus() == 1 && !intScore.isPresent()) {
                            remarks = "Interview Status Awaited";
                        }
                    }
                    if (intScore.isPresent() && intScore.get().getInterviewStatus() != null && intScore.get().getInterviewStatus().equals("Selected")) {
                        recruitmentStage = "In Progress";
                        remarks = "Interview Cleared";
                    }
                    if (pr.getFsdmApprovalStatus() != null && (pr.getFsdmApprovalStatus().equalsIgnoreCase("3") || pr.getFsdmApprovalStatus().equalsIgnoreCase("1"))) {
                        recruitmentStage = "In Progress";
                        remarks = "FSDM Approval Pending";
                    }
                    if (pr.getPrarambhStatus() != null && pr.getPrarambhStatus().equals("2")) {
                        remarks = "FSDM Approval Pending";
                    }
                    if (pr.getFinalDesignation() != null && pr.getFinalDesignation().equals("STR") && pr.getPrarambhStatus() != null && pr.getPrarambhStatus().equals("1")) {
                        recruitmentStage = "In Progress";
                        remarks = "Praarambh Pending";
                    }
                    if (pr.getPrarambhStatus() != null && pr.getPrarambhStatus().equals("2") && pr.getFsdmApprovalStatus() != null && !pr.getFsdmApprovalStatus().equals("2") && pr.getFinalDesignation() != null && pr.getFinalDesignation().equals("STR")) {
                        remarks = "Assign Designation";
                    }
                    if (pr.getPrarambhStatus() != null && pr.getPrarambhStatus().equals("2") && pr.getFsdmApprovalStatus() != null && pr.getFsdmApprovalStatus().equals("3") && !pr.getFinalDesignation().equals("STR")) {
                        remarks = "FSDM Approval Pending";
                    }
                    if (pr.getStatus() != null && pr.getStatus().equalsIgnoreCase("H")) {
                        recruitmentStage = "On Hold";
                    }
                    if (pr.getFsdmApprovalStatus() != null && pr.getFsdmApprovalStatus().equalsIgnoreCase("2")) {
                        recruitmentStage = "Approved";
                        remarks = "";
                    }
                    cell.setCellValue(recruitmentStage);
                    cell = row.createCell(22);
                    cell.setCellValue(remarks);
                    String ageInYears = "";
                    if (pr.getBirthDate() != null && pr.getBirthDate() != "") {
                    	ageInYears = DataProccessor.BirthDateInYearsConversion(DataProccessor.parseDate(pr.getBirthDate()));
						
                    }
                    cell = row.createCell(23);
                    cell.setCellValue(ageInYears);
                    cell = row.createCell(24);
                    if (pr.getPin() != null) {
                        cell.setCellValue((double)pr.getPin());
                    }
                    cell = row.createCell(25);
                    if (pr.getCity() != null && pr.getCity() != "") {
                        cell.setCellValue((String)cityMap.get(pr.getCity()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(26);
                    if (pr.getTehsil() != null && pr.getTehsil() != "") {
                        cell.setCellValue((String)tehsilMap.get(pr.getTehsil()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(27);
                    if (pr.getVillage() != null && pr.getVillage() != "") {
                        cell.setCellValue((String)villageMap.get(pr.getVillage()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(28);
                    if (pr.getHighestQualification() != null && pr.getHighestQualification() != "") {
                        cell.setCellValue((String)listMap.get(pr.getHighestQualification()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(29);
                    if (pr.getPrimaryLanguage() != null && pr.getPrimaryLanguage() != "") {
                        cell.setCellValue((String)listMap.get(pr.getPrimaryLanguage()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(30);
                    if (pr.getSecondaryLanguage() != null && pr.getSecondaryLanguage() != "") {
                        cell.setCellValue((String)listMap.get(pr.getSecondaryLanguage()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(31);
                    cell.setCellValue(pr.getAccessKey());
                    cell = row.createCell(32);
                    if (pr.getRegistration_date() != null) {
                       // cell.setCellValue(DataProccessor.csvDateFormatting(pr.getRegistration_date()));
                    	cell.setCellValue(pr.getRegistration_date());
                     	cell.setCellStyle(cellStyle);
                    }
                    else {
                        cell.setCellValue("");
                    }
                    if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales")) {
                        cell = row.createCell(33);
                        if (pr.getTestCompletionDate() != null) {
                          //  cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
                        	cell.setCellValue(pr.getTestCompletionDate());
                         	cell.setCellStyle(cellStyle);
                        }
                        else {
                            cell.setCellValue("");
                        }
                        cell = row.createCell(34);
                        if (pr.getAptitudeScore() != null) {
                            cell.setCellValue((double)pr.getAptitudeScore());
                        }
                        else {
                            cell.setCellValue("");
                        }
                        cell = row.createCell(35);
                        if (pr.getAttitudeScore() != null) {
                            cell.setCellValue((double)pr.getAttitudeScore());
                        }
                        else {
                            cell.setCellValue("");
                        }
                        cell = row.createCell(36);
                        if (pr.getTotalMark() != null) {
                            cell.setCellValue(pr.getTotalMark());
                        }
                        else {
                            cell.setCellValue("");
                        }
                        cell = row.createCell(37);
                        if (pr.getTestScore() != null) {
                            cell.setCellValue(pr.getTestScore());
                        }
                        else {
                            cell.setCellValue("");
                        }
                        cell = row.createCell(38);
                        if (pr.getTestScore() != null && pr.getTotalMark() != null) {
                            final double score = Double.valueOf(pr.getTestScore());
                            final double total = Double.valueOf(pr.getTotalMark());
                            final double per = score / total * 100.0;
                            final double roundOf = Math.round(per * 100.0) / 100.0;
                            cell.setCellValue(roundOf);
                        }
                        cell = row.createCell(39);
                        if (pr.getTestStatus() != null && pr.getTestStatus().equalsIgnoreCase("3")) {
                            if (pr.getPassFailStatus() == 1) {
                                cell.setCellValue("Pass");
                            }
                            else if (pr.getPassFailStatus() == 0) {
                                cell.setCellValue("Fail");
                            }
                        }
                        else {
                            cell.setCellValue("");
                        }
                    }
                    else if (pr.getDesignation() != null && pr.getDesignation().equalsIgnoreCase("Sales Support")) {
                        cell = row.createCell(33);
                        cell.setCellValue("NA");
                        cell = row.createCell(34);
                        cell.setCellValue("NA");
                        cell = row.createCell(35);
                        cell.setCellValue("NA");
                        cell = row.createCell(36);
                        cell.setCellValue("NA");
                        cell = row.createCell(37);
                        cell.setCellValue("NA");
                        cell = row.createCell(38);
                        cell.setCellValue("NA");
                        cell = row.createCell(39);
                        cell.setCellValue("NA");
                    }
                    cell = row.createCell(40);
                    if (pr.getInterviewDate() != null) {
                       // cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
                        cell.setCellValue(pr.getInterviewDate());
                    	cell.setCellStyle(cellStyle);
                    }
                    cell = row.createCell(41);
                    if (pr.getInterviewScore() != null) {
                        cell.setCellValue((double)pr.getInterviewScore());
                    }
                    cell = row.createCell(42);
                    if (intScore.isPresent()) {
                        cell.setCellValue(intScore.get().getInterviewStatus());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(43);
                    String praarambhStatus = "";
                    if (pr.getPrarambhStatus() != null && pr.getPrarambhStatus() != "") {
                        if (pr.getPrarambhStatus().equals("1")) {
                            praarambhStatus = "Pending";
                        }
                        if (pr.getPrarambhStatus().equals("2")) {
                            praarambhStatus = "Completed";
                        }
                    }
                    cell.setCellValue(praarambhStatus);
                    cell = row.createCell(44);
                    if (pr.getFsdmApprovalStatus() != null) {
                        if (pr.getFsdmApprovalStatus().equals("1")) {
                            cell.setCellValue("Rejected");
                        }
                        else if (pr.getFsdmApprovalStatus().equals("3")) {
                            cell.setCellValue("Pending");
                        }
                        else if (pr.getFsdmApprovalStatus().equals("2")) {
                            cell.setCellValue("Approved");
                        }
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(45);
                    String fsdmF = "";
                    if (pr.getFsdmFeedback() != null) {
                        fsdmF = String.valueOf(fsdmF) + "Reason : " + pr.getFsdmFeedback();
                    }
                    if (pr.getFsdmRejectionType() != null) {
                        fsdmF = String.valueOf(fsdmF) + "%nId Type : " + pr.getFsdmRejectionType();
                    }
                    if (pr.getFsdmRejectionReason() != null) {
                        fsdmF = String.valueOf(fsdmF) + "%nDetails : " + pr.getFsdmRejectionReason();
                    }
                    if (pr.getFsdmRejectionComment() != null) {
                        fsdmF = String.valueOf(fsdmF) + "%nComment : " + pr.getFsdmRejectionComment();
                    }
                    cell.setCellValue(String.format(fsdmF, new Object[0]));
                    cell = row.createCell(46);
                    if (pr.getFsdmApprovalDate() != null) {
                        //cell.setCellValue(DataProccessor.csvDateFormatting(pr.getFsdmApprovalDate()));
                    	
                    	cell.setCellValue(pr.getFsdmApprovalDate());
                    	cell.setCellStyle(cellStyle);
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(47);
                    cell.setCellValue(pr.getOwnTwoWheeler());
                    cell = row.createCell(48);
                    cell.setCellValue(pr.getOwnFourWheeler());
                    cell = row.createCell(49);
                    cell.setCellValue(pr.getTwoWheeler());
                    cell = row.createCell(50);
                    cell.setCellValue(pr.getFourWheeler());
                    cell = row.createCell(51);
                    cell.setCellValue(pr.getMdsCertified());
                    cell = row.createCell(52);
                    cell.setCellValue(pr.getDL());
                    cell = row.createCell(53);
                    if (pr.getDL() != null && pr.getLicenseNo() != null) {
                        if (pr.getDL().equalsIgnoreCase("Yes")) {
                            cell.setCellValue(pr.getLicenseNo());
                        }
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(54);
                    if (pr.getValidityOfLicence() != null) {
                        final Date validity = DataProccessor.parseDate(pr.getValidityOfLicence());
                        if (validity != null) {
                           // cell.setCellValue(DataProccessor.csvDateFormatting(validity));
                        	cell.setCellValue(validity);
                        	cell.setCellStyle(cellStyle);
                        }
                    }
                    cell = row.createCell(55);
                    if (pr.getFresher() != null && !pr.getFresher().equals("")) {
                        cell.setCellValue(String.valueOf(pr.getFresher().substring(0, 1).toUpperCase()) + pr.getFresher().substring(1));
                    }
                    if (pr.getExperience() != null && !pr.getExperience().equals("")) {
                        cell.setCellValue(String.valueOf(pr.getExperience().substring(0, 1).toUpperCase()) + pr.getExperience().substring(1));
                    }
                    cell = row.createCell(56);
                    if (pr.getTotal() != null) {
                        cell.setCellValue((double)pr.getTotal());
                    }
                    cell = row.createCell(57);
                    cell.setCellValue(pr.getWorkedWithMSILBefore());
                    cell = row.createCell(58);
                    cell.setCellValue(pr.getMsilExp());
                    cell = row.createCell(59);
                    String autoIndustryBackground = "";
                    final List<WorkExperience> workList = (List<WorkExperience>)pr.getWorkExperience();
                    if (workList != null && workList.size() >= 1) {
                        final List<String> list4 = new ArrayList<String>();
                        for (final WorkExperience w : workList) {
                            list4.add(w.getAutoIndustryExperience());
                        }
                        if (list4.contains("Yes") || list4.contains("yes")) {
                            autoIndustryBackground = "Yes";
                        }
                        else {
                            autoIndustryBackground = "No";
                        }
                    }
                    if (pr.getAutoIndustryExperience() != null && pr.getAutoIndustryExperience() > 0) {
                        autoIndustryBackground = "Yes";
                    }
                    else {
                        autoIndustryBackground = "No";
                    }
                    cell.setCellValue(autoIndustryBackground);
                    cell = row.createCell(60);
                    if (pr.getAutoIndustryExperience() != null) {
                        cell.setCellValue((double)pr.getAutoIndustryExperience());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(61);
                    if (pr.getNonAutoIndustryExperience() != null) {
                        cell.setCellValue((double)pr.getNonAutoIndustryExperience());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(62);
                    String preCompanyName = "";
                    if (pr.getWorkExperience() != null && pr.getWorkExperience().size() != 0) {
                        for (final WorkExperience w : pr.getWorkExperience()) {
                            preCompanyName = w.getCompanyName();
                        }
                    }
                    if (pr.getWorkExperience() != null && pr.getWorkExperience().size() > 1) {
                        for (final WorkExperience w : pr.getWorkExperience()) {
                            preCompanyName = String.valueOf(preCompanyName) + ", " + w.getCompanyName();
                        }
                    }
                    cell.setCellValue(preCompanyName);
                    cell = row.createCell(63);
                    cell.setCellValue(pr.getSource());
                    cell = row.createCell(64);
                    if (pr.getIdProof() != null && pr.getIdProof() != "") {
                        cell.setCellValue((String)listMap.get(pr.getIdProof()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(65);
                    if (pr.getAdharNumber() != null) {
                        cell.setCellValue(pr.getAdharNumber().toString());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(66);
                    cell.setCellValue(pr.getEmpSalary());
                    cell = row.createCell(67);
                    cell.setCellValue(dataScience.getDataScienceReferenceId());
                    cell = row.createCell(68);
                    cell.setCellValue(dataScience.getDataSciencePrediction());
                    cell = row.createCell(69);
                    if (dataScience.getInterviewStatus() != null) {
                        cell.setCellValue(String.valueOf(dataScience.getInterviewStatus().substring(0, 1).toUpperCase()) + dataScience.getInterviewStatus().substring(1));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(70);
                    cell.setCellValue(dataScience.getReason());
                    cell = row.createCell(71);
                    cell.setCellValue(pr.getPfNumber());
                    cell = row.createCell(72);
                    cell.setCellValue(pr.getBankAccountNumber());
                    cell = row.createCell(73);
                    cell.setCellValue(pr.getEsiNumber());
                    cell = row.createCell(74);
                    cell.setCellValue(pr.getMartialStatus());
                    cell = row.createCell(75);
                    if (pr.getBloodGroup() != null && pr.getBloodGroup() != "") {
                        cell.setCellValue((String)listMap.get(pr.getBloodGroup()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    ++count;
                }
            }
          
            fileName = DataProccessor.getReportName("Detailed Report");
            String responseExcelUrl = fileName+".xlsx";
			try (FileOutputStream outputStream = new FileOutputStream(responseExcelUrl)) {
				workbook.write(outputStream);
			} catch (Exception e) {
			}
            final File file = new File(fileName+".xlsx");
            final HttpHeaders header = new HttpHeaders();
            header.add("Content-Disposition", "attachment; filename= "+fileName+".xlsx");
            header.add("Cache-Control", "no-cache, no-store, must-revalidate");
            header.add("Pragma", "no-cache");
            header.add("Expires", "0");
            final InputStreamResource resource = new InputStreamResource((InputStream)new FileInputStream(file));
            return (ResponseEntity<?>)((ResponseEntity.BodyBuilder)ResponseEntity.ok().headers(header)).contentLength(file.length()).contentType(MediaType.parseMediaType("application/octet-stream")).body((Object)resource);
        }
        return null;
    }
    */
}


