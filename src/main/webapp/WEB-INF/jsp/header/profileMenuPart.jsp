<%
String userRole = "";
if (session.getAttribute("role") != null) {
	userRole = session.getAttribute("role").toString().trim();
}
%>
 
 <div id="tabs" class="scroll_tabs_theme_light">
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
                  <span class="tab-btn" id="upload_documents">
                      <a href="#" onclick="openUploadDocoment()">Upload Documents</a>
                  </span>
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
                                window.location.href="getPersonalDetailsPart?accesskey="+pKey;
                        	}
                        }
                    }
                }
                
                
                function openPersonalDetail(){
                  var pKey =	$('#accesskey').val();
                  window.location.href="getPersonalDetailsPart?accesskey="+pKey;
               }
                function openEmploymentDetails(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getempdetailsPart?accesskey="+pKey;
                 }
                function openGeneralDetails(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getgeneraldetailsPart?accesskey="+pKey;
                 }
                function openWorkExperiennce(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getWorkExperiencePart?accesskey="+pKey+"&param";
                 }
                function openFamilyMemberDetails(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getfamilydetailsPart?accesskey="+pKey;
                 }
                function openEmargencyContact(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="getEmergencyContactPart?accesskey="+pKey;
                 }
                function openUploadDocoment(){
                    var pKey =	$('#accesskey').val();
                    window.location.href="uploadDocomentPart?accesskey="+pKey;
                 }
                </script>