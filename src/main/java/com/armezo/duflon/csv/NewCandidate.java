package com.armezo.duflon.csv;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
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
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Entities.WorkExperience;
import com.armezo.duflon.Services.AccessKeyMasterService;
import com.armezo.duflon.Services.DataListService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.WorkExperienceService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class NewCandidate {
	@Autowired
	ParticipantServiceImpl participantService;
	@Autowired
	InterviewScoreService interviewScoreService;
    @Autowired
    AccessKeyMasterService accessKeyMasterService;
    @Autowired
    HREService hreService;
    @Autowired
    WorkExperienceService workExperienceService;
    @Autowired
    DataListService dataListService;
    
    @PostMapping({ "/onHoldCSV" })
    @ResponseBody
    public ResponseEntity<?> getCSVOnHold( @RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model) throws FileNotFoundException {
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
            cell.setCellValue("Candidate Name");
            cell = row.createCell(2);
            cell.setCellValue("Designation");
            cell = row.createCell(3);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(4);
            cell.setCellValue("Access Key");
            cell = row.createCell(5);
            cell.setCellValue("Registration Date");
            cell = row.createCell(6);
            cell.setCellValue("Assessment Date");
            cell = row.createCell(7);
            cell.setCellValue("Aptitude");
            cell = row.createCell(8);
            cell.setCellValue("Attitude");
            cell = row.createCell(9);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(10);
            cell.setCellValue("Re-attempt");
            cell = row.createCell(11);
            cell.setCellValue("Interview Date");
            cell = row.createCell(12);
            cell.setCellValue("Interview Score");
            cell = row.createCell(13);
            cell.setCellValue("Interview 2 Date");
            cell = row.createCell(14);
            cell.setCellValue("Interview 2 Score");
            cell = row.createCell(15);
            cell.setCellValue("Status");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            LocalDate lastStart = LocalDate.now().minusDays(90);
    		LocalDate lastEnd = LocalDate.now();
            final String role = session.getAttribute("role").toString();
            Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
            List<ParticipantRegistration> participantList = new ArrayList<ParticipantRegistration>();
            if (role.equalsIgnoreCase("HRE")) {
                final Long hreId = Long.parseLong(session.getAttribute("userId").toString());
                if(dateFromm!=null && dateFromm!="" && dateToo!=null && dateToo!="") {
        			participantList= participantService.getHoldParticipantsByFilterHRE(hreId,map.get("from"), map.get("to"));
        		}else {
        			participantList = (List<ParticipantRegistration>)this.participantService.getHoldEmployee(hreId, "H",lastStart,lastEnd);
    			}
            }
            if (role.equalsIgnoreCase("LM") || role.equalsIgnoreCase("SA") || role.equalsIgnoreCase("HOD")) {
                participantList = participantService.getParticipantHoldLM(map.get("from"), map.get("to"));
            }
            int count=1;
            for (final ParticipantRegistration pr : participantList) {
                row = (Row)sheet.createRow(count);
                cell = row.createCell(0);
                cell.setCellValue((double)count);
                cell = row.createCell(1);
                cell.setCellValue(DataProccessor.getFullNameOfParticipant(pr));
                cell = row.createCell(2);
                cell.setCellValue(pr.getDesignation());
                cell = row.createCell(3);
                cell.setCellValue(pr.getMobile());
                cell = row.createCell(4);
                cell.setCellValue(pr.getAccessKey());
                cell = row.createCell(5);
                if (pr.getRegistration_Date() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getRegistration_Date()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(6);
                if (pr.getTestCompletionDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
                }
                else {
                    cell.setCellValue("");
                }
                    cell = row.createCell(7);
                    cell.setCellValue((double)pr.getAptitudeScore());
                    cell = row.createCell(8);
                    cell.setCellValue((double)pr.getAttitudeScore());
                    cell = row.createCell(9);
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
                
                cell = row.createCell(10);
                if (pr.getReAtampStatus() == null) {
                    cell.setCellValue("No");
                }
                else {
                    cell.setCellValue("Yes");
                }
                cell = row.createCell(11);
                if (pr.getInterviewDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(12);
                final Optional<InterviewScore> intScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(pr.getAccessKey(),1);
                final Optional<InterviewScore> intScore2 = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(pr.getAccessKey(),2);
                if (intScore.isPresent()) {
                    cell.setCellValue(intScore.get().getTotal());
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(13);
                if (pr.getInterviewDate2() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate2()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(14);
                if(intScore2.isPresent()) {
                	cell.setCellValue(intScore2.get().getTotal());
                }else {
                	cell.setCellValue("");
                }
                cell = row.createCell(15);
                cell.setCellValue("Hold");
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
    public ResponseEntity<?> inProgressCandidate(@RequestParam("dateFromm") final String dateFromm, 
    		@RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model) throws FileNotFoundException {
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
            cell.setCellValue("Candidate Name");
            cell = row.createCell(2);
            cell.setCellValue("Designation");
            cell = row.createCell(3);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(4);
            cell.setCellValue("Access Key");
            cell = row.createCell(5);
            cell.setCellValue("Registration Date");
            cell = row.createCell(6);
            cell.setCellValue("Assessment Date");
            cell = row.createCell(7);
            cell.setCellValue("Aptitude");
            cell = row.createCell(8);
            cell.setCellValue("Attitude");
            cell = row.createCell(9);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(10);
            cell.setCellValue("Re-attempt");
            cell = row.createCell(11);
            cell.setCellValue("Interview Date");
            cell = row.createCell(12);
            cell.setCellValue("Interview Score");
            cell = row.createCell(13);
            cell.setCellValue("Interview 2 Date");
            cell = row.createCell(14);
            cell.setCellValue("Interview 2 Score");
            cell = row.createCell(15);
            cell.setCellValue("Status");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
            final String role = session.getAttribute("role").toString();
            List<ParticipantRegistration> partList = new ArrayList<ParticipantRegistration>();
            if (role.equalsIgnoreCase("HRE")) {
                final Long hreId = Long.parseLong(session.getAttribute("userId").toString());
                partList = participantService.getParticipantInpprocessForHRE(hreId, map.get("from"),map.get("to"));
            }
            else if (!role.equalsIgnoreCase("HRE")) {
            	partList = participantService.getParticipantInpprocessLM(map.get("from"),map.get("to"));
             }
            int count = 1;
            for (final ParticipantRegistration pr : partList) {
                row = (Row)sheet.createRow(count);
                cell = row.createCell(0);
                cell.setCellValue((double)count);
                cell = row.createCell(1);
                cell.setCellValue(DataProccessor.getFullNameOfParticipant(pr));
                cell = row.createCell(2);
                cell.setCellValue(pr.getDesignation());
                cell = row.createCell(3);
                cell.setCellValue(pr.getMobile());
                cell = row.createCell(4);
                cell.setCellValue(pr.getAccessKey());
                cell = row.createCell(5);
                if (pr.getRegistration_Date() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getRegistration_Date()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(6);
                if (pr.getTestCompletionDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
                }
                else {
                    cell.setCellValue("");
                }
                    cell = row.createCell(7);
                    cell.setCellValue((double)pr.getAptitudeScore());
                    cell = row.createCell(8);
                    cell.setCellValue((double)pr.getAttitudeScore());
                    cell = row.createCell(9);
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
                
                cell = row.createCell(10);
                if (pr.getReAtampStatus() == null) {
                    cell.setCellValue("No");
                }
                else {
                    cell.setCellValue("Yes");
                }
                cell = row.createCell(11);
                if (pr.getInterviewDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(12);
                final Optional<InterviewScore> intScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(pr.getAccessKey(),1);
                final Optional<InterviewScore> intScore2 = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(pr.getAccessKey(),2);
                if (intScore.isPresent()) {
                    cell.setCellValue(intScore.get().getTotal());
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(13);
                if (pr.getInterviewDate2() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate2()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(14);
                if(intScore2.isPresent()) {
                	cell.setCellValue(intScore2.get().getTotal());
                }else {
                	cell.setCellValue("");
                }
                cell= row.createCell(15);
                String status="";
                if(pr.getParticipantStatus()!=null) {
                	status = DataProccessor.getParticipantStatus(pr.getParticipantStatus());
                }
                cell.setCellValue(status);
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
    public ResponseEntity<?> getCSVEmployee(@RequestParam("dateFromm") final String dateFromm, 
    		@RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model) throws FileNotFoundException {
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
            cell.setCellValue("Candidate Name");
            cell = row.createCell(2);
            cell.setCellValue("Designation");
            cell = row.createCell(3);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(4);
            cell.setCellValue("Access Key");
            cell = row.createCell(5);
            cell.setCellValue("Registration Date");
            cell = row.createCell(6);
            cell.setCellValue("Assessment Date");
            cell = row.createCell(7);
            cell.setCellValue("Aptitude");
            cell = row.createCell(8);
            cell.setCellValue("Attitude");
            cell = row.createCell(9);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(10);
            cell.setCellValue("Re-attempt");
            cell = row.createCell(11);
            cell.setCellValue("Interview Date");
            cell = row.createCell(12);
            cell.setCellValue("Interview Score");
            cell = row.createCell(13);
            cell.setCellValue("Interview 2 Date");
            cell = row.createCell(14);
            cell.setCellValue("Interview 2 Score");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
            final String role = session.getAttribute("role").toString();
            List<ParticipantRegistration> participantList = null;
            if (role.equalsIgnoreCase("HRE")) {
            	final Long hreId = Long.parseLong(session.getAttribute("userId").toString());
                    participantList = (List<ParticipantRegistration>)this.participantService.getEmployee(hreId, "Y", map.get("from"), map.get("to"));
                }
                else if(!role.equalsIgnoreCase("HRE")){
                    participantList = (List<ParticipantRegistration>)this.participantService.getParticipantEmployeeLM( map.get("from"), map.get("to"));
                }
            int count = 1;
            for (final ParticipantRegistration pr : participantList) {
                row = (Row)sheet.createRow(count);
                cell = row.createCell(0);
                cell.setCellValue((double)count);
                cell = row.createCell(1);
                cell.setCellValue(DataProccessor.getFullNameOfParticipant(pr));
                cell = row.createCell(2);
                cell.setCellValue(pr.getDesignation());
                cell = row.createCell(3);
                cell.setCellValue(pr.getMobile());
                cell = row.createCell(4);
                cell.setCellValue(pr.getAccessKey());
                cell = row.createCell(5);
                if (pr.getRegistration_Date() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getRegistration_Date()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(6);
                if (pr.getTestCompletionDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
                }
                else {
                    cell.setCellValue("");
                }
                    cell = row.createCell(7);
                    cell.setCellValue((double)pr.getAptitudeScore());
                    cell = row.createCell(8);
                    cell.setCellValue((double)pr.getAttitudeScore());
                    cell = row.createCell(9);
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
                cell = row.createCell(10);
                if (pr.getReAtampStatus() == null) {
                    cell.setCellValue("No");
                }
                else {
                    cell.setCellValue("Yes");
                }
                cell = row.createCell(11);
                if (pr.getInterviewDate() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(12);
                final Optional<InterviewScore> intScore = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(pr.getAccessKey(),1);
                final Optional<InterviewScore> intScore2 = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(pr.getAccessKey(),2);
                if (intScore.isPresent()) {
                    cell.setCellValue(intScore.get().getTotal());
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(13);
                if (pr.getInterviewDate2() != null) {
                    cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate2()));
                }
                else {
                    cell.setCellValue("");
                }
                cell = row.createCell(14);
                if(intScore2.isPresent()) {
                	cell.setCellValue(intScore2.get().getTotal());
                }else {
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
    
    @GetMapping({ "/detailedCSV" })
    public ResponseEntity<?> getReportDetailed(@RequestParam("dateFromm") final String dateFromm, @RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model) throws FileNotFoundException {
        String fileName="";
      /*  Calendar cal = Calendar.getInstance();
        DateFormat srcDf = new SimpleDateFormat("yyyy-MM-dd");
        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");*/
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
            cell.setCellValue("Accesskey");
            cell = row.createCell(2);
            cell.setCellValue("Employee Code");
            cell = row.createCell(3);
            cell.setCellValue("Title");
            cell = row.createCell(4);
            cell.setCellValue("Candidate Name");
            cell = row.createCell(5);
            cell.setCellValue("Designation");
            cell = row.createCell(6);
            cell.setCellValue("Gender");
            cell = row.createCell(7);
            cell.setCellValue("DOB");
            cell = row.createCell(8);
            cell.setCellValue("DOJ");
            cell = row.createCell(9);
            cell.setCellValue("Mobile Number");
            cell = row.createCell(10);
            cell.setCellValue("Alternative Contact No.");
            cell = row.createCell(11);
            cell.setCellValue("Email Id");
            cell = row.createCell(12);
            cell.setCellValue("Candidate Status");
            cell = row.createCell(13);
            cell.setCellValue("Recruitment Stage");
            cell = row.createCell(14);
            cell.setCellValue("Age (in years)");
            cell = row.createCell(15);
            cell.setCellValue("Pincode");
            cell = row.createCell(16);
            cell.setCellValue("Candidate City");
            cell = row.createCell(17);
            cell.setCellValue("Highest Qualification");
            cell = row.createCell(18);
            cell.setCellValue("Primary Language");
            cell = row.createCell(19);
            cell.setCellValue("Secondary Language");
            cell = row.createCell(20);
            cell.setCellValue("HRE Name");
            cell = row.createCell(21);
            cell.setCellValue("Registration Date");
            cell = row.createCell(22);
            cell.setCellValue("Assessment Completion Date");
            cell = row.createCell(23);
            cell.setCellValue("Aptitude Score");
            cell = row.createCell(24);
            cell.setCellValue("Attitude Score");
            cell = row.createCell(25);
            cell.setCellValue("Total Marks");
            cell = row.createCell(26);
            cell.setCellValue("Marks Obtained");
            cell = row.createCell(27);
            cell.setCellValue("Percentage");
            cell = row.createCell(28);
            cell.setCellValue("Assessment Status");
            cell = row.createCell(29);
            cell.setCellValue("Interview Date");
            cell = row.createCell(30);
            cell.setCellValue("Interview Score");
            cell = row.createCell(31);
            cell.setCellValue("Interview Status");
            cell = row.createCell(32);
            cell.setCellValue("Interview 2 Date");
            cell = row.createCell(33);
            cell.setCellValue("Interview 2 Score");
            cell = row.createCell(34);
            cell.setCellValue("Interview 2 Status");
            cell = row.createCell(35);
            cell.setCellValue("Work Experience");
            cell = row.createCell(36);
            cell.setCellValue("Total Work Experience (in months)");
            cell = row.createCell(37);
            cell.setCellValue("Previous Company");
            cell = row.createCell(38);
            cell.setCellValue("Recruitment Source");
            cell = row.createCell(39);
            cell.setCellValue("ID Proof");
            cell = row.createCell(40);
            cell.setCellValue("ID Proof Number");
            cell = row.createCell(41);
            cell.setCellValue("Emp Salary (Per Month)");
            cell = row.createCell(42);
            cell.setCellValue("Bank A/C number");
            cell = row.createCell(43);
            cell.setCellValue("Marital Status");
            cell = row.createCell(44);
            cell.setCellValue("Blood Group");
            cell = row.createCell(45);
            cell.setCellValue("Status");
            for (int i = 0; i < row.getLastCellNum(); ++i) {
                row.getCell(i).setCellStyle((CellStyle)style);
            }
            final Long adminId = Long.parseLong(session.getAttribute("userId").toString());
            List<ParticipantRegistration> partList = new ArrayList<ParticipantRegistration>();
            final Map<String, String> listMap = new HashMap<String, String>();
            final List<DataList> listData = (List<DataList>)this.dataListService.getAllDataList();
            for (final DataList list : listData) {
                listMap.put(list.getListCode(), list.getListDesc());
            }
         // Date YTD wise Data
         			LocalDate dateFrom = LocalDate.now();
         			LocalDate dateTo = LocalDate.now();
         			LocalDate currentDate = LocalDate.now();
         			int currentMonthvalue = currentDate.getMonthValue();
         			int yearValue = currentDate.getYear();
         			LocalDate yearStartDate = null;
         			if (currentMonthvalue < 4) {
         				YearMonth yearMonth = YearMonth.of(yearValue - 1, 4);
         				yearStartDate = yearMonth.atDay(1);
         				//dateFrom = Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
         			} else {
         				YearMonth yearMonth = YearMonth.of(yearValue, 4);
         				yearStartDate = yearMonth.atDay(1);
         				//dateFrom = Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
         			}
         			dateFrom=yearStartDate;
            final String role = session.getAttribute("role").toString();
            Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
            if (role.equalsIgnoreCase("HRE")) {
            	if(dateFromm!=null && dateToo!=null && dateFromm!="" && dateToo!="") {
            		partList = participantService.getParticipantForDetailedByYears(adminId, map.get("from"), map.get("to"));
            	}else {
            		partList = participantService.getParticipantForDetailedByYears(adminId, yearStartDate,dateTo);
				}
                //partList = (List<ParticipantRegistration>)this.participantService.getParticipantForDetailedByYears(adminId, fromDate, toDate);
            }else {
            	if(dateFromm!=null && dateToo!=null && dateFromm!="" && dateToo!="") {
            		partList = (List<ParticipantRegistration>)this.participantService.findAllParticipantsByYear(map.get("from"), map.get("to"));
            	}else {
            		partList = (List<ParticipantRegistration>)this.participantService.findAllParticipantsByYear(yearStartDate,dateTo);
				}
            }
            
            int count = 1;
            LocalDate currentLocalDate = LocalDate.now();
            for (final ParticipantRegistration pr : partList) {
                if (pr.getRegStatus() != null && pr.getRegStatus() != "" && (pr.getStatus()==null || !pr.getStatus().equalsIgnoreCase("H")) ) {
                	Optional<InterviewScore> intScore = interviewScoreService.findByAccesskeyAndInterviewCount(pr.getAccessKey(), 1);
                	Optional<InterviewScore> intScore2 = interviewScoreService.findByAccesskeyAndInterviewCount(pr.getAccessKey(), 2);
                    row = (Row)sheet.createRow(count);
                    cell = row.createCell(0);
                    cell.setCellValue((double)count);
                    cell = row.createCell(1);
                    cell.setCellValue(pr.getAccessKey());
                    cell = row.createCell(2);
                    cell.setCellValue(pr.getEmpCode());
                    cell = row.createCell(3);
                    String title="";
                    if(pr.getTitle()!=null && pr.getTitle()!="") {
                    	title=listMap.get(pr.getTitle());
                    }
                    cell.setCellValue(title);
                    cell = row.createCell(4);
                    cell.setCellValue(DataProccessor.getFullNameOfParticipant(pr));
                    cell = row.createCell(5);
                    cell.setCellValue(pr.getDesignation());
                    cell = row.createCell(6);
                    cell.setCellValue(pr.getGender());
                    cell = row.createCell(7);
                    cell.setCellValue(DataProccessor.dateToString(pr.getBirthDate()));
                    cell = row.createCell(8);
                    cell.setCellValue(DataProccessor.dateToString(pr.getJoiningDate()));
                    cell = row.createCell(9);
                    cell.setCellValue(pr.getMobile());
                    cell = row.createCell(10);
                    cell.setCellValue(pr.getAlternateContactNumber());
                    cell = row.createCell(11);
                    cell.setCellValue(pr.getEmail());
                    cell = row.createCell(12);
                    String candidateStatus = "";
                    if (pr.getRegStatus() != null) {
                        candidateStatus = "Registered";
                    }
                    if (pr.getTestStatus() != null && pr.getTestStatus().equalsIgnoreCase("3") && pr.getPassFailStatus() != 0 && pr.getPassFailStatus() == 1) {
                        candidateStatus = "Passed";
                    }
                    if (pr.getInterviewScore() != null && intScore2.isPresent() && intScore2.get().getPass_fail_status() != null && intScore2.get().getPass_fail_status() != "" && intScore2.get().getPass_fail_status().equalsIgnoreCase("pass")) {
                        candidateStatus = "Offered";
                    }
                    if (pr.getHiredStatus() != null && pr.getHiredStatus().equalsIgnoreCase("Y")) {
                        candidateStatus = "Recruited";
                    }
                    cell.setCellValue(candidateStatus);
                    cell = row.createCell(13);
                    String recruitmentStage = "";
                    if (pr.getAccessKey() != null) {
                        recruitmentStage = "In Progress";
                    }
                    if(pr.getTestStatus()!=null) {
                        if (pr.getTestStatus().equals("2") ) {
                            recruitmentStage = "Assessment Not Completed";
                        }
                        if (pr.getTestStatus().equals("3") && pr.getPassFailStatus() == 0) {
                        	recruitmentStage = "Failed In Assessment";
                        }
                        if (pr.getTestStatus().equals("3") && pr.getPassFailStatus() == 1) {
                        	recruitmentStage = "Assessment Passed, Document Upload Pending";
                        }
                    }
                    if(pr.getRegStatus()!=null && pr.getRegStatus().equals("3")) {
                    	recruitmentStage="Document Uploaded, Interview Pending ";
                    }
                    if(pr.getInterviewDate()!=null) {
                    	if(pr.getInterviewDate().isAfter(currentLocalDate)) {
                    		recruitmentStage="1st Round Interview Scheduled";
                    	}
                    	if(pr.getInterviewScore()!=null && intScore.isPresent()) {
                    		recruitmentStage="1st Round Interview Happened";
                    		if(intScore.get().getInterviewStatus()!=null && intScore.get().getInterviewStatus().equalsIgnoreCase("Selected")) {
                    			recruitmentStage="Selected In 1st Round Interview";
                    		}
                    		if(intScore.get().getInterviewStatus()!=null && intScore.get().getInterviewStatus().equalsIgnoreCase("Not Selected")){
                    			recruitmentStage="Failed In 1st Round Interview";
                    		}
                    	}
                    	if(pr.getInterviewDate2()!=null) {
                    		if(pr.getInterviewDate2().isAfter(currentLocalDate)) {
                    			recruitmentStage="2nd Round Interview Scheduled";
                    		}
                    		if(pr.getInterviewScore2()!=null && intScore2.isPresent()) {
                    			recruitmentStage="2nd Round Interview Happened";
                    			if(intScore2.get().getInterviewStatus()!=null && intScore2.get().getInterviewStatus().equalsIgnoreCase("Selected")) {
                    				recruitmentStage="Selected In 2nd Round Interview";
                    			}
                    			if(intScore2.get().getInterviewStatus()!=null && intScore2.get().getInterviewStatus().equalsIgnoreCase("Not Selected")) {
                    				recruitmentStage="Failed In 2nd Round Interview";
                    			}
                    		}
                    	}
                    }
                    if(pr.getHiredStatus()!=null && pr.getHiredStatus().equalsIgnoreCase("Y")) {
                    	recruitmentStage="Recruited";
                    }
                    cell.setCellValue(recruitmentStage);
                    cell = row.createCell(14);
                    cell.setCellValue(DataProccessor.getAgeFromLocalDate(pr.getBirthDate()));
                    cell = row.createCell(15);
                    if(pr.getPin()!=null) {
                    cell.setCellValue(pr.getPin());
                    }else {
						cell.setCellValue("");
					}
                    cell = row.createCell(16);
                    if(pr.getCity()!=null) {
                    cell.setCellValue(pr.getCity());
                    }else {
						cell.setCellValue("");
					}
                    cell = row.createCell(17);
                    if (pr.getHighestQualification() != null && pr.getHighestQualification() != "") {
                        cell.setCellValue((String)listMap.get(pr.getHighestQualification()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(18);
                    if (pr.getPrimaryLanguage() != null && pr.getPrimaryLanguage() != "") {
                        cell.setCellValue((String)listMap.get(pr.getPrimaryLanguage()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(19);
                    if (pr.getSecondaryLanguage() != null && pr.getSecondaryLanguage() != "") {
                        cell.setCellValue((String)listMap.get(pr.getSecondaryLanguage()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(20);
                    cell.setCellValue(pr.getHreName());
                    cell = row.createCell(21);
                    cell.setCellValue(DataProccessor.dateToString(pr.getRegistration_Date()));
                    cell = row.createCell(22);
                    cell.setCellValue(DataProccessor.dateToString(pr.getAssessmentDate()));
                    cell = row.createCell(23);
                    if (pr.getAptitudeScore() != null) {
                        cell.setCellValue((double)pr.getAptitudeScore());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(24);
                    if (pr.getAttitudeScore() != null) {
                        cell.setCellValue((double)pr.getAttitudeScore());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(25);
                    if (pr.getTotalMark() != null) {
                        cell.setCellValue(pr.getTotalMark());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(26);
                    if (pr.getTestScore() != null) {
                        cell.setCellValue(pr.getTestScore());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(27);
                    if (pr.getTestScore() != null && pr.getTotalMark() != null) {
                        final double score = Double.valueOf(pr.getTestScore());
                        final double total = Double.valueOf(pr.getTotalMark());
                        final double per = score / total * 100.0;
                        final double roundOf = Math.round(per * 100.0) / 100.0;
                        cell.setCellValue(roundOf);
                    }else {
						cell.setCellValue("");
					}
                    cell = row.createCell(28);
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
                    
                    cell = row.createCell(29);
                    cell.setCellValue(DataProccessor.dateToString(pr.getInterviewDate()));
                    cell = row.createCell(30);
                    if(pr.getInterviewScore()!=null) {
                    cell.setCellValue(pr.getInterviewScore());
                    }else {
						cell.setCellValue("");
					}
                    cell = row.createCell(31);
                    if(intScore.isPresent() && intScore.get().getInterviewStatus()!=null) {
                    	if(intScore.get().getInterviewStatus().equalsIgnoreCase("Selected")) {
                    		cell.setCellValue("Selected");
                    	}else {
                    		cell.setCellValue("Not Selected");
						}
                    }else {
                    	cell.setCellValue("");
					}
                    cell = row.createCell(32);
                    cell.setCellValue(DataProccessor.dateToString(pr.getInterviewDate2()));
                    cell = row.createCell(33);
                    if(pr.getInterviewScore2()!=null) {
                    cell.setCellValue(pr.getInterviewScore2());
                    }else {
						cell.setCellValue("");
					}
                    cell = row.createCell(34);
                    if(intScore2.isPresent() && intScore2.get().getInterviewStatus()!=null) {
                    	if(intScore2.get().getInterviewStatus().equalsIgnoreCase("Selected")) {
                    		cell.setCellValue("Selected");
                    	}else {
                    		cell.setCellValue("Not Selected");
						}
                    }else {
                    	cell.setCellValue("");
					}
                    cell = row.createCell(35);
                    if(pr.getWorkExperience().size()>0) {
                	   cell.setCellValue("Yes");
                    }else {
                	   cell.setCellValue("");
                    }
                    cell = row.createCell(36);
                    int workExp = 0;
                    final List<WorkExperience> workList = pr.getWorkExperience();
                    for(WorkExperience w : workList) {
                    	workExp = workExp+w.getExpInMths();
                    }
                    cell.setCellValue(workExp);
                    cell = row.createCell(37);
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
                    cell = row.createCell(38);
                    cell.setCellValue(pr.getSource());
                    cell = row.createCell(39);
                    if (pr.getIdProof() != null && pr.getIdProof() != "") {
                        cell.setCellValue((String)listMap.get(pr.getIdProof()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(40);
                    if (pr.getAdharNumber() != null) {
                        cell.setCellValue(pr.getAdharNumber().toString());
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell = row.createCell(41);
                    cell.setCellValue(pr.getEmpSalary());
                    cell = row.createCell(42);
                    cell.setCellValue(pr.getBankAccountNumber());
                    cell = row.createCell(43);
                    cell.setCellValue(pr.getMartialStatus());
                    cell = row.createCell(44);
                    if (pr.getBloodGroup() != null && pr.getBloodGroup() != "") {
                        cell.setCellValue((String)listMap.get(pr.getBloodGroup()));
                    }
                    else {
                        cell.setCellValue("");
                    }
                    cell= row.createCell(45);
                    String status="";
                    if(pr.getParticipantStatus()!=null) {
                    	status = DataProccessor.getParticipantStatus(pr.getParticipantStatus());
                    }
                    cell.setCellValue(status);
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
    
}


