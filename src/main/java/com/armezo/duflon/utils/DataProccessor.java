package com.armezo.duflon.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
	// date in specific format like (04 Dec 2022)
	public static String dateToString(LocalDate date) {
		if (date == null) {
			return "";
		}
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd MMM, yyyy");
		//SimpleDateFormat sdf = new SimpleDateFormat("dd MMM, yyyy");
		return date.format(df);
	}
/*
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
*/
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
	public static String getYTDDateInString(LocalDate dateFrom, LocalDate dateTo) {
		String ytdDate = "";
	/*	Date dateFrom = new Date();
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
			}*/
			// Format this date in Required format
			//SimpleDateFormat sdf = new SimpleDateFormat("dd-MMMM-yyyy");
			//SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
			DateTimeFormatter sdf = DateTimeFormatter.ofPattern("dd-MMM-yyyy");
			//String dateFrom2 = sdf.format(dateFrom);
			//String dateTo2 = sdf.format(dateTo);
			String dateFrom2 = dateFrom.format(sdf);
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
	
	
	
	// CSV Date Formatting
		public static String csvDateFormatting(LocalDate date) {
			String newDate = null;
			try {
			//	DateFormat srcDf = new SimpleDateFormat("yyyy-MM-dd");
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");
				newDate = dtf.format(date);
			} catch (Exception e) {
				return "";
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
		
		//Manage Filter Date
		public static Map<String, LocalDate> manageFiltersDate(String dateFromm, String dateToo) {
			LocalDate dateFrom=LocalDate.of(1997, 11, 15);
	    	LocalDate dateTo=LocalDate.now();
	    	DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE;
	    	if(dateFromm!=null && dateFromm!="") {
	    		dateFrom = LocalDate.parse(dateFromm, formatter);
	    	}
	    	if(dateToo!=null && dateToo!="") {
	    		dateTo = LocalDate.parse(dateToo,formatter);
	    	}
	    	Map<String, LocalDate> map = new HashMap<String, LocalDate>();
	    	map.put("from", dateFrom);
	    	map.put("to", dateTo);
	    	return map;
		}
		//Generate Password
		public static String generatePassword(int length) {
			 final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		     final String NUMBERS = "123456789";
	        StringBuilder sb = new StringBuilder();
	        Random random = new Random();

	        // Generate 8 characters with a mix of characters and numbers
	        for (int i = 0; i < length; i++) {
	            boolean isCharacter = random.nextBoolean();

	            if (isCharacter) {
	                int randomIndex = random.nextInt(CHARACTERS.length());
	                char randomChar = CHARACTERS.charAt(randomIndex);
	                sb.append(randomChar);
	            } else {
	                int randomIndex = random.nextInt(NUMBERS.length());
	                char randomDigit = NUMBERS.charAt(randomIndex);
	                sb.append(randomDigit);
	            }
	        }
	        return sb.toString();
	    }
		
		//Get Participant Status :
		public static String getParticipantStatus(String status) {
			String rs= "";
			if(status!=null && status.equalsIgnoreCase("Assessment")) {
				rs="Assessment Completed";
			}
			if(status!=null && status.equalsIgnoreCase("Document")) {
				rs="Document Uploaded";
			}
			if(status!=null && status.equalsIgnoreCase("Final")) {
				rs="Final Submitted";
			}
			if(status!=null && status.equalsIgnoreCase("Schedule1")) {
				rs="Interview 1 Scheduled";
			}
			if(status!=null && status.equalsIgnoreCase("Schedule2")) {
				rs="Interview 2 Scheduled";
			}
			if(status!=null && status.equalsIgnoreCase("Interview1")) {
				rs="Interview 1 Completed";
			}
			if(status!=null && status.equalsIgnoreCase("Interview2")) {
				rs="Interview 2 Completed";
			}
			if(status!=null && status.equalsIgnoreCase("Recruited")) {
				rs="Recruited";
			}
			return rs;
		}
		public static List<Long> stringToList(String input) {
		    List<Long> result = new ArrayList<>();
		    if(input!=null) {
		    String[] parts = input.split(",");
		    for (String part : parts) {
		        try {
		            Long number = Long.parseLong(part.trim());
		            result.add(number);
		        } catch (NumberFormatException e) {
		            e.printStackTrace();
		        }
		    }
		    }
		    return result;
		}
		

}
