package com.armezo.duflon.controller;

import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.armezo.duflon.Entities.InterviewScore;
import com.armezo.duflon.Entities.ParticipantRegistration;
import com.armezo.duflon.Services.HREService;
import com.armezo.duflon.Services.InterviewScoreService;
import com.armezo.duflon.Services.StateService;
import com.armezo.duflon.ServicesImpl.LineManagerServiceImpl;
import com.armezo.duflon.ServicesImpl.ParticipantServiceImpl;
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
	    StateService stateService;
	    @Autowired
	    InterviewScoreService interviewScoreService;
	    
	    @GetMapping({ "/viewAllParticapants" })
	    private String viewAllParticipantsOnHO(final HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantInpprocessHo();
	            listParticipant = this.setDataToHOProcess(participant);
	            model.addAttribute("participantList", (Object)listParticipant);
	            return "HO";
	        }
	        return "redirect:login";
	    }
	    
	    @GetMapping({ "/viewAllCompletedParticipant" })
	    public String viewAllCompletedParticipantOnHO(final HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantEmployeeHo();
	            listParticipant = this.setDataToHOProcess(participant);
	            model.addAttribute("participantList", (Object)listParticipant);
	            return "HOEmployee";
	        }
	        return "redirect:login";
	    }
	    
	    @GetMapping({ "/viewAllHoldParticipant" })
	    public String viewAllHoldParticipantOnHO(final HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final List<ParticipantRegistration> participant = (List<ParticipantRegistration>)this.participantserviceImpl.getParticipantHoldHo();
	            listParticipant = this.setDataToHOProcess(participant);
	            model.addAttribute("participantList", (Object)listParticipant);
	            return "HoldParticipantHO";
	        }
	        return "redirect:login";
	    }
	    /*
	    @GetMapping({ "/viewParticapant" })
	    private String getDealer(final HttpSession session, final Model model) {
	        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final Long lmId = Long.parseLong(session.getAttribute("userId").toString());
	            final List<Long> list = new ArrayList<Long>();
	            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getLineManager(lmId);
	            final List<ParticipantRegistration> participant = participantserviceImpl.getAllParticipantNotHold("H");	          
	    		// final List<ParticipantRegistration> participant = participantserviceImpl.findByhreIdPendinApproverFSDM(list,dateFrom,dateTo);
	            for (final ParticipantRegistration p : participant) {
	              //  if (p.getFsdmApprovalStatus() != null && (Integer.parseInt(p.getFsdmApprovalStatus()) == 1 || Integer.parseInt(p.getFsdmApprovalStatus()) == 3) && (p.getStatus() == null || !p.getStatus().equals("H"))) {                 
	                    listParticipant.add(setDataToMPV(p)); 
	            }
	            model.addAttribute("participantList", (Object)listParticipant);
	            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
	            return "FSDM";
	        }
	        return "redirect:login";
	    }
	    
	    @GetMapping({ "/viewParticapantInProcess" })
	    private String getDealerInprocess(final HttpSession session, final Model model) {
	        final List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        if (session.getAttribute("userId") != null) {
	            final Long fsdmId = Long.parseLong(session.getAttribute("userId").toString());
	            final List<Long> list = new ArrayList<Long>();
	            final Optional<LineManager> lm = (Optional<LineManager>)this.lmService.getLineManager(fsdmId);
	            final List<ParticipantRegistration> participant = participantserviceImpl.findByhreIdInprocessFSDM(list);
	            for (final ParticipantRegistration p : participant) {
	            	   listParticipant.add(setDataToMPV(p));
	                }
	            model.addAttribute("participantList", (Object)listParticipant);
	            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
	           
	            return "FSDMInprocess";
	        }
	        return "redirect:login";
	    }*/
	    /*
	    @PostMapping({ "/filterParticipantOnFSDM" })
	    public String dealerFilters(@RequestParam("outlet") String outletCode, @RequestParam("candidateName") String candidateName,@RequestParam("uniqueCode") String uniqueCode, 
				@RequestParam("designation") String designation, @RequestParam("mspin") String mspin, @RequestParam("passFailStatus") String passFailStatus, 
				@RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String dateToo, HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
			Date dateFrom=null;
			Date dateTo=null;
			Long hreId=0L;
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				if (dateFromm != null && dateFromm != "") {
					dateFrom = sdf.parse(dateFromm);
				}
				if (dateToo != null && dateToo != "") {
					dateTo = sdf.parse(dateToo);
					dateTo = DataProccessor.addTimeInDate(dateTo);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if (session.getAttribute("userId") != null) {
				//check data 
				if(outletCode==null )
					outletCode="";
				if(candidateName==null)
					candidateName="";
				if(uniqueCode==null) {
					uniqueCode="";
				}
				if(designation==null)
					designation="";
				if(mspin==null)
					mspin="";
				List<Integer> passFStatus = new ArrayList<>();
				if(passFailStatus=="") {
						passFStatus.add(1);
						passFStatus.add(0);
					}else {
						passFStatus.add(Integer.valueOf(passFailStatus));
					}
				
				final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
	            final List<Long> list = new ArrayList<Long>();
	            List<Outlet> dealerCodeList = new ArrayList<Outlet>();
	            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getFSDM(fsdmId);
	            for (final Region r : f.get().getRegion()) {
	                final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
	                for (final Outlet outlet : outletLsit) {
	                	dealerCodeList.add(outlet);
	                    list.add(outlet.getDealer().getId());
	                }
	            }
				List<ParticipantRegistration> participantList=null;
				if(dateFrom!=null && dateTo!=null)
				{
					participantList = participantserviceImpl.getParticipantByFilterDataForFSDM(outletCode,candidateName, designation, mspin,passFStatus,uniqueCode,list,dateFrom,dateTo);
				}else {
					participantList= participantserviceImpl.getParticipantByFilterDataForFSDM2(outletCode, candidateName, designation, mspin, passFStatus, list, uniqueCode);
				}
			    for (final ParticipantRegistration p : participantList) {
			    	
		            if (p.getTestStatus() != null && Integer.parseInt(p.getTestStatus()) == 3 && (p.getFsdmApprovalStatus() == null || Integer.parseInt(p.getFsdmApprovalStatus()) == 3 || Integer.parseInt(p.getFsdmApprovalStatus()) == 1) && (p.getStatus() == null || !p.getStatus().equals("H"))) {
		            	listParticipant.add(setDataToMPV(p));
		            }
			    }
	            final List<Outlet> outlets = outletService.findByhreId((long)hreId);
	            final List<Designation> designations = designationService.getAll();
	            //Adding data to Search 
	            FilterPayload filterPayload = new FilterPayload(outletCode,candidateName,uniqueCode,designation,mspin,passFailStatus,"");
	            filterPayload.setDateFrom(dateFromm);
	            filterPayload.setDateTo(dateToo);
	            model.addAttribute("payload", filterPayload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            model.addAttribute("dealerCodeList", dealerCodeList);
	            model.addAttribute("designations", (Object)designations);
	            model = DataProccessor.setDateRange(model);
	            model.addAttribute("hreId", (Object)hreId);
	            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
	            return "FSDMInprocess";
	        }
	        return "redirect:login";
	    }
	    
	    // Filter For Pending Approval
	    @PostMapping({ "/filterParticipantOnFSDMPending" })
	    public String filterForFSDMInPending(@RequestParam("outlet") String outletCode, @RequestParam("candidateName") String candidateName,@RequestParam("uniqueCode") String uniqueCode, 
				@RequestParam("designation") String designation,@RequestParam("mspin") String mspin, @RequestParam("passFailStatuss") String passFailStatus, 
				@RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String dateToo, HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy");
			Date dateFrom=null;
			Date dateTo=null;
			Long hreId=0L;
			System.out.println("pass..........."+passFailStatus);
			try {
				if (dateFromm != null && dateFromm != "") {
					dateFrom = sdf.parse(dateFromm);
				}
				if (dateToo != null && dateToo != "") {
					dateTo = sdf.parse(dateToo);
					dateTo = DataProccessor.addTimeInDate(dateTo);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if (session.getAttribute("userId") != null) {
				//check data 
				if(outletCode==null )
					outletCode="";
				if(candidateName==null)
					candidateName="";
				if(uniqueCode==null) {
					uniqueCode="";
				}
				if(designation==null)
					designation="";
				if(mspin==null) {
					mspin="";
				}
				System.out.println("pass..........."+passFailStatus);
				List<Integer> passFStatus = new ArrayList<>();
				if(passFailStatus == null || passFailStatus.equals("") ) {
						passFStatus.add(1);
						passFStatus.add(0);
					}else {
						passFStatus.add(Integer.valueOf(passFailStatus));
					}
				
				final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
	            final List<Long> list = new ArrayList<Long>();
	            List<Outlet> dealerCodeList = new ArrayList<Outlet>();
	            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getFSDM(fsdmId);
	            for (final Region r : f.get().getRegion()) {
	                final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
	                for (final Outlet outlet : outletLsit) {
	                	dealerCodeList.add(outlet);
	                    list.add(outlet.getDealer().getId());
	                }
	            }
				List<ParticipantRegistration> participantList=null;
				if(dateFrom!=null && dateTo!=null)
				{
					participantList = participantserviceImpl.getParticipantByFilterDataForFSDM(outletCode,candidateName, designation, mspin,passFStatus,uniqueCode,list,dateFrom,dateTo);
				}else {
					participantList= participantserviceImpl.getParticipantByFilterDataForFSDM2(outletCode, candidateName, designation, mspin, passFStatus, list, uniqueCode);
				}
			    for (final ParticipantRegistration p : participantList) {
			    	
		            if (p.getTestStatus() != null && Integer.parseInt(p.getTestStatus()) == 3 && (p.getFsdmApprovalStatus() != null && Integer.parseInt(p.getFsdmApprovalStatus()) == 3) &&
		            		(p.getStatus() == null || !p.getStatus().equals("H"))) {
		            	listParticipant.add(setDataToMPV(p));
		            }
			    }
	            final List<Outlet> outlets = outletService.findByhreId((long)hreId);
	            final List<Designation> designations = designationService.getAll();
	          //Adding data to Search 
	            FilterPayload filterPayload = new FilterPayload(outletCode,candidateName,uniqueCode,designation,mspin,passFailStatus,"");
	            filterPayload.setDateFrom(dateFromm);
	            filterPayload.setDateTo(dateToo);
	            model.addAttribute("payload", filterPayload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            model.addAttribute("dealerCodeList", dealerCodeList);
	            model.addAttribute("designations", (Object)designations);
	            model = DataProccessor.setDateRange(model);
	            model.addAttribute("hreId", (Object)hreId);
	            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
	            return "FSDM";
	        }
	        return "redirect:login";
	    }
	    
	    // Filter For FSDM Hold Employee
	    @PostMapping({ "/filterParticipantOnFSDMHold" })
	    public String filterForFSDMHold(@RequestParam("outlet") String outletCode, @RequestParam("candidateName") String candidateName,@RequestParam("uniqueCode") String uniqueCode, 
				@RequestParam("designation") String designation,@RequestParam("mspin") String mspin, @RequestParam("passFailStatus") String passFailStatus, 
				@RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String dateToo, HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy");
			Date dateFrom=null;
			Date dateTo=null;
			Long hreId=0L;
			
			try {
				if (dateFromm != null && dateFromm != "") {
					dateFrom = sdf.parse(dateFromm);
				}
				if (dateToo != null && dateToo != "") {
					dateTo = sdf.parse(dateToo);
					dateTo = DataProccessor.addTimeInDate(dateTo);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if (session.getAttribute("userId") != null) {
				//check data 
				if(outletCode==null )
					outletCode="";
				if(candidateName==null)
					candidateName="";
				if(uniqueCode==null) {
					uniqueCode="";
				}
				if(designation==null)
					designation="";
				if(mspin==null)
					mspin="";
				List<Integer> passFStatus = new ArrayList<>();
				if(passFailStatus=="") {
						passFStatus.add(1);
						passFStatus.add(0);
					}else {
						passFStatus.add(Integer.valueOf(passFailStatus));
					}
				
				final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
	            final List<Long> list = new ArrayList<Long>();
	            List<Outlet> dealerCodeList = new ArrayList<Outlet>();
	            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getFSDM(fsdmId);
	            for (final Region r : f.get().getRegion()) {
	                final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
	                for (final Outlet outlet : outletLsit) {
	                	dealerCodeList.add(outlet);
	                    list.add(outlet.getDealer().getId());
	                }
	            }
				List<ParticipantRegistration> participantList=null;
				if(dateFrom!=null && dateTo!=null)
				{
					participantList = participantserviceImpl.getParticipantByFilterDataForFSDM(outletCode,candidateName, designation, mspin,passFStatus,uniqueCode,list,dateFrom,dateTo);
				}else {
					participantList= participantserviceImpl.getParticipantByFilterDataForFSDM2(outletCode, candidateName, designation, mspin, passFStatus, list, uniqueCode);
				}
			    for (final ParticipantRegistration p : participantList) {
			    	
			    	if (p.getStatus() != null && p.getStatus().equals("H")) {
			    		listParticipant.add(setDataToMPV(p));
		            }
			    }
	            final List<Outlet> outlets = outletService.findByhreId((long)hreId);
	            final List<Designation> designations = designationService.getAll();
	          //Adding data to Search 
	            FilterPayload filterPayload = new FilterPayload(outletCode,candidateName,uniqueCode,designation,mspin,passFailStatus,"");
	            filterPayload.setDateFrom(dateFromm);
	            filterPayload.setDateTo(dateToo);
	            model.addAttribute("payload", filterPayload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            model.addAttribute("dealerCodeList", dealerCodeList);
	            model.addAttribute("designations", (Object)designations);
	            model = DataProccessor.setDateRange(model);
	            model.addAttribute("hreId", (Object)hreId);
	            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
	            return "viewHoldEmployeeByFSDM";
	        }
	        return "redirect:login";
	    }
	    
	    // FSDM Employee Master
	    @PostMapping({ "/filterEmployeeMasterFSDM" })
	    public String filterForFSDMEmployeeMaster(@RequestParam("outlet") String outletCode, @RequestParam("candidateName") String candidateName,@RequestParam("uniqueCode") String uniqueCode, 
				@RequestParam("designation") String designation,@RequestParam("mspin") String mspin, @RequestParam("passFailStatus") String passFailStatus, 
				@RequestParam("dateFromm") String dateFromm, @RequestParam("dateToo") String dateToo, HttpSession session, Model model) {
	        List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
	        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy");
			Date dateFrom=null;
			Date dateTo=null;
			Long hreId=0L;
			
			try {
				if (dateFromm != null && dateFromm != "") {
					dateFrom = sdf.parse(dateFromm);
				}
				if (dateToo != null && dateToo != "") {
					dateTo = sdf.parse(dateToo);
					dateTo = DataProccessor.addTimeInDate(dateTo);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if (session.getAttribute("userId") != null) {
				//check data 
				if(outletCode==null )
					outletCode="";
				if(candidateName==null)
					candidateName="";
				if(uniqueCode==null) {
					uniqueCode="";
				}
				if(designation==null)
					designation="";
				if(mspin==null)
					mspin="";
				List<Integer> passFStatus = new ArrayList<>();
				if(passFailStatus=="") {
						passFStatus.add(1);
						passFStatus.add(0);
					}else {
						passFStatus.add(Integer.valueOf(passFailStatus));
					}
				
				final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
	            final List<Long> list = new ArrayList<Long>();
	            List<Outlet> dealerCodeList = new ArrayList<Outlet>();
	            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getFSDM(fsdmId);
	            for (final Region r : f.get().getRegion()) {
	                final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
	                for (final Outlet outlet : outletLsit) {
	                	dealerCodeList.add(outlet);
	                    list.add(outlet.getDealer().getId());
	                }
	            }
				List<ParticipantRegistration> participantList=null;
				if(dateFrom!=null && dateTo!=null)
				{
					participantList = participantserviceImpl.getParticipantByFilterDataForFSDM(outletCode,candidateName, designation, mspin,passFStatus,uniqueCode,list,dateFrom,dateTo);
				}else {
					participantList= participantserviceImpl.getParticipantByFilterDataForFSDM2(outletCode, candidateName, designation, mspin, passFStatus, list, uniqueCode);
				}
			    for (final ParticipantRegistration p : participantList) {
			    	
			    	if(p.getTestStatus() !=null && Integer.parseInt(p.getTestStatus() )== 3 && (p.getFsdmApprovalStatus() != null && Integer.parseInt(p.getFsdmApprovalStatus())==2)) {
			    		listParticipant.add(setDataToMPV(p));
		            }
			    }
	            final List<Outlet> outlets = outletService.findByhreId((long)hreId);
	            final List<Designation> designations = designationService.getAll();
	          //Adding data to Search 
	            FilterPayload filterPayload = new FilterPayload(outletCode,candidateName,uniqueCode,designation,mspin,passFailStatus,"");
	            filterPayload.setDateFrom(dateFromm);
	            filterPayload.setDateTo(dateToo);
	            model.addAttribute("payload", filterPayload);
	            model.addAttribute("participantList", (Object)listParticipant);
	            model.addAttribute("dealerCodeList", dealerCodeList);
	            model.addAttribute("designations", (Object)designations);
	            model = DataProccessor.setDateRange(model);
	            model.addAttribute("hreId", (Object)hreId);
	            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
	            return "employeeFSDM";
	        }
	        return "redirect:login";
	    }
	    // Status Filters
	    @PostMapping({ "/statusFSDMHold" })
		public String checkCompletionProcessFilterOnFSDMHold(@RequestParam(required = false) final String interview,
				@RequestParam(required = false) final String prarambh, @RequestParam(required = false) final String fsdm, final HttpSession session, Model model) {
			List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
			List<Long> hreIdList = new ArrayList<Long>();
			FilterPayload payload = new FilterPayload();
			payload.setInterview(interview);
			payload.setPraraambh(prarambh);
			payload.setFsdmApproved(fsdm);
			Integer interviewSearch = null;
			String praraambhSearch = prarambh;
			List<String> fsdmSearch=new ArrayList<String>();
			if (interview != null)
				interviewSearch = 0;
			if (prarambh != null)
				praraambhSearch = "1";
			if(fsdm!=null) {
				 fsdmSearch.add("1");
				 fsdmSearch.add("3");
				 }

			if (session.getAttribute("userId") != null) {
				final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
		            List<Outlet> dealerCodeList = new ArrayList<Outlet>();
		            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getFSDM(fsdmId);
		            for (final Region r : f.get().getRegion()) {
		                final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
		                for (final Outlet outlet : outletLsit) {
		                	dealerCodeList.add(outlet);
		                    hreIdList.add(outlet.getDealer().getId());
		                }
		            }
				final List<ParticipantRegistration> list = participantserviceImpl.findParticipantsByCompletionFilterOnHold(interviewSearch, praraambhSearch, fsdmSearch,hreIdList);
				  for (final ParticipantRegistration p : list) {
				    	
				    	if (p.getStatus() != null && p.getStatus().equals("H")) {
				    		listParticipant.add(setDataToMPV(p));
			            }
				    }
				 final List<Designation> designations = designationService.getAll();
		            DataProccessor.setDateRange(model);
		            model.addAttribute("payload", payload);
		            model.addAttribute("participantList", (Object)listParticipant);
		            model.addAttribute("dealerCodeList", dealerCodeList);
		            model.addAttribute("designations", (Object)designations);
		            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
		            return "viewHoldEmployeeByFSDM";
			}
			return "redirect:login";
		}
	    
	    @PostMapping({ "/statusFSDMInProcess" })
		public String checkCompletionProcessFilterFSDMInProgress(@RequestParam(required = false) final String interview,
				@RequestParam(required = false) final String prarambh, @RequestParam(required = false) final String fsdm, final HttpSession session, Model model) {
			List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
			List<Long> hreIdList = new ArrayList<Long>();
			FilterPayload payload = new FilterPayload();
			payload.setInterview(interview);
			payload.setPraraambh(prarambh);
			payload.setFsdmApproved(fsdm);
			Integer interviewSearch = null;
			String praraambhSearch = prarambh;
			List<String> fsdmSearch=new ArrayList<String>();
			if (interview != null)
				interviewSearch = 0;
			if (prarambh != null)
				praraambhSearch = "1";
			if(fsdm!=null) {
				 fsdmSearch.add("1");
				 }


			if (session.getAttribute("userId") != null) {
				final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
		            List<Outlet> dealerCodeList = new ArrayList<Outlet>();
		            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getFSDM(fsdmId);
		            for (final Region r : f.get().getRegion()) {
		                final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
		                for (final Outlet outlet : outletLsit) {
		                	dealerCodeList.add(outlet);
		                    hreIdList.add(outlet.getDealer().getId());
		                }
		            }
				final List<ParticipantRegistration> list = participantserviceImpl.findParticipantsByCompletionFilterInProcess(interviewSearch, praraambhSearch, fsdmSearch, hreIdList);
				  for (final ParticipantRegistration p : list) {
					  if(p.getFsdmApprovalStatus()==null || Integer.parseInt(p.getFsdmApprovalStatus())==1){
				    		listParticipant.add(setDataToMPV(p));
					  }
				    }
				 final List<Designation> designations = designationService.getAll();
		            DataProccessor.setDateRange(model);
		            model.addAttribute("payload", payload);
		            model.addAttribute("participantList", (Object)listParticipant);
		            model.addAttribute("dealerCodeList", dealerCodeList);
		            model.addAttribute("designations", (Object)designations);
		            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
		            return "FSDMInprocess";
			}
			return "redirect:login";
		}
	    // Pending Approval Status
	    @PostMapping({ "/statusPendingApproval" })
		public String checkCompletionProcessFilterFSDMPendingApproval(	@RequestParam(required = false) final String prarambh, final HttpSession session, Model model) {
			List<ModelParticpantView> listParticipant = new ArrayList<ModelParticpantView>();
			List<Long> hreIdList = new ArrayList<Long>();
			FilterPayload payload = new FilterPayload();
			payload.setPraraambh(prarambh);
			String praraambhSearch = prarambh;
			System.out.println(prarambh);
			if (prarambh != null)
				praraambhSearch = "2";

			if (session.getAttribute("userId") != null) {
				final int fsdmId = Integer.parseInt(session.getAttribute("userId").toString());
		            List<Outlet> dealerCodeList = new ArrayList<Outlet>();
		            final Optional<LineManager> f = (Optional<LineManager>)this.lmService.getFSDM(fsdmId);
		            for (final Region r : f.get().getRegion()) {
		                final List<Outlet> outletLsit = (List<Outlet>)this.outletService.getOutletByRegion(r.getId());
		                for (final Outlet outlet : outletLsit) {
		                	dealerCodeList.add(outlet);
		                    hreIdList.add(outlet.getDealer().getId());
		                }
		            }
				final List<ParticipantRegistration> list = participantserviceImpl.findParticipantsByCompletionFilterPendingApprovalFSDM(praraambhSearch, hreIdList);
				  for (final ParticipantRegistration p : list) {
				    		listParticipant.add(setDataToMPV(p));
				    }
				 final List<Designation> designations = designationService.getAll();
		            DataProccessor.setDateRange(model);
		            model.addAttribute("payload", payload);
		            model.addAttribute("participantList", (Object)listParticipant);
		            model.addAttribute("dealerCodeList", dealerCodeList);
		            model.addAttribute("designations", (Object)designations);
		            model.addAttribute("pass", DataProccessor.getPassFailStatusMap());
		            return "FSDM";
			}
			return "redirect:login";
		}
	    */
	    
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
	                listParticipant.add(modelParticpantView);
	            }
	        }
	        return listParticipant;
	    }
	    
	    // Set Data in Process*************************************	    
	    private ModelParticpantView setDataToMPV(ParticipantRegistration p) {
	    	final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	    	DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	    	final ModelParticpantView modelParticpantView = new ModelParticpantView();
            modelParticpantView.setParticipantName(String.valueOf(p.getFirstName()) + " " + p.getMiddleName() + " " + p.getLastName());
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
                modelParticpantView.setTestScore("");
            }
            if (p.getPercentageScore() != null) {
                modelParticpantView.setPercentageScore(p.getPercentageScore());
            }
            else {
                modelParticpantView.setPercentageScore("");
            }
            modelParticpantView.setTestStatus(p.getTestStatus());
            modelParticpantView.setInterViewScore(DataProccessor.getIntegerValue(p.getInterviewScore()));
            modelParticpantView.setPassFailStatus(p.getPassFailStatus());
            if (p.getInterviewDate() != null) {
                final String regDate = formatter.format(p.getInterviewDate());
                final String s = String.valueOf(regDate) + ", " + p.getInterviewTime();
                modelParticpantView.setInterViewDate(s);
            }
            else {
                modelParticpantView.setInterViewDate("");
            }
            final Optional<InterviewScore> interView = (Optional<InterviewScore>)this.interviewScoreService.findByAccesskey(p.getAccessKey());
            if (interView.isPresent()) {
                modelParticpantView.setInterViewStatus(interView.get().getStatus());
                modelParticpantView.setInterViewPassFailStatus(interView.get().getPass_fail_status());
            }
            
            modelParticpantView.setDateOfRegistration(p.getRegistration_Date().format(df));
            
            modelParticpantView.setAptitude(p.getAptitudeScore());
            modelParticpantView.setAttitude(p.getAttitudeScore());
            return modelParticpantView;
	    }
	
	
}
