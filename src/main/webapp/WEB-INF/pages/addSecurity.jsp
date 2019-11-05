<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String jsondetails=(String)request.getParameter("ticketDetails"); 
   System.out.println("json>>>>>>>"+jsondetails);%>
<%-- <% String status=(String)request.getAttribute("status"); %> --%>

<%-- <% String btnClick=(String)request.getAttribute("btnClick");  --%>
<%--   System.out.println("btnclck>>>>>>>"+btnClick);%> --%>
<!DOCTYPE html >
<html lang="en">

<head>

<spring:url value="resources/css/styling.css" var="mainCss" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />

	<link href="${mainCss}" rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<spring:url value="resources/css/jquery-ui.css" var="jqueryCss" />
<spring:url value="/resources/js/jquery.min.js" var="jqueryJs" />
	<spring:url value="/resources/js/jquery-ui.min.js" var="jqueryuiJs" />
		<spring:url value="/resources/js/validations.js" var="validationsJs" />
		
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />

	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
    <script src="${validationsJs}"></script>
       	 <script type="text/javascript">
	
   if(sessionStorage.getItem("username")==null) 
   	{ 
		   url = "/sitesurvey/"; 
		      $( location ).attr("href", url);
  	}
  
 	   else 
 		   { 
 		  role=sessionStorage.getItem("role"); 
 			siteId=sessionStorage.getItem("siteId");
 			ticketId=sessionStorage.getItem("ticketId");
		   } 

 </script> 
 <script src="<c:url value='resources/js/base64js.min.js' />"></script>
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
	

<script type="text/javascript">


WebFont.load({
	google: {"families":["Open+Sans:300,400,600,700"]},
	custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
	active: function() {
		sessionStorage.fonts = true;
	}
});

var inventoryData;
var ticketId,ticketType;
var ticketStatus;



var jsonDetails;
$(document).ready(function(){	
	
<%-- 	var status='<%=status%>'; --%>

<%-- 	var btnClick='<%=btnClick%>'; --%>
// 	//alert(status);
// 	 if(status=='Saved')

//      {
//                   var nextUrl;
//               if(btnClick=="Save"){
//                     nextUrl="/sitesurvey/home";
//               }
//               else if(btnClick=="Save & Continue"){
//                     nextUrl="/sitesurvey/gotosafety";
//               }
//               swal({
//                          //title: 'Are you sure?',
//                          text: "Details Saved Successfully",
//                          type: 'info',
//                          buttons:{
//                                 confirm: {
//                                        text : 'Ok',
//                                        className : 'btn btn-success'
//                                 }
//                          }
//                   }).then((Delete) => {
//                          if (Delete) {
//                                 window.location.href = nextUrl;
//                          }
//                   });
//             }
	
	
	
	$("select option[value='Select']").attr('disabled','disabled');
	 $("#securityform :input").attr("required", '');
	$("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	$("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 
	 jsonDetails='<%=jsondetails%>';
	
	var ticketDetails=JSON.parse(jsonDetails);
	//alert(ticketDetails);
	
	$("#siteid")[0].value=siteId;
	  $("#json")[0].value=ticketDetails;
	//  alert(siteId);
	  
	  getSiteSecurityDetails(siteId);
	  
	
});
var base64_1;
var jsonData1;

function getSiteSecurityDetails(siteId){
	
	 $.ajax({
         type: "get",
         url: "getSecurityDetails",
         contentType: 'application/json',
         data:{"siteId":siteId},
         datatype: "json",
         success: function(result) {
        	 jsonData1=JSON.parse(result);
        	 securityjsonData = JSON.parse(result);
         //	alert("file"+result)
            console.log("json"+securityjsonData);
            
            if(securityjsonData.length==0){
            $("#imagediv1").hide();
            $("#imagediv2").hide();
           
            $("#fileupload1").show();
            $("#fileupload2").show();
           
            $("#cnfrmr1").hide();
            $("#cnfrmr2").hide();
           
            }else
            {
            	 $("#imagediv1").show();
                 $("#imagediv2").show();
                
                 $("#fileupload1").hide();
                 $("#fileupload2").hide();
                
                 $("#securityid").val(securityjsonData[0].id);
             	$("#obnotes").val(securityjsonData[0].observations);
             	$("#securitycondition").val(securityjsonData[0].securityCondition);
           // alert(securityjsonData[0].security_photo1_name)
            	$("#imaget1").val(securityjsonData[0].security_photo1_name);
            	$("#imaget2").val(securityjsonData[0].security_photo2_name);
            	
            	$("#securityform :input").removeAttr('required');
            	
            }
         }					
		 }); 
}

function upload_files(id){
	
	var rdBtnid=id.id
	//var Value = $("input[name='"+id.name+"']:checked").val();
    //var name = $("input[name='"+id.name+"']:checked").val();
	var i=rdBtnid[rdBtnid.length-1];
	
	if(id.value=="Yes"){
		$("#imagediv"+i).hide();
		$("#fileupload"+i).show();
		//$("#site_photo1").attr('disabled',false);
    	//$("#site_photo2").attr('disabled',false);
	}else if(id.value=="No"){
		$("#imagediv"+i).show();
		$("#fileupload"+i).hide();
		//$("#site_photo1").attr('disabled',true);
    	//$("#site_photo2").attr('disabled',true);
	}
	
	
	
}
 
function ViewImage(id){
	
	//alert(jsonData1)
	var i=id[id.length-1];
	//var i=2
	var pid="security_photo"+i
	console.log(jsonData1[0].pid);
	
	var imageData= base64js.fromByteArray(jsonData1[0][pid])
	
	
	//alert(imageData);
	var imageNum="Photo"+i;
	  var htmlstring = "<img id='ItemPreview' 'src=data:image/jpeg;base64,"+imageData+"' width='104' height='142'>";
    //$("#ItemPreview").attr('src', 'data:image/jpeg;base64,' + base64);
       Swal.fire({
                tiimaget1tle: "<i>"+imageNum+"</i>",
                html: "<center><table border='0'><tr><td><img id='ItemPreview' src='data:image/jpeg;base64,"+imageData+"' width='300' height='300'></td></tr></table><center>", 
                timer: 1000,
              });  
	
}


function ValidateImage(id){
		var i=id[id.length-1];
		  var fuData = document.getElementById(id);
      var FileUploadPath = fuData.value;
//To check if user upload any file
      if (FileUploadPath == '') {
          alert("Please upload an image");
     } else {
          var Extension = FileUploadPath.substring(
                  FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
//The file uploaded is an image
if (Extension == "gif" || Extension == "png" || Extension == "bmp"|| Extension == "jpeg" || Extension == "jpg") {
//To Display
			  $("#image"+i)[0].innerHTML="";
              if (fuData.files && fuData.files[0]) {
                 var reader = new FileReader();
                 reader.onload = function(e) {
                     // $('#blah').attr('src', e.target.result);
                  }
                 reader.readAsDataURL(fuData.files[0]);
              }
         }
//The file upload is NOT an image
else {
           //  alert("Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
             $("#image"+i)[0].innerHTML="Uploaded file must be Image Format";  
           document.getElementById(id).value="";
          }
      }
  }

</script>
<style>
.isa_failure{
    color:red;
}
.error {
 color: #ff0000;
 font-style: italic;
 font-weight: bold;
}
.login .wrapper.wrapper-login .container-login, .login .wrapper.wrapper-login .container-signup {
    width: 700px;
    background: #fff;
    padding: 74px 40px ;
   
    border-radius: 5px;
    -webkit-box-shadow: 0 0.75rem 1.5rem rgba(18,38,63,.03);
    -moz-box-shadow: 0 .75rem 1.5rem rgba(18,38,63,.03);
    box-shadow: 0 0.75rem 1.5rem rgba(18,38,63,.03);
    border: 1px solid #ebecec;
}

.fa-bars,		
.fa-ellipsis-v		
{		
color: #fff!important;		
}		

label {
    color: #495057!important;
    font-size: 13px!important;
}

</style>

<body  class="login">

    <div class="main-header" style="background-color: #00B1BF;">
			<!-- Logo Header -->
			<div class="logo-header">
				
				<a href="home" class="logo">
				
					<img src="<c:url value='resources/assets/img/logo.png' />" alt="navbar brand" class="navbar-brand">
				</a>
				<button class="navbar-toggler sidenav-toggler ml-auto" type="button" data-toggle="collapse" data-target="collapse" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon">
						<i class="fa fa-bars"></i>
					</span>
				</button>
				<button class="topbar-toggler more"><i class="fa fa-ellipsis-v"></i></button>
				<div class="navbar-minimize">
					<button class="btn btn-minimize btn-rounded">
						<i class="fa fa-bars"></i>
					</button>
				</div>
			</div>
			<!-- End Logo Header -->

			<!-- Navbar Header -->
			<div  id="navbar">	
			</div>
			<!-- End Navbar -->
		</div>

		<!-- Sidebar -->
<div id="technicianSidebar">
</div>
		<!-- End Sidebar -->
		
	<div class="wrapper wrapper-login">
	  <div class="container container-login animated fadeIn">
<%-- 	   <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${succMsg}</span></div>	<br><br> --%>
				<h3 class="text-center">Security</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
				<form:form method="post" id="securityform" modelAttribute="Site_Security" action="sitesecurity" enctype="multipart/form-data"   >
				<form:input type="hidden" path="id" id="securityid" />
				<form:input type="hidden"  path="" id="json" name="json" />
			
						<label for="siteid" class="placeholder"><b>Site Id</b>
						</label>
						<form:input id="siteid" path="siteid.siteid" class="form-control input-full" readonly="true" />
				
				<br>
						<label for="obnotes" class="placeholder"><b>Observation / Comment - Presence of fence,locks,alarm system, other security</b>
				
						</label>
						
						<form:input id="obnotes" path="observations" class="form-control input-full"  />				
						<form:errors path="observations" cssClass="error" />	
					
				<br>
						<label for="securitycondition" class="placeholder"><b>What is the overall security Condition?</b> </label>
						<form:select id="securitycondition" path="securityCondition"  name="overallconditon"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Not assessed">Not assessed (Note why not assessed in observation)</form:option>
		                <form:option value="Very Poor">very poor- Fencing,locks,alarm system are non existent/broken</form:option>
		                <form:option value="Poor">Poor - Fencing,locks,alarm system are in place, need significant work</form:option>
		                <form:option value="Fair"> Fair - Fencing,locks,alarm systems, need light maintenance</form:option>
		                <form:option value="Good">Good - Fencing, locks, alarm systems good condition</form:option>
		                <form:option value="Very Good">Very good - Fencing locks, alarm systems good new condition</form:option>
		                <form:option value="Not Applicable">Not Applicable</form:option>
		                </form:select>
								<form:errors path="securityCondition" cssClass="error" />
										
					
				<br>		
				<div id="fileupload1">
				<label for="Upload Image" class="placeholder" ><b>Photo 1 </b></label>
				<input type="file"  class="form-control input-border-bottom"  id="img1" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image0">${errMsg}</span>
  				</div>
  					<div id="imagediv1">
 					
  						<label for="Security photo1" class="placeholder" ><b>Photo 1</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget1" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="imageb1" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  				
  				</div>
  				<div id="cnfrmr1">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes&nbsp;<input type="radio"  value="Yes" id="rdyes1" name="rdbtn1" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No&nbsp;<input type="radio" onclick="upload_files(this)" id="rdno1"  value="No"  name="rdbtn1" checked/>
                 	</div>
                  </div>
 	
 				</div>
 				<br>
 				<div  id="fileupload2">
				<label for="Upload Image" class="placeholder" ><b>Photo 2</b></label>
				<input type="file" class="form-control input-border-bottom"  id="img2"  name="file"  onchange="ValidateImage(this.id);"/> 
					<span class="isa_failure" id="image1">${errMsg}</span>
  				</div>
  				<div id="imagediv2">
 					
  						<label for="photo2" class="placeholder" ><b>Photo 2</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget2" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="imageb2" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					
  					</div>
  				<div id="cnfrmr2">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_2" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes&nbsp;<input type="radio"  value="Yes" id="rdyes2" name="rdbtn2" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No&nbsp;<input type="radio" onclick="upload_files(this)" id="rdno2"  value="No"  name="rdbtn2" checked/>
                 	</div>
                  </div>
 	
 				</div>
 						<div class="form-action" id="new_submit" >
 						<a href="fetchtowerinstallation" class="btn btn-rounded btn-login btn-warning">Previous</a>
				 		<input type="submit"  class="btn btn-rounded btn-login btn-danger" value="Save for Later" name="btn" style="background-color: #E4002B;color: white;">  
					
 						<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
 				
 				
				 		<input type="submit" class="btn btn-rounded btn-login btn-primary" value="Next" name="btn" style="background-color: #012169;color: white;">  
					
 							<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
 							</div>
 				</form:form>	
				</div>
							
			</div>
	
   <script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>
	
	<!--   Core JS Files   -->



<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
<script src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>

<!-- jQuery UI -->


<script src="<c:url value='resources/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
<script src="<c:url value='resources/assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js' />"></script>



<!-- jQuery Scrollbar -->
<script src="<c:url value='resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js' />"></script>

<!-- Sweet Alert -->

<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>
<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>


</body>

</html>