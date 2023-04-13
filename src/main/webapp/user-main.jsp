<%-- 
    Document   : admin-main
    Created on : 28 Eki 2022, 20:17:18
    Author     : alptugaltin
--%><%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DBOperations.Entries"%>
<!DOCTYPE html>
<html lang="tr">

    <head>
        
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

    <title>Otopark Dashboard</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        
        System.out.println("AS");
        if (session.getAttribute("userType") == "Admin") {%>
    <jsp:forward page="admin-main.jsp"/>
    <%} else if (session.getAttribute("userType") == null) {%>
    <jsp:forward page="login.jsp"/>
    <%}
    %>
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

            <!-- Custom styles for this template-->
            <link href="css/sb-admin-2.min.css" rel="stylesheet">

                </head>

                <body id="page-top">

                    <!-- Page Wrapper -->
                <div id="wrapper">

                    <!-- Sidebar -->
                    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                        <!-- Sidebar - Brand -->
                        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="user-main.jsp">
                            <div class="sidebar-brand-icon rotate-n-15">
                                <i class="fas fa-car-side"></i>
                            </div>
                            <div class="sidebar-brand-text mx-3">Otopark<sup></sup></div>
                        </a>

                        <!-- Divider -->
                        <hr class="sidebar-divider my-0">

                        <!-- Nav Item - Dashboard -->
                        <li class="nav-item active">
                            <a class="nav-link" href="user-main.jsp">
                                <i class="fas fa-fw fa-tachometer-alt"></i>
                                <span>Panel & Araç Ekle</span></a>
                        </li>

                        <!-- Divider 
                        <hr class="sidebar-divider">
                        -->
                        <!-- Heading 
                        <div class="sidebar-heading">
                            Kullanıcı Arayüzü
                        </div>
                        -->
                        <!-- Nav Item - Pages Collapse Menu 
                        <li class="nav-item">
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                                aria-expanded="true" aria-controls="collapseTwo">
                                <i class="fas fa-fw fa-cog"></i>
                                <span>Kullanıcı İşlemleri</span>
                            </a>
                            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                                <div class="bg-white py-2 collapse-inner rounded">
                                    <h6 class="collapse-header">Kullanıcı İşlemleri</h6>
                                    <a class="collapse-item" href="AddUser.jsp">Kullanıcı Ekle</a>
                                    <a class="collapse-item" href="UpdateUser.jsp">Kullanıcı Güncelle</a>
                                    
                                </div>
                            </div>
                        </li>
                        -->


                        <!-- Divider -->
                        <hr class="sidebar-divider">

                        <!-- Heading -->
                        <div class="sidebar-heading">
                            Otopark
                        </div>





                        <!-- Nav Item - Tables -->
                        <li class="nav-item">
                            <a class="nav-link" href="tables.jsp">
                                <i class="fas fa-fw fa-table"></i>
                                <span>Otopark Verileri</span></a>
                            <a class="nav-link" href="ActiveEntries.jsp">
                                <i class="fas fa-fw fa-table"></i>
                                <span>Aktif Bulunanların Verileri</span></a>
                        </li>

                        <!-- Divider -->
                        <hr class="sidebar-divider d-none d-md-block">

                        <!-- Sidebar Toggler (Sidebar) -->
                        <div class="text-center d-none d-md-inline">
                            <button class="rounded-circle border-0" id="sidebarToggle"></button>
                        </div>

                    </ul>
                    <!-- End of Sidebar -->

                    <!-- Content Wrapper -->
                    <div id="content-wrapper" class="d-flex flex-column">

                        <!-- Main Content -->
                        <div id="content">

                            <!-- Topbar -->
                            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                                <!-- Sidebar Toggle (Topbar) -->
                                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                                    <i class="fa fa-bars"></i>
                                </button>

                                <!-- Topbar Navbar -->
                                <ul class="navbar-nav ml-auto">

                                    <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                                    <li class="nav-item dropdown no-arrow d-sm-none">
                                        <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-search fa-fw"></i>
                                        </a>
                                        <!-- Dropdown - Messages -->
                                        <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                             aria-labelledby="searchDropdown">
                                            <form class="form-inline mr-auto w-100 navbar-search">
                                                <div class="input-group">
                                                    <input type="text" class="form-control bg-light border-0 small"
                                                           placeholder="Search for..." aria-label="Search"
                                                           aria-describedby="basic-addon2">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-primary" type="button">
                                                                <i class="fas fa-search fa-sm"></i>
                                                            </button>
                                                        </div>
                                                </div>
                                            </form>
                                        </div>
                                    </li>

                                    <div class="topbar-divider d-none d-sm-block"></div>

                                    <!-- Nav Item - User Information -->
                                    <li class="nav-item dropdown no-arrow">
                                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%out.println(session.getAttribute("username"));%></span>
                                            <img class="img-profile rounded-circle"
                                                 src="img/undraw_profile.svg">
                                        </a>
                                        <!-- Dropdown - User Information -->
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                             aria-labelledby="userDropdown">
                                            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                                <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                                Çıkış
                                            </a>
                                        </div>
                                    </li>

                                </ul>

                            </nav>
                            <!-- End of Topbar -->
                            <!-- Begin Page Content -->
                            <div class="container-fluid">

                                <!-- Content Row -->
                                <div class="row">





                                    <!-- Earnings (Monthly) Card Example -->
                                    <!-- <div class="col-xl-3 col-md-6 mb-4">
                                         <div class="card border-left-info shadow h-100 py-2">
                                             <div class="card-body">
                                                 <div class="row no-gutters align-items-center">
                                                     <div class="col mr-2">
                                                         <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Tasks
                                                         </div>
                                                         <div class="row no-gutters align-items-center">
                                                             <div class="col-auto">
                                                                 <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
                                                             </div>
                                                             <div class="col">
                                                                 <div class="progress progress-sm mr-2">
                                                                     <div class="progress-bar bg-info" role="progressbar"
                                                                         style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                                                                         aria-valuemax="100"></div>
                                                                 </div>
                                                             </div>
                                                         </div>
                                                     </div>
                                                     <div class="col-auto">
                                                         <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>-->



                                    <!-- Content Row -->
                                    <div class="container-fluid">
                                        <div class="row">
                                            <!-- ARAYÜZ BURAYA EKLENİCEK -->
                                            <div class="container-fluid" >

                                                <!-- Outer Row -->

                                                <div class="row">

                                                    <div class="col-sm-6">

                                                        <div class="card o-hidden border shadow-lg my-auto">
                                                            <div class="card-body p-lg-5"  >
                                                                <!-- Nested Row within Card Body -->
                                                                <div class="row">

                                                                    <div class="col-lg-10" >
                                                                        <div class="p-2">
                                                                            <div class="text-center">
                                                                                <h1 class="h4 text-gray-900 mb-4">Araç Kayıdı Ekle</h1>
                                                                            </div>
                                                                            <form class="user" action="admin-main.jsp" method="POST">
                                                                                <div class="form-group">
                                                                                    <input type="text" class="form-control form-control-user"
                                                                                           name="InputPlateNumber" aria-describedby="usernameHelp"
                                                                                           placeholder="Plaka" value="" style='text-transform:uppercase'>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <select class="btn btn-primary dropdown-toggle-split" name="InputCarType" > 
                                                                                        <option value="" disabled selected>Araç Tipi:</option>
                                                                                        <option value="Otomobil">Otomobil</option> 
                                                                                        <option value="Agir Vasita">Ağır Vasıta</option>
                                                                                        <option value="Motosiklet">Motosiklet</option> 
                                                                                    </select>
                                                                                </div>  
                                                                                <div class="form-group">
                                                                                    <button type="submit" class="btn btn-primary btn-user btn-block" value="Kaydet">Kaydet</button>
                                                                                </div>                                                                            
                                                                            </form>
                                                                            
                                                                        </div>

                                                                        <%
                                                                            Entries entries = new Entries();
                                                                            String infomessage;
                                                                            if (request.getParameter("InputPlateNumber") != null || request.getParameter("InputCarType") != null) { 
                                                                                infomessage = entries.addEntry(request.getParameter("InputPlateNumber"), request.getParameter("InputCarType"));
                                                                                if(infomessage.equals("Kayıt başarıyla eklendi."))
                                                                                {
                                                                                    %>
                                                                                    <div class="form-group">
                                                                                    <div class="alert alert-success">
                                                                                        <strong><%out.println(infomessage);%></strong>
                                                                                        </div> 
                                                                                    </div>
                                                                                    <%
                                                                                }
                                                                                else if(infomessage.equals("Bu araç zaten içerde!") || infomessage.equals("Otoparkta yer yok!")){
                                                                                    %>                                                                                
                                                                                    <div class="form-group">
                                                                                        <div class="alert alert-danger">
                                                                                            <strong><%out.println(infomessage);%></strong>
                                                                                        </div> 
                                                                                    </div>
                                                                                    <%   
                                                                                }
                                                                                else{
                                                                                    %>                                                                                
                                                                                    <div class="form-group">
                                                                                        <div class="alert alert-warning">
                                                                                            <strong><%out.println(infomessage);%></strong>
                                                                                        </div> 
                                                                                    </div>
                                                                                    <%   
                                                                                } 
                                                                            }
                                                                        %> 
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- DASHBOARD GÜNLÜK KAZANÇLAR -->
                                                    <div class="col">
                                                        <div class="card border-left-primary shadow h-auto py-2">
                                                            <div class="card-body">
                                                                <div class="row no-gutters align-items-center">
                                                                    <div class="col mr-2">
                                                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                                            Kazançlar (Günlük)</div>
                                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                                            <%
                                                                                out.println(entries.calculateDailyEarnings() + " TL");
                                                                            %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- DASHBOARD BOŞ YER MİKTARI -->
                                                    <div class="col" >
                                                        <div class="card border-left-warning shadow h-auto py-2">
                                                            <div class="card-body " >
                                                                <div class="row no-gutters align-items-center">
                                                                    <div class="col mr-2">
                                                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                                            Boş Yer Miktarı</div>
                                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                                            <%
                                                                                out.println(entries.calculateEmptySpace());
                                                                            %>                                                            
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                
                                             </div>

                                            </div>

                                        </div>  


                                    </div>
                                </div>
                                <!-- /.container-fluid -->


                            </div>
                            <!-- End of Main Content -->



                        </div>
                        <!-- End of Content Wrapper -->

                    </div>
                    <!-- End of Page Wrapper -->

                    <!-- Scroll to Top Button-->
                    <a class="scroll-to-top rounded" href="#page-top">
                        <i class="fas fa-angle-up"></i>
                    </a>

                    <!-- Logout Modal-->
                    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Çıkmak İstediğine Emin Misin?</h5>
                                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">x</span>
                                    </button>
                                </div>
                                <div class="modal-body">Şuanki oturumu kapatmak için Çıkış butonuna basınız.</div>
                                <div class="modal-footer">
                                    <button class="btn btn-secondary" type="button" data-dismiss="modal">İptal</button>
                                    <a class="btn btn-primary" href="login.jsp">Çıkış</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bootstrap core JavaScript-->
                    <script src="vendor/jquery/jquery.min.js"></script>
                    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

                    <!-- Core plugin JavaScript-->
                    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

                    <!-- Custom scripts for all pages-->
                    <script src="js/sb-admin-2.min.js"></script>

                    <!-- Page level plugins -->
                    <script src="vendor/chart.js/Chart.min.js"></script>

                    <!-- Page level custom scripts -->
                    <script src="js/demo/chart-area-demo.js"></script>
                    <script src="js/demo/chart-pie-demo.js"></script>
                    <script>
                                                                                if (window.history.replaceState) {
                                                                                    window.history.replaceState(null, null, window.location.href);
                                                                                }
                                                                            </script>
                    </body>

                    </html>