<%
String userRole = "";
if (session.getAttribute("role") != null) {
	userRole = session.getAttribute("role").toString().trim();
}
%>
 
 <div id="tabs" class="scroll_tabs_theme_light">
                  <span class="tab-btn tab_selected" id="profile">
                      <a href="#" onclick="openProfile()">Profile</a>
                  </span>
                  <span class="tab-btn" id="personal_details">
                      <!-- <a href="#" onclick="openTab('personal')">Personal Details</a> -->
                     <a href="#" onclick="openPersonalDetail()">Personal Details</a>
                  </span>
                  <span class="tab-btn" id="employment_details">
                      <a href="#" onclick="openEmploymentDetails()">Employment Details</a>
                  </span>
                  <span class="tab-btn" id="general_details">
                      <a href="#l" onclick="openGeneralDetails()">General Details</a>
                  </span>
                  <span class="tab-btn" id="work_experience">
                      <a href="#" onclick="openWorkExperiennce()">Work Experience</a>
                  </span>
                  <span class="tab-btn" id="family_member_details">
                      <a href="#" onclick="openFamilyMemberDetails()">Family Member Details</a>
                  </span>
                  <span class="tab-btn" id="emergency_contact">
                      <a href="#" onclick="openEmargencyContact()">Emergency Contact</a>
                  </span>
                  <span class="tab-btn" id="assessment_scores">
                      <a href="#" onclick="openAssessmentScore()">Assessment Scores</a>
                  </span> 
                  <span class="tab-btn" id="upload_documents">
                      <a href="#" onclick="openUploadDocoment()">Upload Documents</a>
                  </span>
				   <%if( session.getAttribute("remove_final") == null) { %>
                  <span class="tab-btn" id="final_submit">
                      <a href="#" onclick="openFinalSubmit()">Final Submit</a>
                  </span>
				   <%}%>
                </div>
                
                <script>
                
                function openTab(tabName){
                	var currentUserRole = "<%= userRole %>";
                	if (currentUserRole !== "") {
                        // Check the user's role and deny access if it's HRE
                        if (currentUserRole === "HRE") {
                        	//console.log('HRE Logged.'+tabName);
                           return false;
                        }else{
                        	//Check tab name and open that
                        	var pKey =	$('#accesskey').val();
                        	if(tabName === 'personal'){
                                window.location.href="getPersonalDetails?accesskey="+pKey;
                        	}
                        }
                    }
                }
                
                function openProfile(){
                  var pKey =	$('#accesskey').val();
                  window.location.href="profileDetails?accesskey="+pKey;
               }
                function openPersonalDetail(){
                  var pKey =	$('#accesskey').val();
                  window.location.href="getPersonalDetails?accesskey="+pKey;
               }
                function openEmploymentDetails(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getempdetails?accesskey="+pKey;
                 }
                function openGeneralDetails(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getgeneraldetails?accesskey="+pKey;
                 }
                function openWorkExperiennce(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getWorkExperience?accesskey="+pKey+"&param";
                 }
                function openFamilyMemberDetails(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getfamilydetails?accesskey="+pKey;
                 }
                function openEmargencyContact(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getEmergencyContact?accesskey="+pKey;
                 }
                function openAssessmentScore(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getAssessmentScore?accesskey="+pKey;
                 } 
                function openUploadDocoment(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="uploadDocoment?accesskey="+pKey;
                 }
                function openFinalSubmit(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="finalSubmit?accesskey="+pKey;
                 }
                </script>