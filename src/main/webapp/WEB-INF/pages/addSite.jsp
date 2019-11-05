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
	<script type="text/javascript">
	role=sessionStorage.getItem("role");
	   if(sessionStorage.getItem("username")==null)
   	{
		//window.location.href = "/sitesurvey/";
		//alert(sessionStorage.getItem("username"));
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
   	}
	   else if(role=="Admin" | role=="Manager")
		   {
		   
		   }
	   else
		   {
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
		   }

		   
</script>

<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">	
		

     
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


$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 

	  $("#superAdminSidebar").load('<c:url value="/resources/common/managerSidebar.jsp" />'); 

	//  getRegions();
		getSiteId();
		//$("#type,#username,#emailId,#pwd,#cpwd,#mobileNum,#region").attr('required', '');  
		 $(".isa_success").fadeOut(10000);
		 $("#siteform").show();
			$("#uploadsheetdiv").hide();
});

function populateDropdown(data,id)
{
	var	catOptions="<option value=''>Select</option>";
 	for (i in data) {
 		
   	 	 catOptions += "<option>" + data[i] + "</option>";
 		}
 		document.getElementById(id).innerHTML = catOptions;
 		 $("select option[value='']").attr('disabled','disabled');
}



function getState(region)
{
	//alert(region)
	 $.ajax({
		 	type:"get",
		 	url:"getStates",
		 	contentType:'application/json',
		 	datatype:"json",
		 	data:{"selectedRegion":region},
		 	success:function(res){
		 		//alert(JSON.parse(res))
		 		console.log(res);
		 		jsonData=JSON.parse(res);
		 		populateDropdown(jsonData,"state");
		 	},
		 	error:function()
		 	{
		 		console.log("Error");	
		 	}
	 });
}
	
function getDistrict(state)
{ 
	var selectedRegion=$("#regions").val();
	 $.ajax({
	         type:"get",
	         url:"getDistricts",
	         contentType: 'application/json',
	         datatype : "json",
	         data:{"selectedRegion":selectedRegion,"selectedState":state},
	         success:function(data1) {
	         	jsonData = JSON.parse(data1);
	         	populateDropdown(jsonData,"districts");
	         },
	         error:function()
	         {
	         	console.log("Error");
	         }
	 	});
}
function getCity(district)
{ 
	
	var selectedRegion=$("#regions").val();
	var selectedState=$("#state").val();
	
	
	 $.ajax({
	         type:"get",
	         url:"getCities",
	         contentType: 'application/json',
	         datatype : "json",
	         data:{"selectedRegion":selectedRegion,"selectedState":selectedState,"selectedDistrict":district},
	         success:function(data1) {
	         	jsonData = JSON.parse(data1);
	         	populateDropdown(jsonData,"city");
	         },
	         error:function()
	         {
	         	console.log("Error");
	         }
	 	});
}

function ValidateLatLong()
{ 	
	var latitude=$("#Latitude").val();
	var longitude=$("#Longitude").val();

	 $.ajax({
         type:"get",
         url:"ValidateLatLong",
         contentType: 'application/json',
         datatype : "json",
         data:{"latitude":latitude,"longitude":longitude},
         success:function(data1) {
        	 console.log(data1);
         	if(data1=="Existing")
         		{
         		$("#latitude").val(" ");
            	$("#longitude").val(" ");
         		swal("Sorry!", "Entered Latitude and Longitude assigned to another Site", {
					icon : "error",
					buttons: {        			
						confirm: {
							className : 'btn btn-danger'
						}
					},
				});
         		}
         	
         	
         }
         
 	});
	 
}


	function getSiteId()
	{
		var jsonArr1;
			$.ajax({
		        type:"get",
		        url:"getLastSiteId",
		        contentType: 'application/json',
		        datatype : "json",
		        success:function(data) {
		        	var jsonArr=JSON.parse(data);	
//		        	alert(jsonArr)
		        	 if(jsonArr.length==0){
			        		jsonArr1="IND001";
			        	}  	
		        	 else{
			        	var dataSplit=jsonArr[0].split("D");
			        	console.log(dataSplit[0]);
			        	var dataSplitInt=parseInt(dataSplit[1]);
			        	console.log(dataSplitInt+1);
			        	dataSplitInt=dataSplitInt+1;
			        	
			        	if(dataSplitInt>0&&dataSplitInt<=9)
			        		jsonArr1="IND00"+dataSplitInt;
			        	else if(dataSplitInt>9&&dataSplitInt<99)
			        		jsonArr1="IND0"+dataSplitInt;
			        	else if(dataSplitInt>99)
			        		jsonArr1="IND"+dataSplitInt;        	
	        		}	        	
		        	$('#siteid').val(jsonArr1);	 
		        	$('#siteid').attr('readonly', true);
		        },
		        error:function()
		        {
		        	console.log("Error");
		        }
			});
	}

	function Validate_latlong(text_box)
	{
	var text_value = document.getElementById(text_box.id).value;

	var reg = new RegExp("^-?([1-8]?[1-9]|[1-9]0)\.{1}\d{1,6}");

	if( reg.exec(text_value) ) {
	 //do nothing
	} else {
		$("#"+text_box.id).val(" ");
		swal("Invalid "+text_box.id+" Format", {
			icon : "error",
			buttons: {        			
				confirm: {
					className : 'btn btn-danger'
				}
			},
		});
	}


	}
	
	
	
	
	
	function upload_files(id){
		
		
		var rdBtnid=id.id
		//alert(rdBtnid);
		//var Value = $("input[name='"+id.name+"']:checked").val();
	    //var name = $("input[name='"+id.name+"']:checked").val();
		//var i=rdBtnid[rdBtnid.length-1];
		
		if(id.value=="Yes"){
			$("#siteform").hide();
			$("#uploadsheetdiv").show();
			//$("#site_photo1").attr('disabled',false);
	    	//$("#site_photo2").attr('disabled',false);
		}else if(id.value=="No"){
			$("#siteform").show();
			$("#uploadsheetdiv").hide();
			//$("#site_photo1").attr('disabled',true);
	    	//$("#site_photo2").attr('disabled',true);
		}
		
		
		
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
    padding: 74px 40px;
    border-radius: 5px;
    -webkit-box-shadow: 0 0.75rem 1.5rem rgba(18,38,63,.03);
    -moz-box-shadow: 0 .75rem 1.5rem rgba(18,38,63,.03);
    box-shadow: 0 0.75rem 1.5rem rgba(18,38,63,.03);
    border: 1px solid #ebecec;
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
<div id="superAdminSidebar">
</div>
		<!-- End Sidebar -->
		
		
		
<div class="wrapper wrapper-login">
  <div class="container container-login animated fadeIn">
  
    <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br>
    
			<h3 class="text-center">Add Site</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
				
				
				<div class="row mt-1">   
  				 <div class="col-md-7">
                  <label for="Radio_1" class="placeholder" ><b>Multiple Sites</b></label><br>
                  </div>
                  <div class="col-md-3">Yes&nbsp;<input type="radio"  value="Yes" id="rdyes1" name="rdbtn1" onclick="upload_files(this)" />
                  </div>
                  <div class="col-md-2">No&nbsp;<input type="radio" onclick="upload_files(this)" id="rdno1"  value="No"  name="rdbtn1" checked/>
                 </div>
                  </div>
				<div id="uploadsheetdiv" >
				<form method="post" enctype="multipart/form-data"  action="saveMultipleSite">
				<div>
				<label for="site_photo1" class="placeholder" >Upload</label>
				<input type="file" class="form-control input-border-bottom"  id="site_photo1"  name="file" accept=".xls,.xlsx" /> 
				
					<span class="isa_failure" id="image1">${errMsg}</span>
						
  				</div>
  				
  				<div class="form-action">
					<a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
					<input type="submit" id="submit" value="Add" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
				</div>
				</form>
				</div>
				
			<form:form action="saveSite" method="post" modelAttribute="Site" id="siteform" >
			
			<div class="login-form">
			
				<form:hidden id="surveyStatus" path="surveyStatus" value="New"/>
				 <br>
				<label for="Site ID" class="placeholder">Site ID</label>
				<form:input id="siteid" path="siteid" class="form-control input-full filled" />
				<br>
				<label for="latitude" class="placeholder">Latitude</label>
				<form:input id="Latitude" path="latitude" class="form-control input-full filled"     />
				<br>
				
				<label for="longitude" class="placeholder">Longitude</label> 
				<form:input id="Longitude" path="longitude" autocomplete="new-password" name="longitude"  class="form-control input-full filled" onchange="ValidateLatLong();" />
				<br>
               
				<label for="Region" class="region">Region</label>
                <form:select id="regions" path="region" name="regions" class="form-control input-full filled" onchange="getState(this.value);" >
                <form:option value="Select">Select</form:option>
            	<form:options items="${regionsList}"></form:options>
            	</form:select>
                <br>
                
                <label for="State" class="state">State</label>
                <form:select id="state" path="state" name="state" class="form-control input-full filled" onblur="getDistrict(this.value)">
                </form:select>
              <br>
              <label for="District" class="district">District</label>
                 <form:select id="districts" path="district" name="districts" class="form-control input-full filled" onblur="getCity(this.value)">
                </form:select>
                <br>
                <label for="city" class="city">City</label>
                <form:select id="city" path="city" name="city" class="form-control input-full filled" >

                </form:select>
                
                <br>
                <label for="longitude" class="placeholder">Pin Code</label> 
				<form:input id="pincode" path="pincode"  name="pincode" pattern="[0-9]{6}" maxlength="6" class="form-control input-full filled"  />
               
				<div class="form-action">
					<a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
					<input type="submit" id="submit" value="Add" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
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

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>

</body>

</html>