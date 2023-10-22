package com.armezo.duflon.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.armezo.duflon.Entities.HRE;
import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.LMAccesskey;
import com.armezo.duflon.Entities.LMInterview;
import com.armezo.duflon.Entities.LMOptionalDate;
import com.armezo.duflon.Entities.LineManager;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.LMAccesskeyService;
import com.armezo.duflon.Services.LMInterviewService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
import com.armezo.duflon.payload.FilterPayload;
import com.armezo.duflon.payload.InterviewLMAccesskey;
import com.armezo.duflon.payload.LmDate;
import com.armezo.duflon.tc.entities.ModelParticpantView;
import com.armezo.duflon.utils.DataProccessor;

@Controller
public class LineManagerController {

	    @Autowired
	    ParticipantServiceImpl participantserviceImpl;
	    @Autowired
	    LineManagerServiceImpl lmService;
	    @Autowired
	    HREService hreService;
	    @Autowired
	    InterviewScoreService interviewScoreService;
	    @Autowired
	    LMInterviewService lMInterviewService;
	    @Autowired
	    LMAccesskeyService lMAccesskeyService;
	    
		@GetMapping({ "/viewInterview" })
		private String viewInterview(final HttpSession session, Model model) {
			if (session.getAttribute("role") != null) {
				String role = session.getAttribute("role").toString();
				if (role.equalsIgnoreCase("LM")) {
					Long lmId = Long.parseLong(session.getAttribute("userId").toString());
					List<InterviewLMAccesskey> lmList = new ArrayList<>();
					List<LMAccesskey> list = lMAccesskeyService.getInterviewAccesskeyByLMId(lmId);
					for (LMAccesskey lm : list) {
						InterviewLMAccesskey lmAcc = new InterviewLMAccesskey();
						Optional<ParticipantRegistration> p = participantserviceImpl.findByAccesskey(lm.getAccesskey());
						Long hreId = 0L;
						if(p.isPresent()) {
							hreId = p.get().getHreId();
						}
						Optional<HRE> hreOptional = hreService.getById(hreId);
						String hreName="";
						if(hreOptional.isPresent()) {
							hreName = hreOptional.get().getName();
						}
						String name = "";
						name = p.get().getFirstName();
						if (p.get().getMiddleName() != null && p.get().getMiddleName().length() > 0) {
							name += " " + p.get().getMiddleName();
						}
						name += " " + p.get().getLastName();
						lmAcc.setName(name);
						lmAcc.setHreName(hreName);
						lmAcc.setAccesskey(p.get().getAccessKey());
						lmAcc.setLmId(lm.getLmId());
						lmList.add(lmAcc);
					}
					model.addAttribute("participantList", lmList);
				}
			} else {
				return "redirect:login";
			}
			return "lm_accesskey";
		}
	    
		@PostMapping({ "/getDate" })
		@ResponseBody
		private String getDate(@RequestParam("accesskey") String accesskey, final HttpSession session, Model model) {
			if (session.getAttribute("role") != null) {
				String role = session.getAttribute("role").toString();
				if (role.equalsIgnoreCase("LM")) {
					Long lmId = Long.parseLong(session.getAttribute("userId").toString());
					//SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
					//Map<Long, String> map = new HashMap<>();
					List<LMInterview> lmDate = lMInterviewService.findByAccesskey(accesskey);
					List<LMAccesskey> lmAccesskey = lMAccesskeyService.findOtherLM(accesskey, lmId);
					List<LMOptionalDate> optionalDates = lMInterviewService.findOptionalDatesByAccesskey(accesskey);
					StringBuilder selectCode = new StringBuilder();
					StringBuilder tableBodyCode = new StringBuilder();
					selectCode.append("<select id='dateSelect' multiple='multiple' class='form-block'>");
					for (LMInterview lmInt : lmDate) {
						selectCode.append("<option value='" + lmInt.getId() + "'>" + lmInt.getSlotDate() + "</option>");
					}
					selectCode.append("</select>");
					// Table Data Code
					int count=1;
					for(LMAccesskey lmAcc : lmAccesskey) {
						List<Long> selectedDate = DataProccessor.stringToList(lmAcc.getDateId());
						tableBodyCode.append("<tr>");
						tableBodyCode.append("<td>" + count+ "</td>");
						//Get Lm name by id
						Optional<LineManager> lineOpt= lmService.findById(lmAcc.getLmId());
						String lmName="";
						if(lineOpt.isPresent()) {
							lmName=lineOpt.get().getName();
						}
						tableBodyCode.append("<td>" + lmName + "</td>");
						//Set Date in column
						for(int i=0; i<5;i++) {
							if(i<lmDate.size()) {
								LMInterview lmintv = lmDate.get(i);
								//String styleClass = selectedDate.contains(lmintv.getId()) ? "green-date" : "";
								//tableBodyCode.append("<td class='").append(styleClass).append("'>").append(lmintv.getSlotDate()).append("</td>");
								if(selectedDate!=null) {
								String style = selectedDate.contains(lmintv.getId()) ? "background-color: green !important;color: white;" : "";
								tableBodyCode.append("<td style='").append(style).append("'>").append(lmintv.getSlotDate()).append("</td>");
								}
							}else {
								if(i==4) {
									Optional<LMOptionalDate> optDate = optionalDates.stream()
											.filter(optionalDate -> lmAcc.getLmId().equals(optionalDate.getLmId()))
											.findFirst();
									if(optDate.isPresent()) {
										tableBodyCode.append("<td style='").append("background-color: green !important;color: white;").append("'>").append(optDate.get().getOptionalDate()).append("</td>");
									}else {
										tableBodyCode.append("<td></td>");
									}
								}else {
									tableBodyCode.append("<td></td>");
								}
							}
						}
						tableBodyCode.append("</tr>");
						count++;
					}
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("select2Date", selectCode.toString());
					jsonObject.put("tableData", tableBodyCode.toString());
					return jsonObject.toString();
				}
			} else {
				return "redirect:login";
			}
			return "";
		}
		
		
	    
	    @PostMapping({ "/save" })
	    @ResponseBody
	    private String save(@RequestBody LmDate payload,final HttpSession session) {
	    	if (session.getAttribute("userId") != null) {
	    	//Long lmId = Long.parseLong(session.getAttribute("userId").toString());	 
	    	String accesskey = 	payload.getAccesskey();
	    	Long lmId2 = payload.getLmId();
	    	String dates ="";
	    	String newDate = payload.getNewDate();
	    	//Long newDateId=0L;
		    if(newDate!=null && newDate.length()>5) {
		    	LMOptionalDate optDate = lMInterviewService.findOptionalDateByLMIdAndAccesskey(lmId2, accesskey)
		    		    .orElse(new LMOptionalDate());
		    	optDate.setAccesskey(accesskey);
		    	optDate.setOptionalDate(parseDate(newDate));
		    	optDate.setLmId(lmId2);
		    	lMInterviewService.saveOptionalDate(optDate);
		    }
		    //payload.getDateId().add(newDateId);
	    	for(Long l :payload.getDateId()) {
	    		if(dates.equals("")) {
	    			dates = l.toString();
	    		}else {
	    			dates += ","+ l.toString();
	    		}
	    	}
		Optional<LMAccesskey> lm =  lMAccesskeyService.findByAccesskeyAndLmId(accesskey,lmId2);
		if(lm.isPresent()) {
			lm.get().setDateId(dates);
			lMAccesskeyService.save(lm.get());
		}
	    	return  "success";
	    	}else {
	    		 return "redirect:login";
			}
	    }
	    
	    private String parseDate(String input) {   
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            DateFormat outputformat = new SimpleDateFormat("dd-MM-yyyy HH:mm");
            Date date = null;
            String output = null;
            try{
          	 date= df.parse(input);
          	 output = outputformat.format(date);
            }catch(ParseException pe){
               pe.printStackTrace();
             }
            return output;
	    }
	    
	    @GetMapping({ "/viewAllParticapants" })
	    private String viewAllParticipantsOnHO(
	    		@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
	    		final HttpSession session, Model model) {
	    	Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	        	String role = session.getAttribute("role").toString();
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantInpprocessLM( map.get("from"),map.get("to"));
	            if(role.equalsIgnoreCase("HOD")) {
	            	participant.removeIf(part -> part.getHiredStatus()!=null && part.getHiredStatus().equalsIgnoreCase("P"));
	            }
	            listParticipant = this.setDataToHOProcess(participant);
	            FilterPayload payload = new FilterPayload();
	            payload.setDateFrom(dateFromm);
	            payload.setDateTo(dateToo);
				model.addAttribute("payload", payload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            return "LmInProcess";
	        }
	        return "redirect:login";
	    }
	    
	    @GetMapping({ "/viewAllCompletedParticipant" })
	    public String viewAllCompletedParticipantOnHO(
	    		@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
	    		final HttpSession session, Model model) {
	    	Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantEmployeeLM( map.get("from"),map.get("to"));
	            listParticipant = this.setDataToHOProcess(participant);
	            model.addAttribute("participantList", (Object)listParticipant);
	            FilterPayload payload = new FilterPayload();
	            payload.setDateFrom(dateFromm);
	            payload.setDateTo(dateToo);
				model.addAttribute("payload", payload);
	            return "LmEmployee";
	        }
	        return "redirect:login";
	    }
	    
	    @GetMapping({ "/viewAllHoldParticipantLM" })
	    public String viewAllHoldParticipantOnHO(
	    		@RequestParam(name = "dateFromm", required = false) String dateFromm, @RequestParam(name = "dateToo", required = false) String dateToo,
	    		final HttpSession session, Model model) {
	    	Map<String, LocalDate> map = DataProccessor.manageFiltersDate(dateFromm, dateToo);
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantHoldLM( map.get("from"),map.get("to"));
	            listParticipant = this.setDataToHOProcess(participant);
	            FilterPayload payload = new FilterPayload();
	            payload.setDateFrom(dateFromm);
	            payload.setDateTo(dateToo);
				model.addAttribute("payload", payload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            return "LmHoldParticipant";
	        }
	        return "redirect:login";
	    }
	    
	    private List<ModelParticpantView> setDataToHOProcess(final List<ParticipantRegistration> participants) {
	        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        //final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	        for (final ParticipantRegistration p : participants) {
	            if (p.getTestStatus() != null && (p.getTestStatus().equals("1") || p.getTestStatus().equals("3"))) {
	                final ModelParticpantView modelParticpantView = new ModelParticpantView();
	                if (p.getRegistration_Date() != null) {
	                    modelParticpantView.setDateOfRegistration(p.getRegistration_Date().format(df));
	                }
	                if (p.getTestCompletionDate() != null) {
	                    modelParticpantView.setAssessment_Completion_date(p.getTestCompletionDate().format(df));
	                }
	                modelParticpantView.setParticipantName(String.valueOf(String.valueOf(p.getFirstName())) + " " + p.getMiddleName() + " " + p.getLastName());
	                modelParticpantView.setAccesskey(p.getAccessKey());
	                modelParticpantView.setDesignation(p.getDesignation());
	                if (p.getTotalMark() != null) {
	                    modelParticpantView.setTotalMark(p.getTotalMark());
	                }
	                else {
	                    modelParticpantView.setTotalMark("");
	                }
	                if (p.getTestScore() != null) {
	                    modelParticpantView.setTestScore(p.getTestScore());
	                }
	                else {
	                    modelParticpantView.setTestScore(new StringBuilder().append(p.getAttitudeScore()).toString());
	                }
	                if (p.getPercentageScore() != null) {
	                    modelParticpantView.setPercentageScore(p.getPercentageScore());
	                }
	                else if (p.getAttitudeScore() != null && p.getAttitudeScore() > 0) {
	                    final int passingPer = p.getAttitudeScore() / 40 * 100;
	                    modelParticpantView.setPercentageScore(new StringBuilder(String.valueOf(passingPer)).toString());
	                }
	                modelParticpantView.setEmail(p.getEmail());
	                modelParticpantView.setMobile(p.getMobile());
	                modelParticpantView.setTestStatus(p.getTestStatus());
	                modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));
	                modelParticpantView.setPassFailStatus(p.getPassFailStatus());
	                if (p.getInterviewDate() != null) {
	                    final String regDate = p.getInterviewDate().format(df);
	                    final String s = String.valueOf(String.valueOf(regDate)) + " " + p.getInterviewTime();
	                    modelParticpantView.setInterViewDate(s);
	                }
	                else {
	                    modelParticpantView.setInterViewDate("");
	                }
	                if (p.getInterviewDate2() != null) {
	                	final String regDate = p.getInterviewDate2().format(df);
	                	final String s = String.valueOf(String.valueOf(regDate)) + " " + p.getInterviewTime2();
	                	modelParticpantView.setInterViewDate2(s);
	                }
	                else {
	                	modelParticpantView.setInterViewDate2("");
	                }
	                final Optional<InterviewScore> interView = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(p.getAccessKey(),1);
	                final Optional<InterviewScore> interView2 = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskeyAndInterviewCount(p.getAccessKey(),2);
	                if (interView.isPresent()) {
	                    modelParticpantView.setInterViewStatus(interView.get().getStatus());
	                    modelParticpantView.setInterViewPassFailStatus(interView.get().getPass_fail_status());
	                }
	                else {
	                    modelParticpantView.setInterViewStatus("");
	                    modelParticpantView.setInterViewPassFailStatus("");
	                }
	                if (interView2.isPresent()) {
	                	modelParticpantView.setInterViewStatus2(interView.get().getStatus());
	                	modelParticpantView.setInterViewPassFailStatus2(interView.get().getPass_fail_status());
	                }
	                else {
	                	modelParticpantView.setInterViewStatus2("");
	                	modelParticpantView.setInterViewPassFailStatus2("");
	                }
	                if(p.getAptitudeScore() != null) {
	                modelParticpantView.setAptitude((int)p.getAptitudeScore());
	                }else {
	                	  modelParticpantView.setAptitude(0);	
	                }
	                if(p.getAttitudeScore() != null) {
	                modelParticpantView.setAttitude((int)p.getAttitudeScore());
	                }else {
	                	 modelParticpantView.setAttitude(0);	
	                }
	                if(p.getSection3()!=null) {
	                	 modelParticpantView.setMechanical(p.getSection3());
	                 }else {
	                	 modelParticpantView.setMechanical(0);
					}
	                modelParticpantView.setHiredStatus(p.getHiredStatus());
	                modelParticpantView.setPartStatus(p.getParticipantStatus());
	                listParticipant.add(modelParticpantView);
	            }
	        }
	        return listParticipant;
	    }
	    
	    
}
