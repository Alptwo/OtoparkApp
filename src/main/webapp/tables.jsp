<%-- 
    Document   : tables.jsp
    Created on : 8 Kas 2022, 23:39:04
    Author     : kerim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DBOperations.CarTypes" %>
<%@page import="DBOperations.Entries" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBOperations.Users"%>
<%@page import="Objects.clsEntries"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays" %>

    <%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    if(session.getAttribute("username") == null || session.getAttribute("username") == "")
    {%>
        <jsp:forward page="login.jsp"/>
    <%}
    %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Tables</title>

    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <%if(session.getAttribute("userType") == "Admin")
            {
            %>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin-main.jsp">
            <%}
            else if(session.getAttribute("userType") == "User")
            {%>
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="user-main.jsp">
            <%}%>
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-car-side"></i>
                </div>
                <div class="sidebar-brand-text mx-3">Otopark<sup></sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
            <%if(session.getAttribute("userType") == "Admin")
            {   
            %>
            <a class="nav-link" href="admin-main.jsp">
            <%}
            else if(session.getAttribute("userType") == "User")
            {%>
            <a class="nav-link" href="user-main.jsp">
            <%}%>
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Panel & Araç Ekle</span></a>
            </li>
            <%if(session.getAttribute("userType") == "Admin")
            {
            %>
            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Admin Arayüz
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
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
            <%}%>
        

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
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

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

                    <!-- Page Heading -->
                    

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Otopark Verileri</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Araç Plaka Numarası</th>
                                            <th>Araç Tipi</th>
                                            <th>Giriş Zamanı</th>
                                            <th>Çıkış Zamanı</th>
                                            <th>Araç Durumu</th>
                                            <th>Ücret</th>
                                        </tr>
                                    </thead>
                                  
                                    <tbody>                                       
                                
                                            <%
                                                Entries entries = new Entries();
                                                ArrayList<clsEntries> entriesList = entries.getAllEntries();
                                                for(int i=0 ; i<entriesList.size();i++)
                                                {
                                                    %>
                                                    
                                                        <tr>
                                                            <th><%out.println(org.apache.commons.lang.StringEscapeUtils.unescapeHtml(entriesList.get(i).getPlateNumber()));%></th>
                                                            <th><%out.println(entriesList.get(i).getCarTypeName());%></th>
                                                            <th><%out.println(entriesList.get(i).getEntrytime());%></th>
                                                            <th><%out.println(entriesList.get(i).getExittime());%></th>
                                                            <th><%out.println(entriesList.get(i).getIsCarInorOut());%></th>
                                                            <th><%out.println(entriesList.get(i).getPrice());%></th>
                                                        </tr>
                                                    
                                                    <%
                                                }
                                            
                                            
                                            
                                            %>
                                   
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            
            <!-- End of Footer -->

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
                        <span aria-hidden="true">×</span>
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
    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/datatables-demo.js"></script>
<script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</body>

</html>
