package com.armezo.duflon.csv;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.EventLogerService;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class HOReportController {

	 @Autowired
	    ParticipantServiceImpl participantService;
	    @Autowired
	    HREService hreService;
	    @Autowired
	    InterviewScoreService interviewScoreService;
	    @Autowired
	    EventLogerService eventLogerServer;
	    
		@PostMapping({ "/csvPendingApproval" })
		@ResponseBody
		public ResponseEntity<?> getCSVPendingApprovalEmployee(@RequestParam("dateFromm") final String dateFromm,
				@RequestParam("dateToo") final String dateToo, final HttpSession session, final Model model)
				throws FileNotFoundException {
			if (session.getAttribute("userId") != null) {
				final XSSFWorkbook workbook = new XSSFWorkbook();
				final XSSFSheet sheet = workbook.createSheet("Approval Pending");
				final XSSFCellStyle style = workbook.createCellStyle();
				final XSSFFont font = workbook.createFont();
				font.setBold(true);
				style.setFont((Font) font);
				Row row = null;
				row = (Row) sheet.createRow(0);
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
				cell.setCellValue("Interview Date 2");
				cell = row.createCell(14);
				cell.setCellValue("Interview Score 2");
				cell = row.createCell(15);
				cell.setCellValue("Approval");
				for (int i = 0; i < row.getLastCellNum(); ++i) {
					row.getCell(i).setCellStyle((CellStyle) style);
				}
				Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
				final String role = session.getAttribute("role").toString();
				if (role.equalsIgnoreCase("HOD")) {
					List<ParticipantRegistration> participantList = participantService
							.getAllParticipantsPendingForApproval(map.get("from"), map.get("to"));
					int count = 1;
					for (final ParticipantRegistration pr : participantList) {
						row = (Row) sheet.createRow(count);
						cell = row.createCell(0);
						cell.setCellValue((double) count);
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
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(6);
						if (pr.getTestCompletionDate() != null) {
							cell.setCellValue(DataProccessor.csvDateFormatting(pr.getTestCompletionDate()));
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(7);
						cell.setCellValue((double) pr.getAptitudeScore());
						cell = row.createCell(8);
						cell.setCellValue((double) pr.getAttitudeScore());
						cell = row.createCell(9);
						if (pr.getTestStatus() != null && pr.getTestStatus().equalsIgnoreCase("3")) {
							if (pr.getPassFailStatus() == 1) {
								cell.setCellValue("Pass");
							} else if (pr.getPassFailStatus() == 0) {
								cell.setCellValue("Fail");
							}
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(10);
						if (pr.getReAtampStatus() == null) {
							cell.setCellValue("No");
						} else {
							cell.setCellValue("Yes");
						}
						cell = row.createCell(11);
						if (pr.getInterviewDate() != null) {
							cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate()));
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(12);
						final Optional<InterviewScore> intScore = (Optional<InterviewScore>) this.interviewScoreService
								.findByAccesskeyAndInterviewCount(pr.getAccessKey(), 1);
						final Optional<InterviewScore> intScore2 = (Optional<InterviewScore>) this.interviewScoreService
								.findByAccesskeyAndInterviewCount(pr.getAccessKey(), 2);
						if (intScore.isPresent()) {
							cell.setCellValue(intScore.get().getTotal());
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(13);
						if (pr.getInterviewDate2() != null) {
							cell.setCellValue(DataProccessor.csvDateFormatting(pr.getInterviewDate2()));
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(14);
						if (intScore2.isPresent()) {
							cell.setCellValue(intScore2.get().getTotal());
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(15);
						if (pr.getHiredStatus() != null && pr.getHiredStatus().equalsIgnoreCase("P")) {
							cell.setCellValue("Approval Pending");
						} else {
							cell.setCellValue("");
						}
						++count;
					}
					String fileName = DataProccessor.getReportName("Approval Pending");
					String responseExcelUrl = fileName + ".csv";
					try (FileOutputStream outputStream = new FileOutputStream(responseExcelUrl)) {
						workbook.write(outputStream);
					} catch (Exception e) {
						e.printStackTrace();
					}
					final File file = new File(fileName + ".csv");
					final HttpHeaders header = new HttpHeaders();
					header.add("Content-Disposition", "attachment; filename= " + fileName + ".csv");
					header.add("Cache-Control", "no-cache, no-store, must-revalidate");
					header.add("Pragma", "no-cache");
					header.add("Expires", "0");
					final InputStreamResource resource = new InputStreamResource(
							(InputStream) new FileInputStream(file));
					return (ResponseEntity<?>) ((ResponseEntity.BodyBuilder) ResponseEntity.ok().headers(header))
							.contentLength(file.length())
							.contentType(MediaType.parseMediaType("application/octet-stream")).body((Object) resource);
				}
			}
			return null;
		}
}
