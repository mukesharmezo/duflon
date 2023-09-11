package com.armezo.duflon.Services;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.Optional;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.armezo.duflon.Entities.ErrorLogger;
import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.LineManager;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
import com.armezo.duflon.utils.DataProccessor;

@Service
public class AdminTypeService {
	
	@Autowired
	private HREService hreService;
	@Autowired
	private LineManagerServiceImpl lmService;
	@Autowired
    private ErrorLoggerService errorService;
	
	public String uploadAdminData(String adminType, MultipartFile file) {
		//public String uploadAdminData(MultipartFile file) {
		String message="";
		try {
			Workbook workbook = null;
			workbook = WorkbookFactory.create(file.getInputStream());
			Sheet sheet = workbook.getSheetAt(0);
			Iterator<Row> iterator = sheet.iterator();
			if (iterator.hasNext()) {
				iterator.next();  // leave header row
			}
			while (iterator.hasNext()) {
				Row row = (Row) iterator.next();
				if (!isRowEmpty(row)) {
					if (adminType.equalsIgnoreCase("HRE")) {
						HRE hre = new HRE();
						hre.setName(getStringCellValue(row.getCell(0)));
						hre.setEmpCode(getStringCellValue(row.getCell(1)));
						hre.setEmail(getStringCellValue(row.getCell(2)));
						hre.setMobile(getMobileFromCell(row.getCell(3)));
						hre.setLocation(getStringCellValue(row.getCell(4)));
						hre.setDepartment(getStringCellValue(row.getCell(5)));
						// Set password
						hre.setPassword(DataProccessor.generatePassword(7));
						hre.setStatus(true);
						// find HRE by Email
						Optional<HRE> hreOptional = hreService.findByempCodeAndEmail(hre.getEmpCode(), hre.getEmail());
						if (!hreOptional.isPresent()) {
							hreService.save(hre);
						}
						// Send password on email
						// Email code goes here
					} else if (adminType.equalsIgnoreCase("LM")) {
						LineManager lm = new LineManager();
						lm.setName(getStringCellValue(row.getCell(0)));
						lm.setEmpCode(getStringCellValue(row.getCell(1)));
						lm.setEmail(getStringCellValue(row.getCell(2)));
						lm.setMobile(getMobileFromCell(row.getCell(3)));
						lm.setLocation(getStringCellValue(row.getCell(5))); //Location
						lm.setDepartment(getStringCellValue(row.getCell(5)));
						lm.setPassword(DataProccessor.generatePassword(8));
						lm.setStatus(true);
						Optional<LineManager> lmOpt = lmService.findByempCodeAndEmail(lm.getEmpCode(), lm.getEmail());
						if (!lmOpt.isPresent()) {
							lmService.saveLineManager(lm);
						}else {
						}
					}
				}
			}
			message = "Data Uploaded";
		} catch (InvalidFormatException | IOException e) {
			ErrorLogger error = new ErrorLogger();
            error.setAccesskey("");
            error.setErrorMessage(e.getMessage());
            error.setErrorTime(LocalDateTime.now());
            error.setProcess("Upload Admin Data");
            errorService.saveErrorLogger(error);
			e.printStackTrace();
			message="Error in uploading";
		}
		return message;
	}
	
	private String getStringCellValue(Cell cell) {
		if (cell == null) {
			return "";
		}
		if(cell.getCellType()==Cell.CELL_TYPE_STRING) {
			return cell.getStringCellValue();
		}
		else {
			return "";
		}
	}
	
	private boolean isRowEmpty(Row row) {
	    for (int cellNum = row.getFirstCellNum(); cellNum < row.getLastCellNum(); cellNum++) {
	        Cell cell = row.getCell(cellNum);
	        if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK) {
	            return false;
	        }
	    }
	    return true;
	}
	
	private String getMobileFromCell(Cell cell) {
	    String cellValue = "";
	    if (cell != null) {
	        DataFormatter dataFormatter = new DataFormatter();
	        cellValue = dataFormatter.formatCellValue(cell);
	    }
	    return cellValue;
	}
	

}
