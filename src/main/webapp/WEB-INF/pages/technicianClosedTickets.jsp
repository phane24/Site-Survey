<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	
	<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

	<!-- Fonts and icons -->
	<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>	
	<script src="<c:url value='resources/js/jquery.min.js' />"></script>	
		<script src="<c:url value='resources/js/jquery.min.js' />"></script>
			<script type="text/javascript">
	   if(sessionStorage.getItem("username")==null)
   	{
		   url = "/sitesurvey/";
		  $( location ).attr("href", url);
   	}	
	</script>	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
	
	
	
		
	<script>
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
		 var s=sessionStorage.getItem("username");
		$(document).ready(function() {
	

			  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
			  $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 
			  getCount();
			 tableData();
		});
		
		var dataSet=[];
		 var ticketId;
		 
		 function getCount(){
			 var s=sessionStorage.getItem("username");
				$.ajax({
	                type:"get",
	                url:"getTechTicketsCount",
	                contentType: 'application/json',
	                datatype : "json",
	                data:{"username":s},
	                success:function(result) {
	                	var jsonArr = $.parseJSON(result);
	                	 $('#assignedTechTickets')[0].innerHTML=jsonArr.AssignedTickets;
		                  $('#acceptedTechTickets')[0].innerHTML=jsonArr.AcceptedTickets;
		                  $('#closedTechTickets')[0].innerHTML=jsonArr.ClosedTickets;            
		                  $('#technicianNotAcceptedTickets')[0].innerHTML=jsonArr.NotAcceptedTickets;
	                }
				});
			}
		
		
		function tableData()
		{			
			$.ajax({
                type:"get",
                url:"getTechncianClosedTickets",
                contentType: 'application/json',
                datatype : "json",
                data:{"username":s},
                success:function(data) {
                    closedTicketsList = JSON.parse(data);
					
                    for(var i=0;i<closedTicketsList.length;i++)
         		   {
                    	dataSet.push([closedTicketsList[i].ticketNum,closedTicketsList[i].siteids,closedTicketsList[i].ticketDescription]);
         			   
         		   }
                   
                    
			 var table1=$('#techClosedTickets').DataTable({
					destroy:true,
					language: {
					  emptyTable: "No Data Available"
					},	
					//columnDefs: [{ "targets": -1, "data": null, "defaultContent": "<button style=' background-color: #4CAF50;border: none;  color: white;  padding: 5px 25px;  text-align: center;  text-decoration: none;  display: inline-block;  font-size: 16px;  margin: 4px 2px;  cursor: pointer;' id='viewBtn'>View</button>"}],					
			        data: dataSet,
			        columns: [
			        	{title: "Ticket Id" },
						{title: "Site Id" },
						{title: "Ticket Description" },	
// 						{title: "Action" },						
			        ]
			    } );
			 
			 }
			});
		}
		

	</script>
		
	<!-- CSS Files -->

	
	<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">

	<!-- CSS Just for demo purpose, don't include it in your project -->
	<link rel="stylesheet" href="<c:url value='resources/assets/css/demo.css' />">
	

	<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<style>
.fa-bars,
.fa-ellipsis-v
{
	color: #fff !important;
}
</style>
</head>
<body>
	<div class="wrapper">
		<!--
			Tip 1: You can change the background color of the main header using: data-background-color="blue | purple | light-blue | green | orange | red"
		-->
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
			<div id="navbar">	
			</div>
			<!-- End Navbar -->
		</div>

		<!-- Sidebar -->
	<div id="technicianSidebar">
	</div>
		<!-- End Sidebar -->

		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Dashboard</h4>						
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round" >
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/technicianAssignedTickets'" style="cursor:pointer;">
									<div class="row align-items-center" >
										<div class="col-icon" >
											<div class="icon-big text-center bubble-shadow-small" style="background:#F98B88;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category">Assigned</p>
												<h4 class="card-title" id="assignedTechTickets"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body " onclick="location.href='${pageContext.request.contextPath}/technicianAcceptedTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small"  style="background:#af91e1;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category">Accepted</p>
												<h4 class="card-title" id="acceptedTechTickets"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						
												<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/technicianNotAcceptedTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#FCD12A;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >Not Accepted</p>
												<h4 class="card-title" id="technicianNotAcceptedTickets"  ></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/technicianClosedTickets'" style="background-color:#00B1BF;border-radius: 10px;cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" style="color:#ffffff;">Closed</p>
												<h4 class="card-title" id="closedTechTickets" style="color:#ffffff;"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>

					<div class="row">
							<div class="col-md-12">
							<div class="card">
								<div class="card-header">
									<h4 class="card-title">Tickets</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table id="techClosedTickets" style="width:100%" class="display table table-striped table-hover" >

										</table>
									</div>
								</div>
							</div>
						</div>
				</div>
		</div>
	</div>
	</div>
</div>

<!--   Core JS Files   -->
<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
<script src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>

<!-- jQuery UI -->
<script src="<c:url value='resources/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
<script src="<c:url value='resources/assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js' />"></script>

<!-- jQuery Scrollbar -->
<script src="<c:url value='resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js' />"></script>

<!-- Moment JS -->
<script src="<c:url value='resources/assets/js/plugin/moment/moment.min.js' />"></script>

<!-- Chart JS -->
<script src="<c:url value='resources/assets/js/plugin/chart.js/chart.min.js' />"></script>

<!-- jQuery Sparkline -->
<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<!-- Chart Circle -->
<script src="<c:url value='resources/assets/js/plugin/chart-circle/circles.min.js' />"></script>

<!-- Datatables -->
<script src="<c:url value='resources/assets/js/plugin/datatables/datatables.min.js' />"></script>

<!-- Bootstrap Notify -->
<script src="<c:url value='resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js' />"></script>

<!-- Bootstrap Toggle -->
<script src="<c:url value='resources/assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js' />"></script>

<!-- jQuery Vector Maps -->
<script src="<c:url value='resources/assets/js/plugin/jqvmap/jquery.vmap.min.js' />"></script>
<script src="<c:url value='resources/assets/js/plugin/jqvmap/maps/jquery.vmap.world.js' />"></script>

<!-- Google Maps Plugin -->
<script src="<c:url value='resources/assets/js/plugin/gmaps/gmaps.js' />"></script>

<!-- Sweet Alert -->
<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>

<!-- Azzara JS -->
<script src="<c:url value='resources/assets/js/ready.min.js' />"></script>



</body>
</html>