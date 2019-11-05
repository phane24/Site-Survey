<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">

<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

<title>Site Survey</title>

	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	
</head>
<script src="<c:url value='resources/js/jquery.min.js' />"></script>
 <script src="<c:url value='resources/js/base64js.min.js' />"></script>	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">	
	
<script type="text/javascript">	   

	   if(sessionStorage.getItem("username")==null)
   	{
		//window.location.href = "/sitesurvey/";
		//alert(sessionStorage.getItem("username"));
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
   	}
	   else
	   {
	   role=sessionStorage.getItem("role");
	   siteId=sessionStorage.getItem("siteId");
	
	   }
	   
	   
	   
	   
</script>


		

     


<script type="text/javascript">

WebFont.load({
	google: {"families":["Open+Sans:300,400,600,700"]},
	custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
	active: function() {
		sessionStorage.fonts = true;
	}
});


$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	  $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 

	//  getRegions();
		//getSiteId();
		//$("#type,#username,#emailId,#pwd,#cpwd,#mobileNum,#region").attr('required', '');  
		 $(".isa_success").fadeOut(10000);
		 $("input").attr("required", "true");
		 $("#siteArea :input").attr("required",'');
		 getSiteAreaDetails(siteId);
		 $("select").attr("required","true");
		 $("select option:contains('Select')").attr("disabled","disabled");
		 document.getElementById("image1spanMSG").style.display = "none";
		 document.getElementById("image1span").style.display = "none";
		 document.getElementById('siteid').value=siteId;
	     $('#siteid').prop('readonly', true);
	     $("#photo1up").attr("disabled", "disabled");
		
});

$(function () {
    $("#chkImg").click(function () {
        if ($(this).is(":checked")) {
            $("#photo1up").removeAttr("disabled");
            $("#photo1up").focus();
        } else {
            $("#photo1up").attr("disabled", "disabled");
        }
    });
});


function redirectToOther()
{
	window.location.href = "/sitesurvey/siteWiring";
} 

function ValidateFileUpload(id) {
    var fuData = document.getElementById(id);
    var FileUploadPath = fuData.value;

//To check if user upload any file
    if (FileUploadPath == '') {
    	 document.getElementById("image1spanMSG").style.display ="block";

    } else {
        var Extension = FileUploadPath.substring(
                FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

//The file uploaded is an image

if (Extension == "gif" || Extension == "png" || Extension == "bmp"
                || Extension == "jpeg" || Extension == "jpg") {

//To Display
            if (fuData.files && fuData.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('#blah').attr('src', e.target.result);
                }

                reader.readAsDataURL(fuData.files[0]);
            }

        } 

//The file upload is NOT an image
else {
	        document.getElementById("image1span").style.display ="block";
            document.getElementById(id).value="";
        }
    }
}

var base64_1;
var jsonData1;
function getSiteAreaDetails(siteId)
{

	 $.ajax({
         type: "get",
         url: "getSiteAreaDetails",
         contentType: 'application/json',
         data:{"siteId":siteId},
         datatype: "json",
         success: function(result) {
            jsonData = JSON.parse(result);
            console.log("fasf"+JSON.stringify(jsonData));
            if(jsonData.length==0)
            {
            	$("#imagediv1").hide();
            	
            	$("#fileupload1").show();
            	 
            	$("#cnfrmr1").hide();
            }
            else
            {
            	$("#imagediv1").show();
                
               
                $("#fileupload1").hide();
               
            	$("#id").val(jsonData[0].id);
            	$("#siteCondition").val(jsonData[0].siteCondition);
            	$("#imaget1").val(jsonData[0].photo_inproper_name);
            	$("#obsrvcommnts").val(jsonData[0].comments);
            	$("#siteArea :input").removeAttr('required');
         }
         }					
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
	

	var pid=id;
	var imageData= base64js.fromByteArray(jsonData[0][pid])
	

	var imageNum="Photo"+i;
	  var htmlstring = "<img id='ItemPreview' 'src=data:image/jpeg;base64,"+imageData+"' width='104' height='142'>";
    //$("#ItemPreview").attr('src', 'data:image/jpeg;base64,' + base64);
       Swal.fire({
                title: "<i>"+imageNum+"</i>",
                html: "<center><table border='0'><tr><td><img id='ItemPreview' src='data:image/jpeg;base64,"+imageData+"' width='300' height='300'></td></tr></table><center>", 
                timer: 1000,
              });  
	
}

</script>
<style>
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}
label {
    color: #495057!important;
    font-size: 13px!important;
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
</style>
<%--   <body  class="login">

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
<div id="superAdminSidebar">
</div>
		<!-- End Sidebar -->
		
<div class="wrapper wrapper-login">
  <div class="container container-login animated fadeIn">
    <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br>
    
			<h3 class="text-center">ACCESS</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
			<form action="saveAccess" method="post" modelAttribute="Site_Access" >
			<div class="login-form">
			
				
				 <br>
				<label for="AccessType" class="placeholder">Access Type</label>
				<input id="accesstype" path="accessType" class="form-control input-full filled" />
				<br>
				<label for="Condition" class="placeholder">Condition</label>
				<input id="condition" path="roadCondition" class="form-control input-full filled"     />
				<br>
				
				<label for="ObservationComments" class="placeholder">Observation/Comments</label> 
				<input id="obsvcommnts" path="comments"  name="obsvcommnts"  class="form-control input-full filled"  />
				<br>
               
				
               <!-- href="home" -->
				<div class="form-action">
					
<!-- 					<input type="submit" id="submit" value="Save" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;"> -->
					<input type="submit" id="submit" value="Save and Continue" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
				</div>
			</div>
			</form>
		
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



<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>



</body>  --%>
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
<%--             <span class="isa_success" style="color:green;font-size:14px;">${status}</span> --%>
			<h3 class="text-center">Site Area</h3>
			<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
			<span id="image1span" style="color:red">*Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. *</span>
			<span id="image1spanMSG" style="color:red">*Please Upload an Image*</span>
			<form:form method="post" action="saveArea" modelAttribute="Site_Area" id="siteArea"  enctype="multipart/form-data">
			<div class="login-form">	
			<form:hidden path="id"/>
				
					<label for="siteid" class="placeholder"><b>Site ID</b></label>
	                <form:input id="siteid" path="siteid.siteid" name="siteid" class="form-control input-border" />	                
	            	
 
            	<br>
					
					<label for="siteCondition"><b>Condition Of The Site</b></label>
	                <form:select id="siteCondition" path="siteCondition" name="siteCondition" class="form-control">
	                <form:option value="">Select</form:option>
	                <form:option value="Not assessed">Not assessed (Note why not assessed in observation)</form:option>
	                <form:option value="Very Poor">Very Poor (Can't walk around inside the site - waterlogged etc.)</form:option>
	                <form:option value="Poor">Poor (Can walk around with difficulty - weeds overgrowing etc.)</form:option>
	                <form:option value="Fair"> Fair (No issues inside and surrounding site)</form:option>
	                <form:option value="Good">Good (Well kept)</form:option>
	                <form:option value="Very Good">Very good (Well kept with no issues at all)</form:option>
	                <form:option value="Not applicable">Not applicable</form:option>
	                </form:select>	                
	            	
				<br>
			
					
					<label for="obsrvcommnts" class="placeholder"><b>Observations/Comments</b></label>
	                <form:input id="obsrvcommnts" path="comments" name="obsrvcommnts" class="form-control input-border"/>	                
	            	
	            	
	            	<br>
                
					<!-- <div class="form-group">

					<label for="photo1up" class="placeholder"><b>Photo 1</b></label>
	                <input type="file" id="photo1up" name="file" accept="image/*"  onchange="return ValidateFileUpload(this.id)"  class="form-control input-border"/>	                
	            
	            
            	</div> -->
            	<div id="fileupload1">
				<label for="Upload Image" class="placeholder" ><b>Photo 1 </b></label>
				<input type="file"   class="form-control input-border-bottom"  id="img1" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image0">${errMsg}</span>
  				</div>
  				<div id="imagediv1">
 					
  						<label for="Site photo1" class="placeholder" ><b>Photo 1</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget1" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="photo_inproper" path="" value="View Image" onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
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
                 
				<div class="form-action" id="typeDiv">	
					<a href="siteAccess" class="btn btn-rounded btn-login btn-warning">Previous</a>
				    <input type="submit" id="submit" name="clickBtn" value="Save for Later"  class="btn btn-rounded btn-login btn-danger" style="background-color: #E4002B;color: white;">
					<input  type="submit" id="submit1" name="clickBtn" value="Next"class="btn btn-rounded btn-login btn-primary" style="background-color: #012169;color: white;">
					
				</div>
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



<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>


<!-- Sweet Alert -->

<!-- Sweet Alert -->

<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>
<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>



</body>

</html>