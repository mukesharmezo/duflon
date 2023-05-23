package com.armezo.duflon.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.Period;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;

import com.armezo.duflon.Entities.ParticipantRegistration;

public class DataProccessor {

	public static int getIntegerValue(Integer temp) {

		if (temp != null)
			return temp;
		return 0;
	}

	public static String getStringValue(String temp) {
		if (temp != null)
			return temp;
		return "";
	}

	public static int parseInt(String temp) {
		if (temp == null || temp.equals("")) {
			return 0;
		} else {
			return Integer.parseInt(temp);
		}

	}

	public static LocalDate parseDate(String date) {
		LocalDate newDate = null;
		try {
			//DateFormat srcDf = new SimpleDateFormat("yyyy-MM-dd");
			DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			//newDate = srcDf.parse(date);
			newDate = LocalDate.parse(date, df);
		} catch (Exception e) {
			return null;
		}
		return newDate;
	}
	
	public static Date parseDate2(String date) {
		Date newDate = null;
		try {
			DateFormat srcDf = new SimpleDateFormat("yyyy-MM-dd");
			newDate = srcDf.parse(date);
		} catch (Exception e) {
			return null;
		}
		return newDate;
	}

	public static Date parseDate1(String date) {
		Date newDate = null;
		try {
			DateFormat srcDf = new SimpleDateFormat("dd/MM/yyyy");
			newDate = srcDf.parse(date);
		} catch (Exception e) {
			return null;
		}
		return newDate;
	}

	public static String parseDate1(Date date) {

		if (date == null) {
			return "";
		}
		DateFormat srcDf = new SimpleDateFormat("dd/MM/yyyy");
		return srcDf.format(date);

	}

	public static String parseDateDDMMYY(String d) {
		if (d != null && !d.equals("")) {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-DD");
			Date date;
			try {
				date = (Date) formatter.parse(d);
				SimpleDateFormat newFormat = new SimpleDateFormat("dd/MM/yyyy");
				return newFormat.format(date);

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				return "";
			}

		}
		return "";
	}

	// date in specific format like (04 Dec 2022)
	public static String dateToString(LocalDate date) {
		if (date == null) {
			return "";
		}
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd MMM, yyyy");
		//SimpleDateFormat sdf = new SimpleDateFormat("dd MMM, yyyy");
		return date.format(df);
	}

	// sorting map value in ascending order
	public static Map<String, String> sortMapByValueStringAcs(Map<String, String> map) {
		return map.entrySet().stream().sorted(Map.Entry.comparingByValue())
				.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
	}

	// sorting map value in ascending order
	public static Map<Integer, String> sortMapByValueIntegerAcs(Map<Integer, String> map) {
		return map.entrySet().stream().sorted(Map.Entry.comparingByValue())
				.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
	}

	// sorting map value in ascending order
	public static Map<Long, String> sortMapByValueLongAcs(Map<Long, String> map) {
		return map.entrySet().stream().sorted(Map.Entry.comparingByValue())
				.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
	}

	// Reading resource file
	public static String readFileFromResource(String fileName) {
		String path = "classpath:static/emailtemplate/" + fileName + ".txt";
		String fileContent = "";
		try {
			// Getting file from dest
			File file = ResourceUtils.getFile(path);
			// Reading file data
			fileContent = new String(Files.readAllBytes(file.toPath()));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fileContent;
	}
	/*
	 * public static String getSMS(String fileName) { String
	 * path="classpath:static/smstemplate/"+fileName+".txt"; String fileContent ="";
	 * try { File file = ResourceUtils.getFile(path); fileContent = new
	 * String(Files.readAllBytes(file.toPath())); } catch (Exception e) {
	 * System.out.println("Error : File Not Found.."+e); } return fileContent; }
	 */

	public static String getSMS(String fileName) {
		String path = "classpath:static/smstemplate/" + fileName + ".txt";
		String fileContent = "";
		try {
			File file = ResourceUtils.getFile(path);
			fileContent = new String(Files.readAllBytes(file.toPath()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileContent;
	}

	public static Model setDateRange(Model model) {
//		LocalDate lastMonth = LocalDate.now().minusMonths(1);
//		LocalDate lastStart = LocalDate.now().minusDays(30);
//		// LocalDate lastEnd =
//		// lastMonth.withDayOfMonth(lastMonth.getMonth().maxLength());
//		LocalDate lastEnd = LocalDate.now();
//		LocalDate last3month = lastMonth.minusMonths(2);
//		LocalDate last3Start = last3month.withDayOfMonth(1);
//		LocalDate last3End = lastMonth.withDayOfMonth(lastMonth.getMonth().maxLength());
//		LocalDate last3 = last3month.withDayOfMonth(last3month.getMonth().maxLength());
//		LocalDate lastMonthStart = lastMonth.withDayOfMonth(1);
//		DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("dd/MM/YYYY");
//		model.addAttribute("lastStart", lastStart.format(formatter2));
//		model.addAttribute("lastEnd", lastEnd.format(formatter2));
//		model.addAttribute("lastMStart", lastMonthStart.format(formatter2));
//
//		model.addAttribute("last3MStart", last3Start.format(formatter2));
//		model.addAttribute("last3MEnd", last3End.format(formatter2));
		return model;

	}

	// Birth Date in Years Conversion
	public static String BirthDateInYearsConversion(Date birthDate) {
		if (birthDate == null) {
			return "";
		}
		LocalDate today = LocalDate.now();
		LocalDate birthDate2 = birthDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Period period = Period.between(birthDate2, today);
		int years = period.getYears();
		String ageInYears = String.valueOf(years);
		return ageInYears;
	}

	public static String changeYesNo(String value) {

		if (value == null || value.equals("")) {
			return "";
		}
		if (value.equals("Yes")) {
			return "Y";
		}
		if (value.equals("No")) {
			return "N";
		}
		return "";
	}

//set time stamp in date
	public static Date addTimeInDate(Date date) {
		Instant date1 = date.toInstant()
				.plus(Duration.ofHours(23).plus(Duration.ofMinutes(59).plus(Duration.ofSeconds(59))));
		Date date2 = Date.from(date1);
		return date2;
	}

	// Get YTD Date
	public static String getYTDDateInString() {
		String ytdDate = "";
		Date dateFrom = new Date();
		Date dateTo = new Date();
		// YTD Date By Default
		LocalDate currentDate = LocalDate.now();
		int currentMonthvalue = currentDate.getMonthValue();
		int yearValue = currentDate.getYear();
		LocalDate yearStartDate = null;
			if (currentMonthvalue < 4) {
				YearMonth yearMonth = YearMonth.of(yearValue - 1, 4);
				yearStartDate = yearMonth.atDay(1);
				dateFrom = Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
			} else {
				YearMonth yearMonth = YearMonth.of(yearValue, 4);
				yearStartDate = yearMonth.atDay(1);
				dateFrom = Date.from(yearStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
			}
			// Format this date in Required format
			//SimpleDateFormat sdf = new SimpleDateFormat("dd-MMMM-yyyy");
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
			String dateFrom2 = sdf.format(dateFrom);
			String dateTo2 = sdf.format(dateTo);
			ytdDate=dateFrom2+" to "+dateTo2;
			
		return ytdDate;
	}

	public static Map<String, String> getPassFailStatusMap() {
		Map<String, String> map = new HashMap<>();
		map.put("1", "Pass");
		map.put("0", "Fail");
		return map;
	}
	
	public static String getPassFailStatusMap(ParticipantRegistration p) {
		String name="";
		name = p.getFirstName();
		if(p.getMiddleName() != null && p.getMiddleName().length()>0) {
			name += " "+p.getMiddleName();
		}
		name += " "+p.getLastName();
		return name;
	}
	
	// CSV Date Formatting
		public static String csvDateFormatting(Date date) {
			String newDate = null;
			try {
			//	DateFormat srcDf = new SimpleDateFormat("yyyy-MM-dd");
				DateFormat srcDf = new SimpleDateFormat("dd-MM-yyyy");
				newDate = srcDf.format(date);
			} catch (Exception e) {
				return null;
			}
			return newDate;
		}
		
		public static String getReportName(String  fileName) {
			  final SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			 Calendar cal1 = Calendar.getInstance();
			 String h =cal1.get(Calendar.HOUR_OF_DAY)+"";
			 if(h.length()==1) {
				h  += "0"+h; 
			 }
	           
	            fileName=fileName+"("+formatter.format(cal1.getTime())+" "+h+"-"+  cal1.get(Calendar. MINUTE)+")";
			return fileName;
		}
		//Get Age By LocalDate
		public static String getAgeFromLocalDate(LocalDate date) {
			LocalDate currenDate = LocalDate.now();
			long diff = ChronoUnit.YEARS.between(date, currenDate);
			return String.valueOf(diff);
		}
		//Get Full name of participant
		public static String getFullNameOfParticipant(ParticipantRegistration part) {
			String name = (part.getFirstName() == null ? "" : part.getFirstName()) + " "
					+ (part.getMiddleName() == null ? "" : part.getMiddleName()) + " "
					+ (part.getLastName() == null ? "" : part.getLastName());
			return name;
		}
		

}
