
<%-- <% String mspin2="", user="", password=""; 
mspin2=session.getAttribute("mspin").toString().trim();
user=session.getAttribute("user").toString().trim();
password=session.getAttribute("password").toString().trim();
String msg="";
if(session.getAttribute("msgEmail") != null){
	msg = session.getAttribute("msgEmail").toString().trim();
}
%> --%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/login.css" />
    </head>
    <body>
   <h1>Analytics Page</h1>
   <h3>Overview</h3>
   Registered : ${overview.registered}<br>
   Assessments : ${overview.assessments}<br>
   Pass : ${overview.pass}<br>
   Offer : ${overview.offer}<br>
   Recruited : ${overview.recruited}<br><br>
   <h3>Recruitment Source</h3>
   Referrals : ${source.referrals}<br>
   Direct Walk In : ${source.directWalkIn}<br>
   Advertisement : ${source.advertisement}<br>
   Job Consultant : ${source.jobConsultant}<br>
   Social Media : ${source.socialMedia}<br>
   Others : ${source.others}<br>
   <h3>Candidate Experience</h3>
   Less Than 3 Months : ${experience.lessThan3Months}<br>
    3 Month to 6 Months : ${experience.months3To6}<br>
    6 Months to 1 Year : ${experience.months6To1Year}<br>
    1-2 Years : ${experience.year1To2Year}<br>
    2-5 years : ${experience.year2To5Year}<br>
    5-10 Years : ${experience.year5To10Year}<br>
    More Than 10 years : ${experience.moreThan10Year}<br>
    <h3>Assessment Report</h3>
    Less Than 40% : ${assessment.lessThan40}<br>
    40% to 60% : ${assessment.between40To60}<br>
    60% to 80% : ${assessment.between60To80}<br>
    More Than 80% : ${assessment.moreThan80}<br>
    <h3>Sales/Non Sales</h3>
    Sales : ${designation.sales}<br>
    Non Sales : ${designation.nonSales}<br>
  </body>
</html>
