<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
String assessUrl = resource.getString("client.asseesment");
	%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>    <title>Interview Evaluation Result</title>
    <link rel="stylesheet" type="text/css" href="./css/stylee.css" />
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
     <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
     <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    <script src="./js/jquery-3.4.1.min.js"></script>
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
</head>
<style>
    .sweet-alert{width: 475px;left: 50%;top: 50%;}
</style>
<body>
    <div class="header">
        <div class="logo">
        <h2 class="LOGO" style="color: #fff;"><b>DuRecruit</b></h2>
            <!-- <img src="./img/iRecruit-logo_1.svg" alt="" /> -->
        </div>
        <h1>Interview Evaluation Sheet</h1>
    </div>
    <form  id="formoid" class="form">
    <div class="container" id="content">
        <div class="first-card">
            <div class="user-pic">
				<img src="images/${photograph}" />
				 <input type="hidden" id="interviewerCount" value="${interviewerCount}" />
			  <%-- <c:choose>
                <c:when test="${designation eq 'Sales Support'}">
				<img src="images/${photograph}" />
				</c:when>
				<c:otherwise>
                 <img src="<%=assessUrl%>photo/${accesskey}_camTest.jpg"  /> 
                  </c:otherwise>
		        </c:choose> --%>
			
            </div>
            <div class="user-details">
                <div class="user-block">
                    <div class="text-title">Name</div>
                    <div class="text-desc">${name}</div>
                </div>
                <div class="user-block">
                    <div class="text-title">Post applied for</div>
                    <div class="text-desc">${designation}</div>
                </div>
                <div class="user-block">
                    <div class="text-title">Date</div>
                    <div class="text-desc">${date}</div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>

        <div class="evaluators">
            <div class="evaluator-block" id="evaluator01">
                <h2>Interviewer 01</h2>
                <div class="evaluator-fields">
                    <div class="evaluator-field">
                        <div class="evaluator-title">Name</div>
                        <div class="evaluator-input"><input type="text" name="name_a"  value="${score.name_a}" id="name_1" maxlength="55" onkeyup="showSaveBtn()" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/></div>
                    </div>
                    <div class="evaluator-field">
                        <div class="evaluator-title">Designation</div>
                        <div class="evaluator-input"><input type="text" name="designation_a" value="${score.designation_a}" id="designation_1" onkeyup="showSaveBtn()" maxlength="55" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/></div>
                    </div>
                    <div class="evaluator-field">
                        <div class="evaluator-title">Mobile Number</div>
                        <div class="evaluator-input"><input type="text" id="mobile_1" name="mobile_a" value="${score.mobile_a}" minlength="10" maxlength="10" onkeyup="showSaveBtn()"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/></div>
                    </div>
                </div>
                
                <h3>Parameters</h3>
                <div class="points-section">
                    <div class="points-block">
                        <h4>Clarity of Communication<span data-id="clarity"></span></h4>
                        <div class="point" >
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Presentability<span data-id="presentability"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Attitude and Confidence<span data-id="attitude"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Situation Handling Skills / Relevant Experience<span data-id="situation"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                </div>
                <div class="average-marks">
                    Score: <span id="avg_1">${score.total_a}</span>
                </div>
            </div>
            <div class="evaluator-block" id="evaluator02">
                <h2>Interviewer 02</h2>
                <div class="evaluator-fields">
                    <div class="evaluator-field">
                        <div class="evaluator-title">Name</div>
                        <div class="evaluator-input"><input type="text" name="name_b" value="${score.name_b}" id="name_2" maxlength="55" onkeyup="showSaveBtn()" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/></div>
                    </div>
                    <div class="evaluator-field">
                        <div class="evaluator-title">Designation</div>
                        <div class="evaluator-input"><input type="text" name="designation_b" value="${score.designation_b}" id="designation_2" onkeyup="showSaveBtn()" maxlength="55" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/></div>
                    </div>
                    <div class="evaluator-field">
                        <div class="evaluator-title">Mobile Number</div>
                        <div class="evaluator-input"><input type="text" name="mobile_b"  id="mobile_2" value="${score.mobile_b}" minlength="10" maxlength="10" onkeyup="showSaveBtn()"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/></div>
                    </div>
                </div>
                
                <h3>&nbsp;</h3>
                <div class="points-section">
                    <div class="points-block">
                        <h4>Clarity of Communication<span data-id="clarity"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Presentability<span data-id="presentability"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Attitude and Confidence<span data-id="attitude"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Situation Handling Skills / Relevant Experience<span data-id="situation"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                </div>
                <div class="average-marks">
                    Score: <span id="avg_2">${score.total_b}</span>
                </div>
            </div>
            <div class="evaluator-block" id="evaluator03">
                <h2>Interviewer 03</h2>
                <div class="evaluator-fields">
                    <div class="evaluator-field">
                        <div class="evaluator-title">Name</div>
                        <div class="evaluator-input"><input type="text" name="name_c" value="${score.name_c}" id="name_3" onkeyup="checkBtn()" maxlength="55" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/></div>
                    </div>
                    <div class="evaluator-field">
                        <div class="evaluator-title">Designation</div>
                        <div class="evaluator-input"><input type="text" name="designation_c" value="${score.designation_c}" id="designation_3" onkeyup="checkBtn()" maxlength="55" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/></div>
                    </div>
                    <div class="evaluator-field">
                        <div class="evaluator-title">Mobile Number</div>
                        <div class="evaluator-input"><input type="text" name="mobile_c" value="${score.mobile_c}" name="mobile_b" minlength="10" maxlength="10" onkeyup="checkBtn()"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" id="mobile_3"/></div>
                    </div>
                </div>
                
                <h3>&nbsp;</h3>
                <div class="points-section">
                    <div class="points-block">
                        <h4>Clarity of Communication<span data-id="clarity"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Presentability<span data-id="presentability"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Attitude and Confidence<span data-id="attitude"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                    <div class="points-block">
                        <h4>Situation Handling Skills / Relevant Experience<span data-id="situation"></span></h4>
                        <div class="point">
                            <span data-rating="1">1</span>
                            <span data-rating="2">2</span>
                            <span data-rating="3">3</span>
                            <span data-rating="4">4</span>
                            <span data-rating="5">5</span>
                        </div>
                    </div>
                </div>
                <div class="average-marks">
                    Score: <span id="avg_3">${score.total_c}</span>
                </div>
            </div>
            <div class="clear"></div>
        </div>

        <div class="user-marks">
            <div class="user-mark">
                <div class="mark-title">Total Marks<span>(Min. 60% for selection)</span></div>
                <div class="mark-desc"><span id="total-marks">--</span></div>
            </div>
            <div class="user-mark">
            <div style="text-align: center">
                <div class="mark-title">Average Score</div>
                <div class="mark-desc"><span id="averageScore">--</span></div>
                </div>
            </div>
            <div class="user-mark" >
            <div style="float:right;">
                <div class="mark-title" > Participant Status</div>
                <div class="mark-desc"><span id="pass_fail_status">--</span></div>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="tnc"><span onclick="oenPopup()">Suggestive Questions</span>   <span style="margin-left: 10px;" onclick="funexport('suggestive')"><a href="#"><img src="./img/pdf-icn.svg"/></a></span></div>
		<div class="tnc">
				<span style="cursor: default;">Interview Evaluation Sheet</span>    <span style="margin-left: 10px;" onclick="funexport('interview')"><a href="#"><img src="./img/pdf-icn.svg"/></a></span>
			</div>
        
        <div class="action-section">
			<h2 id="msg"></h2>
			
            <input type="button" class="btn blue-btn" onclick="save('save')" id="btn_save" value="Save"/>
			
            <c:if test="${score.status eq 'final' && editStatus eq '1' && check eq 'check'}">
            <input type="button" class="btn blue-btn" value="Edit" id="btn_edit" onclick="edit()"/>
            </c:if>
               
                    <input type="button" class="btn blue-btn" value="Submit"  style="display: none;" id="btn_submit" onclick="save('final')"/>
              
                 <c:if test="${score.status eq 'final'}">
                    <input type="button" class="btn blue-btn" value=" Download PDF"  id="btn_pdf" onclick="CreatePDFfromHTML1()"/>
                </c:if>
        </div>
    </div>

    <div class="question-popup" id="sugestive">
        <div class="popup-close">x</div>
        <div class="popup-content">
            <div class="popup-area" id="clarity">
                <h3>Clarity of communication</h3>
                <ul>
                    <li>Command over Content</li>
                    <li>Clarity of thought and expression</li>
                </ul>
                <h4 class="lg">Suggestive Questions</h4>
                <h4>Fresher</h4>
                <ul>
                    <li>Tell me about yourself (introduce yourself)</li>
                    <li>What were your marks/grades in graduation/school?</li>
                    <li>What other extra-curricular activities were you involved in at your school/college?</li>
                    <li>What is your presence on social networking sites?</li>
                    <li>Why do you want to work in a sales profile?</li>
                </ul>
                <h4>Experienced</h4>
                <ul>
                    <li>Tell me about yourself (introduce yourself)</li>
                    <li>What is your presence on social networking sites?</li>
                    <li>What was your job role in your last company?</li>
                    <li>Why do you want to switch your current company ?</li>
                    <li>What kind of salary do you expect?</li>
                </ul>
            </div>
            <div class="popup-area" id="presentability">
                <h3>Personality & Presentability</h3>
                <ul>
                    <li>Appearance</li>
                    <li>Body Language</li>
                    <li>Hygiene Factor</li>
                </ul>
                <h4 class="lg">Suggestive Questions</h4>
                <ul>
                    <li>Observe the body posture.</li>
                    <li>Observe the appearance, and how well-dressed the candidate is.</li>
                    <li>What are your hobbies?</li>
                    <li>Why do you want to work here?</li>
                    <li>Where do you see yourself after five years from now?</li>
                </ul>
            </div>
            <div class="popup-area" id="attitude">
                <h3>Attitude & Confidence</h3>
                <ul>
                    <li>Positive Attitude</li>
                    <li>Confidence</li>
                </ul>
                <h4 class="lg">Suggestive Questions</h4>
                <ul>
                    <li>What are your strengths?</li>
                    <li>What are your weaknesses?</li>
                    <li>Observe if the candidate is fumbling while speaking.</li>
                    <li>If your colleague meets with an accident and he contacts you while you are busy at your child's/mother's birthday, what will you do?</li>
                </ul>
            </div>
            <div class="popup-area" id="situation">
                <h3>Situation Handling Skills - <span>if fresher</span> <br>Relevant Experience - <span>if work experience</span></h3>
                <h4 class="lg">Suggestive Questions</h4>
                <h4>Fresher</h4>
                <ul>
                    <li>Sell a pen/ watch to the interviewer</li>
                    <!-- <li>If you get an offer from competition dealership tomorrow, what will you do?</li> -->
                    <li>What will you do if you get an offer from a competition company tomorrow?</li>
                </ul>
                <h4>Experienced</h4>
                <ul>
                    <!-- <li>Other than sales, what were your responsibilities when you worked for your last company/dealership?</li> -->
                    <li>What were your responsibilities when you worked for your last company besides sales?</li>
                    <li>If a customer asks for a delivery on the same day for a particular vehicle and you do not have stock. How will you handle such a customer?</li>
                    <li>How will you handle a customer complaint logged due to your behavior with the customer while making a deal on a new launch model?</li>
                    <li>References and any other career achievement you want to share</li>
                </ul>
            </div>
        </div>
    </div>
     <div class="delete-popup">
        <p>Are you sure you want to submit the candidate details?</p>
        <div class="form-button">
            <input type="button" class="submit-btn" onclick="save('final')" value="Yes" />
            <input type="button" class="cancel-btn outline-btn" onclick="closePop(event)" value="No" />
        </div>
    </div>
    <div class="blk-bg"></div>
     
    <input type="hidden" name="clarity_a" value="${score.clarity_a}" id="clarity_1"/>
    <input type="hidden" name="presentability_a" value="${score.presentability_a}" id="presentability_1"/>
    <input type="hidden" name="attitude_a" value="${score.attitude_a}" id="attitude_1"/>
    <input type="hidden" name="situation_a" value="${score.situation_a}" id="situation_1"/>
    <input type="hidden" name="total_a" value="${score.total_a}" id="total_a"/>
    
    <input type="hidden" name="clarity_b" value="${score.clarity_b}" id="clarity_2"/>
    <input type="hidden" name="presentability_b" value="${score.presentability_b}" id="presentability_2"/>
    <input type="hidden" name="attitude_b" value="${score.attitude_b}" id="attitude_2"/>
    <input type="hidden" name="situation_b" value="${score.situation_b}" id="situation_2"/>
    <input type="hidden" name="total_b" value="${score.total_b}" id="total_b"/>
    
    <input type="hidden" name="clarity_c" value="${score.clarity_c}" id="clarity_3"/>
    <input type="hidden" name="presentability_c" value="${score.presentability_c}" id="presentability_3"/>
    <input type="hidden" name="attitude_c" value="${score.attitude_c}" id="attitude_3"/>
    <input type="hidden" name="situation_c" value="${score.situation_c}" id="situation_3"/>
    <input type="hidden" name="total_c" value="${score.total_c}" id="total_c"/>
    
    <input type="hidden" name="total" value="${score.total }" id="total"/>
     <input type="hidden" name="total_avt" value="" id="total_avt"/>
    <input type="hidden" name="accesskey" id="accesskey"  value="${accesskey}">
    <input type="hidden" name="status"   value="${score.status }" id="save_status">
    <input type="hidden" name="percentage"   value="${score.percentage }" id="pesentage">
     <input type="hidden" name="pass_fail"   value="${score.pass_fail_status }" id="pass_fail">
	 <input type="hidden" name="interviewCount"   value="${score.interviewCount }" id="interviewCount">
	 <input type="hidden" name=""   value="${accesskey}_${name}.pdf" id="pdf">
    </form>
	<style>
	.hideclick {pointer-events:none;}
    .sweet-alert h2{text-align: left !important;}
	</style>
    <script>
        $(document).ready(function(){
        	showRating();
			disableCheck();
            var count = 12;
            var s1_1,s1_2,s1_3,s1_4,s2_1,s2_2,s2_3,s2_4,s3_1,s3_2,s3_3,s3_4 = 0;
            $('#evaluator01 .points-block:nth-child(1) .point span').click(function(){
                s1_1 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#clarity_1").val(s1_1);
                average1();
                showSaveBtn();
				total();
            });
            $('#evaluator01 .points-block:nth-child(2) .point span').click(function(){
                s1_2 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#presentability_1").val(s1_2);
                average1();
                showSaveBtn();
				total();
            });
            $('#evaluator01 .points-block:nth-child(3) .point span').click(function(){
                s1_3 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#attitude_1").val(s1_3);
                average1();
                showSaveBtn();
				total();
            });
            $('#evaluator01 .points-block:nth-child(4) .point span').click(function(){
                s1_4 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#situation_1").val(s1_4);
                average1();
                showSaveBtn();
				total();
            });

            $('#evaluator02 .points-block:nth-child(1) .point span').click(function(){
                s2_1 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#clarity_2").val(s2_1);
                average2();
                showSaveBtn();
				total();
            });
            $('#evaluator02 .points-block:nth-child(2) .point span').click(function(){
                s2_2 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#presentability_2").val(s2_2);
                average2();
                showSaveBtn();
				total();
            });
            $('#evaluator02 .points-block:nth-child(3) .point span').click(function(){
                s2_3 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#attitude_2").val(s2_3);
                average2();
                showSaveBtn();
				total();
            });
            $('#evaluator02 .points-block:nth-child(4) .point span').click(function(){
                s2_4 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#situation_2").val(s2_4);
                average2();
                showSaveBtn();
				total();
            });

            $('#evaluator03 .points-block:nth-child(1) .point span').click(function(){
                s3_1 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#clarity_3").val(s3_1);
                average3();
                checkBtn();
                total();
				total();
            });
            $('#evaluator03 .points-block:nth-child(2) .point span').click(function(){
                s3_2 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#presentability_3").val(s3_2);
                average3();
                checkBtn();
                total();
            });
            $('#evaluator03 .points-block:nth-child(3) .point span').click(function(){
                s3_3 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#attitude_3").val(s3_3);
                average3();
                checkBtn();
                total();
            });
            $('#evaluator03 .points-block:nth-child(4) .point span').click(function(){
                s3_4 = Number($(this).data('rating'));
                $(this).parent().find('span').removeClass('active');
                var tpoint = $(this).data('rating');
                for(var i = 1; i<= tpoint; i++) {
                    $(this).parent().find('span:nth-child('+i+')').addClass('active');
                } 
                $("#situation_3").val(s3_4);
                average3();
                checkBtn();
                total();
            }); 
            
           
            $('.popup-close').click(function(){
                $('.question-popup, .blk-bg').hide();
                $('.popup-area').removeClass('active noborder');
            });

            $('.points-block h4 span').click(function(){
                var dataid = $(this).data('id');
                $('.question-popup, .blk-bg').show();
                $('.popup-area').removeClass('active');
                $('#'+dataid).addClass('active noborder');
            });
            
            
			// total1();
            average1();
            average2()
            average3()
            checkBtn();
            showSaveBtn();
			total();
			var showStatus = $("#save_status").val();
			if(showStatus =="final"){	
			 $('input').attr('disabled', 'disabled');
			 $(".evaluators").find("span").addClass("hideclick");
			 $('#btn_pdf').prop('disabled', false);
			 $('#btn_edit').prop('disabled', false);
			 $('#btn_submit').hide(); 
			 $('#btn_save').hide();
			}
            
        });
        function average1(){
        	var clarity_1 =   Number($("#clarity_1").val());
        	var presentability_1= Number($("#presentability_1").val());
        	var attitude_1= Number($("#attitude_1").val());
        	var situation_1 =  Number($("#situation_1").val());
        	if(clarity_1 !="" && presentability_1 != "" && attitude_1 != "" && situation_1 != "")
        	 {
        	 var totl_1 = clarity_1+presentability_1+attitude_1+situation_1;	
        	 var avg_1 = totl_1;      	
                $('#avg_1').text('');
    	        $("#avg_1").append(avg_1+'/'+'20');
    	        $("#total_a").val(Math.round(avg_1));
        	 }
        }
        function average2(){
        	var clarity_2 =   Number($("#clarity_2").val());
        	var presentability_2= Number($("#presentability_2").val());
        	var attitude_2= Number($("#attitude_2").val());
        	var situation_2 =  Number($("#situation_2").val());
        	if(clarity_2 !="" && presentability_2 != "" && attitude_2 != "" && situation_2 != "")
        	 {
        	    var totl_2 = clarity_2+presentability_2+attitude_2+situation_2;	
        	    var avg_2 = totl_2;      	
                $('#avg_2').text('');
    	        $("#avg_2").append(avg_2+'/'+'20');
    	        $("#total_b").val(Math.round(avg_2));
        	 }
        }
        function average3(){
        	
        	var clarity_3 =   Number($("#clarity_3").val());
        	var presentability_3= Number($("#presentability_3").val());
        	var attitude_3= Number($("#attitude_3").val());
        	var situation_3 =  Number($("#situation_3").val());
        	if(clarity_3 !="" && presentability_3 != "" && attitude_3 != "" && situation_3 != "")
        	 {
        	    var totl_3 = clarity_3+presentability_3+attitude_3+situation_3;	
        	    var avg_3 = totl_3;      	
                $('#avg_3').text('');
    	        $("#avg_3").append(avg_3+'/'+'20');
    	        $("#total_c").val(Math.round(avg_3));
        	 }
        }
        
        function total(){
        	var clarity_1 =   Number($("#clarity_1").val());
        	var presentability_1= Number($("#presentability_1").val());
        	var attitude_1= Number($("#attitude_1").val());
        	var situation_1 =  Number($("#situation_1").val());
        	
        	var clarity_2 =   Number($("#clarity_2").val());
        	var presentability_2= Number($("#presentability_2").val());
        	var attitude_2= Number($("#attitude_2").val());
        	var situation_2 =  Number($("#situation_2").val());
        	
        	var clarity_3 =   Number($("#clarity_3").val());
        	var presentability_3= Number($("#presentability_3").val());
        	var attitude_3= Number($("#attitude_3").val());
        	var situation_3 =  Number($("#situation_3").val());
        	
        	var intvCount = $("#interviewerCount").val();
        	
        	var total = Number(clarity_1)+Number(presentability_1)+Number(attitude_1)+Number(situation_1)+Number(clarity_2)+Number(presentability_2)
        	           +Number(attitude_2)+Number(situation_2)+Number(clarity_3)+Number(presentability_3)+Number(attitude_3)+Number(situation_3);
            $("#total").val(total);
	        var averageScore = total/2;
			
	        if(intvCount==1){
	        	var avg2 = total; 
	        	if(clarity_1 !="" && presentability_1 != "" && attitude_1 != "" && situation_1 != ""){
	        		$("#total_avt").val(averageScore.toFixed(1));
		        	 $("#averageScore").text('');
		 	         $("#averageScore").append(total+'/'+20);
					 $('#total-marks').text('');
		             $("#total-marks").append(total+'/'+20);
		        	   var per = total*100/20;
		        	   if(per>=60){
		        		   $('#pass_fail_status').text('');
		       	           $('#pass_fail_status').append('Selected');  
		       	           $("#pass_fail").val("pass");
		       	           $("#pesentage").val(per);
		        	   }else{
		        		   $('#pass_fail_status').text('');
		       	           $('#pass_fail_status').append('Not Selected');
		       	           $("#pass_fail").val("fail");
		       	           $("#pesentage").val(per);
		        	   }
					   $('#pass_fail_status').show();  
	            	   $("#total-marks").show();
					   $("#averageScore").show();
	        	}
	        }
	        
	        if(intvCount>1){
	        
	        if(clarity_1 !="" && presentability_1 != "" && attitude_1 != "" && situation_1 != "" && 
	           clarity_2 !="" && presentability_2 != "" && attitude_2 != "" && situation_2 != "" &&(clarity_3 =="" && presentability_3 == "" && attitude_3 == "" && situation_3 == ""))
	          {
	        	 $("#total_avt").val(averageScore.toFixed(1));
	        	 $("#averageScore").text('');
	 	         $("#averageScore").append(averageScore.toFixed(1)+'/'+20);
				 $('#total-marks').text('');
	             $("#total-marks").append(total+'/'+40);
	        	   var per = total*100/40;
	        	   if(per>=60){
	        		   $('#pass_fail_status').text('');
	       	           $('#pass_fail_status').append('Selected');  
	       	           $("#pass_fail").val("pass");
	       	           $("#pesentage").val(per);
	        	   }else{
	        		   $('#pass_fail_status').text('');
	       	           $('#pass_fail_status').append('Not Selected');
	       	           $("#pass_fail").val("fail");
	       	           $("#pesentage").val(per);
	        	   }
				   $('#pass_fail_status').show();  
            	   $("#total-marks").show();
				   $("#averageScore").show();
				  
	         }
	        
	        if(clarity_3 !="" && presentability_3 != "" && attitude_3 != "" && situation_3 != "")
		        {
					 var averageScore = total/3;
	        	       $("#total_avt").val(averageScore.toFixed(1));
	        	       $("#averageScore").text('');
	 	               $("#averageScore").append(averageScore.toFixed(1)+'/'+20);
	                   $('#total-marks').text('');
		               $("#total-marks").append(total+'/'+60);
		        	   var per = total*100/60;
		        	   if(per>=60){
		        		   $('#pass_fail_status').text('');
		       	           $('#pass_fail_status').append('Selected');  
		       	           $("#pass_fail").val("pass");
		       	           $("#pesentage").val(per);
		        	   }else{
		        		   $('#pass_fail_status').text('');
		       	           $('#pass_fail_status').append('Not Selected'); 
		       	          $("#pass_fail").val("fail");
		       	          $("#pesentage").val(per);
		        	   }
					    
				   $('#pass_fail_status').show();  
            	   $("#total-marks").show();
				   $("#averageScore").show();
				    
		      }
	        }
        
        }
		
		 function total1(){
        	var clarity_1 =   Number($("#clarity_1").val());
        	var presentability_1= Number($("#presentability_1").val());
        	var attitude_1= Number($("#attitude_1").val());
        	var situation_1 =  Number($("#situation_1").val());
        	
        	var clarity_2 =   Number($("#clarity_2").val());
        	var presentability_2= Number($("#presentability_2").val());
        	var attitude_2= Number($("#attitude_2").val());
        	var situation_2 =  Number($("#situation_2").val());
        	
        	var clarity_3 =   Number($("#clarity_3").val());
        	var presentability_3= Number($("#presentability_3").val());
        	var attitude_3= Number($("#attitude_3").val());
        	var situation_3 =  Number($("#situation_3").val());
        	
        	var total = Number(clarity_1)+Number(presentability_1)+Number(attitude_1)+Number(situation_1)+Number(clarity_2)+Number(presentability_2)
        	           +Number(attitude_2)+Number(situation_2)+Number(clarity_3)+Number(presentability_3)+Number(attitude_3)+Number(situation_3);
            $("#total").val(total);
            console.log('Total :: '+total);
	       var  averageScore = total/3;
	        if(clarity_1 !="" && presentability_1 != "" && attitude_1 != "" && situation_1 != "" && 
	           clarity_2 !="" && presentability_2 != "" && attitude_2 != "" && situation_2 != "")
	          {
	        	 $("#total_avt").val(averageScore.toFixed(1));
	        	 $('#total-marks').text('');
	 	         $("#total-marks").append(total+'/'+40);
	        	   $("#averageScore").text('');
	 	           $("#averageScore").append(averageScore.toFixed(1)+'/'+20);
	        	   var per1 = total*100/40;
	        	   if(per1>=60){
	        		   $('#pass_fail_status').text('');
	       	           $('#pass_fail_status').append('Selected');  
	       	           $("#pass_fail").val("pass");
	       	           $("#pesentage").val(per1);
	        	   }else{
	        		   $('#pass_fail_status').text('');
	       	           $('#pass_fail_status').append('Not Selected');
	       	           $("#pass_fail").val("fail");
	       	           $("#pesentage").val(per1);
	        	   }
				   $('#pass_fail_status').show();  
            	   $("#total-marks").show();
	         }
        }
		
		function disableCheck(){
		var clarity_1 =   Number($("#clarity_1").val());
        	var presentability_1= Number($("#presentability_1").val());
        	var attitude_1= Number($("#attitude_1").val());
        	var situation_1 =  Number($("#situation_1").val());
        	
        	var clarity_2 =   Number($("#clarity_2").val());
        	var presentability_2= Number($("#presentability_2").val());
        	var attitude_2= Number($("#attitude_2").val());
        	var situation_2 =  Number($("#situation_2").val());
        	
        	var clarity_3 =   Number($("#clarity_3").val());
        	var presentability_3= Number($("#presentability_3").val());
        	var attitude_3= Number($("#attitude_3").val());
        	var situation_3 =  Number($("#situation_3").val());
        	
        	var name_1 =   Number($("#name_1").val());
        	var designation_1= Number($("#mobile_1").val());
        	var mobile_1= Number($("#mobile_1").val());
        	
        	var name_2        =   $("#name_2").val();
        	var designation_2 =   $("#mobile_2").val();
        	var mobile_2      =   $("#mobile_2").val();
        	
        	var name_3        =   $("#name_3").val();
        	var designation_3 =   $("#mobile_3").val();
        	var mobile_3      =   $("#mobile_3").val();	
        	
        	
        	var intvCount = $("#interviewerCount").val();
        	console.log("Intv Count :: "+intvCount);
			if(clarity_1 =="" || presentability_1 == "" || attitude_1 == "" || situation_1 == "" || name_1 =="" || designation_1 == "" || mobile_1 =="" || intvCount == 1 )
        	 {
				 $("#evaluator02").addClass("disabbleDefault");
				 
			 }else{
				  $("#evaluator02").removeClass("disabbleDefault");
			 }
			 
			 if(clarity_1 =="" || presentability_1 == "" || attitude_1 == "" || situation_1 == "" || name_1 =="" || designation_1 == "" || mobile_1 =="" ||
			 clarity_2 =="" || presentability_2 == "" || attitude_2 == "" || situation_2 == "" || name_2 =="" || designation_2 == "" || mobile_2 ==""  || intvCount == 2 )
        	 {
				 console.log("03 Dis :: "+intvCount);
				 $("#evaluator03").addClass("disabbleDefault");
				 
			 }else{
				 console.log("03 Ena :: "+intvCount);
				  $("#evaluator03").removeClass("disabbleDefault");
			 }
		}



         function validateValue(value){
		var flag = false;
			var temp = value.charAt(0);
		for(i=1; i<value.length; i++){
    		if(value.charAt(i) != temp){
        		flag = true;
        		return flag;
    		}
    		temp=value.charAt(i);
		}
			
            }
		
        
      function showSaveBtn(){
		  disableCheck();
		  
        	var clarity_1 =   Number($("#clarity_1").val());
        	var presentability_1= Number($("#presentability_1").val());
        	var attitude_1= Number($("#attitude_1").val());
        	var situation_1 =  Number($("#situation_1").val());
        	
        	var clarity_2 =   Number($("#clarity_2").val());
        	var presentability_2= Number($("#presentability_2").val());
        	var attitude_2= Number($("#attitude_2").val());
        	var situation_2 =  Number($("#situation_2").val());
        	
        	var clarity_3 =   Number($("#clarity_3").val());
        	var presentability_3= Number($("#presentability_3").val());
        	var attitude_3= Number($("#attitude_3").val());
        	var situation_3 =  Number($("#situation_3").val());
        	
        	var name_1 =   Number($("#name_1").val());
        	var designation_1= Number($("#mobile_1").val());
        	var mobile_1= Number($("#mobile_1").val());
        	
        	var name_2        =   $("#name_2").val();
        	var designation_2 =   $("#mobile_2").val();
        	var mobile_2      =   $("#mobile_2").val();
        	
        	var name_3        =   $("#name_3").val();
        	var designation_3 =   $("#mobile_3").val();
        	var mobile_3      =   $("#mobile_3").val();
        	
        	if(clarity_1 !="" && presentability_1 != "" && attitude_1 != "" && situation_1 != "" && name_1 !="" && designation_1 != "" && mobile_1 !=""  && 
        	  clarity_2 !="" && presentability_2 != "" && attitude_2 != "" && situation_2 != "" && name_2 !="" && designation_2 != "" && mobile_2 !="" )
        	 {
        		 $('#btn_submit').show(); 
				 $('#pass_fail_status').show();  
            	 $("#total-marks").show();
            	 $("#averageScore").show();
				  
        	 }else{
				 $('#btn_submit').hide(); 
				 $('#pass_fail_status').hide();  
            	 $("#total-marks").hide();
            	 $("#averageScore").hide(); 
			 }
        }
      
        function  checkBtn(){
        	var clarity_3 =   Number($("#clarity_3").val());
        	var presentability_3= Number($("#presentability_3").val());
        	var attitude_3= Number($("#attitude_3").val());
        	var situation_3 =  Number($("#situation_3").val());
        	var name_3        =   $("#name_3").val();
        	var designation_3 =   $("#mobile_3").val();
        	var mobile_3      =   $("#mobile_3").val();
        	
            if(clarity_3 == "" || presentability_3 == "" || attitude_3 == "" || situation_3 == "" || name_3 =="" || designation_3 == "" || mobile_3 ==""){
            	 $('#btn_submit').hide(); 
				 $('#pass_fail_status').hide(); 
            	 $("#total-marks").hide();
            	 $("#averageScore").hide();
				  
              }
            if(clarity_3 != "" && presentability_3 != "" && attitude_3 != "" && situation_3 != "" && name_3 !="" && designation_3 != "" && mobile_3 !=""){
            	 $('#btn_submit').show(); 
				 $('#pass_fail_status').show();  
            	 $("#total-marks").show();
            	 $("#averageScore").show();
				  
              }
                  	 
        }
        
        function save(status){
        	
        	var clarity_1 =   Number($("#clarity_1").val());
        	var presentability_1= Number($("#presentability_1").val());
        	var attitude_1= Number($("#attitude_1").val());
        	var situation_1 =  Number($("#situation_1").val());
        	
        	var clarity_2 =   Number($("#clarity_2").val());
        	var presentability_2= Number($("#presentability_2").val());
        	var attitude_2= Number($("#attitude_2").val());
        	var situation_2 =  Number($("#situation_2").val());
        	
        	var clarity_3 =   Number($("#clarity_3").val());
        	var presentability_3= Number($("#presentability_3").val());
        	var attitude_3= Number($("#attitude_3").val());
        	var situation_3 =  Number($("#situation_3").val());
        	
        	var name_1 =    $("#name_1").val();
        	var designation_1=  $("#designation_1").val();
        	var mobile_1=  $("#mobile_1").val();
			 
			
        	
        	var name_2        =   $("#name_2").val();
        	var designation_2 =   $("#designation_2").val();
        	var mobile_2      =   $("#mobile_2").val();
        	
        	var name_3        =   $("#name_3").val();
        	var designation_3 =   $("#designation_3").val();
        	var mobile_3      =   $("#mobile_3").val();
        	var accesskey     =   $("#accesskey").val();
			
			
			
			
			if(clarity_1>0){		 
			if(name_1.length<2 ){ 
				swal('Please enter Interviewer 01 name.');
				return;
			}
			
			if(designation_1.length<2 ){ 
				swal('Please enter Interviewer 01 designation.');
				return;
			}
			
			if(mobile_1.length<10){ 
				swal('Please enter Interviewer 01 valid mobile number.');
				return;
			}
			if(!validateValue(mobile_1)){
				swal('Please enter Interviewer 01 non repeated mobile number.');
				return;
				}
			if(mobile_1<5111111111){
				swal('Please enter Interviewer 01 correct mobile number.');
				return;
				}
			
			 
			if(presentability_1<1 || attitude_1<1 || situation_1<1){ 
				swal('Please provide your inputs');
				return;
			}
			
			
			
			 }
	if(clarity_2>0){
 

			if(name_2.length<2 ){ 
				swal('Please enter Interviewer 02 name.');
	return;
			}
			
			if(designation_2.length<2){ 
				swal('Please enter Interviewer 02 designation.');
	return;
			}
			
			if(mobile_2.length<10){ 
				swal('Please enter Interviewer 02 valid mobile number.');
	return;
			}
            if(!validateValue(mobile_2)){
				swal('Please enter Interviewer 02 non repeated mobile number.');
				return;
				}
			if(mobile_2<5111111111){
				swal('Please enter Interviewer 02 correct mobile number.');
				return;
				}
			if(presentability_2<1 || attitude_2<1 || situation_2<1){ 
				swal('Please provide your inputs');
				return;
			}
			  
}
			
	if(clarity_3>0){
 
			if(name_3.length<2 ){ 
				swal('Please enter Interviewer 03 name.');
	return;
			}
			
			if(designation_3.length<2){ 
				swal('Please enter Interviewer 03 designation.');
	return;
			}
			
			if(mobile_3.length<10){ 
				swal('Please enter Interviewer 03 valid mobile number.');
	return;
			}
        if(!validateValue(mobile_3)){
				swal('Please enter Interviewer 03 non repeated mobile number.');
				return;
				}
			if(mobile_3<5111111111){
				swal('Please enter Interviewer 03 correct mobile number.');
				return;
				}

			if(presentability_3<1 || attitude_3<1 || situation_3<1){ 
				swal('Please provide your inputs');
				return;
			}
			  
}
		
	if(clarity_1<1 && clarity_2<1 && clarity_3<1){
		 
		swal('The form is empty, Please provide your inputs');
		return;
	}	
			
	if(clarity_1<1 && clarity_2>0 ){
		 
		swal('Please provide 01 interviewer inputs');
		return;
	}
if(clarity_2<1 && clarity_3>0 ){
		 
		swal('Please provide 02 interviewer inputs');
		return;
	}	


	if(name_1.length<2 && (clarity_1<1 || presentability_1<1 || attitude_1<1 || situation_1<1)){ 
				swal('Please enter Interviewer 02 inputs.');
	return;
			}
			
			if(designation_1.length<2 && (clarity_1<1 || presentability_1<1 || attitude_1<1 || situation_1<1)){ 
				swal('Please enter Interviewer 02 inputs.');
	return;
			}
			
			if(mobile_1.length<10 && (clarity_1<1 || presentability_1<1 || attitude_1<1 || situation_1<1)){ 
				swal('Please enter Interviewer 02 inputs.');
	return;
			}
			
			

 
			if(name_2.length<2 && (clarity_2<1 || presentability_2<1 || attitude_2<1 || situation_2<1)){ 
				swal('Please enter Interviewer 02 inputs.');
	return;
			}
			
			if(designation_2.length<2 && (clarity_2<1 || presentability_2<1 || attitude_2<1 || situation_2<1)){ 
				swal('Please enter Interviewer 02 inputs.');
	return;
			}
			
			if(mobile_2.length<10 && (clarity_2<1 || presentability_2<1 || attitude_2<1 || situation_2<1)){ 
				swal('Please enter Interviewer 02 inputs.');
	return;
			}
			
			 if(mobile_1.length==10 && mobile_2.length==10){
			if(mobile_1==mobile_2){
				swal('Interviewer 01 and 02 Mobile numbers can not be same.');
	return;
			}
			 }
			  if(mobile_1.length==10 && mobile_3.length==10){
			if(mobile_1==mobile_3){
				swal('Interviewer 01 and 03 Mobile numbers can not be same.');
	return;
			}
			  }
			 if(mobile_2.length==10 && mobile_3.length==10){
			if(mobile_2==mobile_3){
				swal('Interviewer 01 and 03 Mobile numbers can not be same.');
	return;
			} 
			 }
			
			 
	
			
        	$("#save_status").val(status);
        $.ajax({
        	 type: 'POST',
             url: 'interview',
             data: $('.form').serialize() ,
            success: function (data) { 
            	  if(status == "final"){
            		  
            		  swal({   
    	 					title: data,     
    	 					showCancelButton: false,
    	 					confirmButtonColor: "#2d3393",   
    	 					confirmButtonText: "OK",   
    	 					closeOnConfirm: false },
    	 					function(isConfirm){
    	 						if(isConfirm){
    	 							 window.opener.location.reload();  
         		  					window.close(); 
    	 						}else{
    	 							return false;
    	 						}
    	 					});
            		 
            	  }
            	       if(status=='save' || status=='edit'){
            		   $('#msg').text('');
    	        		 $("#msg").append('Interview evaluation sheet saved');
            	  } 
            }
        });  
        }
        
        function showRating(){
        	var clarity_1 =   Number($("#clarity_1").val());
        	var presentability_1= Number($("#presentability_1").val());
        	var attitude_1= Number($("#attitude_1").val());
        	var situation_1 =  Number($("#situation_1").val());
        	
        	var clarity_2 =   Number($("#clarity_2").val());
        	var presentability_2= Number($("#presentability_2").val());
        	var attitude_2= Number($("#attitude_2").val());
        	var situation_2 =  Number($("#situation_2").val());
        	
        	var clarity_3 =   Number($("#clarity_3").val());
        	var presentability_3= Number($("#presentability_3").val());
        	var attitude_3= Number($("#attitude_3").val());
        	var situation_3 =  Number($("#situation_3").val());
        	
        	 for(var i = 1; i<= clarity_1; i++) {
                 $('#evaluator01 .points-block:nth-child(1) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             }       	 
        	 for(var i = 1; i<= presentability_1; i++) {
                 $('#evaluator01 .points-block:nth-child(2) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 for(var i = 1; i<= attitude_1; i++) {
                 $('#evaluator01 .points-block:nth-child(3) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 for(var i = 1; i<= situation_1; i++) {
                 $('#evaluator01 .points-block:nth-child(4) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 
        	 for(var i = 1; i<= clarity_2; i++) {
                 $('#evaluator02 .points-block:nth-child(1) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 for(var i = 1; i<= presentability_2; i++) {
                 $('#evaluator02 .points-block:nth-child(2) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 for(var i = 1; i<= attitude_2; i++) {
                 $('#evaluator02 .points-block:nth-child(3) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 for(var i = 1; i<= situation_2; i++) {
                 $('#evaluator02 .points-block:nth-child(4) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 
        	 for(var i = 1; i<= clarity_3; i++) {
                 $('#evaluator03 .points-block:nth-child(1) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 for(var i = 1; i<= presentability_3; i++) {
                 $('#evaluator03 .points-block:nth-child(2) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 for(var i = 1; i<= attitude_3; i++) {
                 $('#evaluator03 .points-block:nth-child(3) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        	 for(var i = 1; i<= situation_3; i++) {
                 $('#evaluator03 .points-block:nth-child(4) .point span').parent().find('span:nth-child('+i+')').addClass('active');
             } 
        }
        
        function final(){
        	
       	 $('.delete-popup, .blk-bg').show();
            
       }
       
       function closePop(event) {
		 
           $('.delete-popup, .blk-bg').hide();
       }
	   
	   function edit() {
             $('input').prop('disabled', false);
			 $('.evaluators').find('span').removeClass("hideclick");
			 $('#btn_submit').show(); 
			 $('#btn_save').show();
			 
       }
       
       function openReport(key,name){
		   var name1 =  name.split(" ").join("");
   	        mywindow=window.open("https://staging.irecruit.org.in/iRecruit/player/jspPdf.jsp?accesskey="+key+"&name="+name1,"resizable=1,scrollbars=1,width=1170,height=600");
   	       mywindow.moveTo(120,90);
       }
	   
	   function openReporPDFt(){
		  
   	        mywindow=window.open("https://staging.irecruit.org.in/iRecruit/player/samplePDF.jsp?name=sample","resizable=1,scrollbars=1,width=1170,height=600");
   	       mywindow.moveTo(120,90);
       }
	   
	    function CreatePDFfromHTML1() {
		   var a = $("#pdf").val();
            var HTML_Width = $("#content").width();
            var HTML_Height = $("#content").height();
            var top_left_margin = 15;
            var PDF_Width = HTML_Width + (top_left_margin * 2);
            var PDF_Height = (PDF_Width * 1.7) + (top_left_margin * 2);
            var canvas_image_width = HTML_Width;
            var canvas_image_height = HTML_Height;

            var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;

            html2canvas($("#content")[0]).then(function (canvas) {
                var imgData = canvas.toDataURL("image/jpeg", 1.0);
                var pdf = new jsPDF('p', 'pt', [PDF_Width, PDF_Height]);
                pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin, canvas_image_width, canvas_image_height);
                for (var i = 1; i <= totalPDFPages; i++) { 
                    pdf.addPage(PDF_Width, PDF_Height);
                    pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height*i)+(top_left_margin*4),canvas_image_width,canvas_image_height);
                }
                pdf.save(a);
                // $("#content").hide();
            });
        }
		
		  function funexport(fileName)
   	{
   			document.forms[0].action="./downloadInterviewForm?fileName="+fileName;
   			document.forms[0].method="post";
   			document.forms[0].submit();
   	}
	
	 function oenPopup(){
             $('.question-popup, .blk-bg').show();
             $('.popup-area').addClass('active');
         }
    </script>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>

