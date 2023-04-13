<%-- 
    Document   : UpdateUser
    Created on : 9 Kas 2022, 01:25:37
    Author     : kerim
--%>


<%@page import="java.awt.event.ActionEvent"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBOperations.Users"%>
<%@page import="Objects.clsUser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays" %>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="${contextPath}/resource/bootstrap.min.css" rel="stylesheet">
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
            
            
            if (session.getAttribute("userType") == "User") {%>
        <jsp:forward page="user-main.jsp"/>
        <%} else if (session.getAttribute("userType") == null) {%>
        <jsp:forward page="login.jsp"/>
        <%}
        %>
        <!-- Custom fonts for this template-->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
            <link
                href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
                rel="stylesheet">

                <!-- Custom styles for this template -->
                <link href="css/sb-admin-2.min.css" rel="stylesheet">

                    <!-- Custom styles for this template-->
                    <link href="css/sb-admin-2.min.css" rel="stylesheet">

                        </head>

                        <body id="page-top">

                            <!-- Page Wrapper -->
                        <div id="wrapper">

                            <!-- Sidebar -->
                            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                                <!-- Sidebar - Brand -->
                                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin-main.jsp">
                                    <div class="sidebar-brand-icon rotate-n-15">
                                        <i class="fas fa-car-side"></i>
                                    </div>
                                    <div class="sidebar-brand-text mx-3">Otopark<sup></sup></div>
                                </a>

                                <!-- Divider -->
                                <hr class="sidebar-divider my-0">

                                <!-- Nav Item - Dashboard -->
                                <li class="nav-item active">
                                    <a class="nav-link" href="admin-main.jsp">
                                        <i class="fas fa-fw fa-tachometer-alt"></i>
                                        <span>Panel & Araç Ekle</span></a>
                                </li>

                                <!-- Divider -->
                                <hr class="sidebar-divider">

                                <!-- Heading -->
                                <div class="sidebar-heading">
                                    Admin Arayüzü
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

                                        <!-- Begin Page Content -->


                                        <!-- Page Heading -->

                                        <%
                                            Users user = new Users();
                                            if (request.getParameter("InputUserName") != null && request.getParameter("InputPassword") != null || request.getParameter("InputUserType") != null) {
                                                user.updateUser(request.getParameter("InputUserName"), request.getParameter("InputPassword"), request.getParameter("InputUserType"), session.getAttribute("username").toString());
                                            }
                                            if (request.getParameter("InputUserID") != null) {
                                                user.deleteUser(Integer.parseInt(request.getParameter("InputUserID")), session.getAttribute("username").toString());
                                            }
                                        %>
                                        <!-- DataTales Example -->
                                        <div class="card shadow mb-4">
                                            <div class="card-header py-3">
                                                <h6 class="m-0 font-weight-bold text-primary">Kullanıcı Verileri</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                                        <thead>
                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Kullanıcı Adı</th>
                                                                <th>Kullanıcı Tipi</th>
                                                                <th>Güncelle</th>    
                                                                <th>Sil</th>  
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                ArrayList<clsUser> users = user.getAllUsers();
                                                                clsUser cuser = new clsUser();
                                                                for (int i = 0; i < users.size(); i++) {
                                                            %>
                                                            <tr onclick="getIndex(this)">
                                                                <td>    
                                                                    <%out.println(users.get(i).getID());%>
                                                                </td>

                                                                <td>
                                                                    <% out.println(users.get(i).getUsername()); %>
                                                                </td>
                                                                <td>
                                                                    <% out.println(users.get(i).getUsertype());%>
                                                                </td>
                                                                <td>
                                                        <input type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#largeShoes"  value="Güncelle" />
                                                        </td>
                                                        <td>
                                                        <input type="button" class="btn btn-primary btn-lgdelete" data-toggle="modal" data-target="#deleteModal"  value="Sil" />
                                                        </td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                        </tbody>
                                                        <script>
                                                            function getIndex(x) {
                                                                console.log(x.rowIndex);
                                                                let DbUserName = document.getElementById("dataTable").querySelectorAll("td:nth-child(2)")[x.rowIndex - 1].innerText.toString();
                                                                document.getElementById("InputUserName").value = DbUserName;
                                                                document.getElementById("deleteusertext").innerText = DbUserName + " adlı kullanıcıyı silmek istediğinize emin misiniz?";
                                                                let DbID = document.getElementById("dataTable").querySelectorAll("td:nth-child(1)")[x.rowIndex - 1].innerText;
                                                                document.getElementById("InputUserID").value = DbID;
                                                                //alert("DB ID is: "+DbID); 
                                                            }
                                                        </script>
                                                        


                                                        <!-- comment -->
                                                        <!-- <tfoot>
                                                        <tr>
                                                            <th>Name</th>
                                                            <th>Position</th>
                                                            <th>Office</th>
                                                            <th>Age</th>
                                                            <th>Start date</th>
                                                            <th>Salary</th>
                                                        </tr>
                                                    </tfoot> -->

                                                    </table>




                                                    <!-- The modal -->
                                                    <div class="modal fade" id="largeShoes" tabindex="-1" role="dialog" aria-labelledby="modalLabelLarge" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">

                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                    <h4 class="modal-title" id="modalLabelLarge"></h4>
                                                                </div>

                                                                <div class="modal-body">
                                                                    <!-- Begin Page Content -->
                                                                    <div class="container-fluid">



                                                                        <!-- Content Row -->
                                                                        <div class="row">


                                                                            <div class="container-fluid">

                                                                                <!-- Outer Row -->

                                                                                <div class="row justify-content-center"  >

                                                                                    <div class="col-xl-auto col-lg-4 col-md-5">

                                                                                        <div class="card o-hidden border shadow-lg my-auto">
                                                                                            <div class="card-body p-lg-5">
                                                                                                <!-- Nested Row within Card Body -->
                                                                                                <div class="row">

                                                                                                    <div class="col-lg-10" >
                                                                                                        <div class="p-2">
                                                                                                            <div class="text-center">
                                                                                                                <h1 class="h4 text-gray-900 mb-4">Kullanıcı Güncelle</h1>
                                                                                                            </div>
                                                                                                            <form class="user" action="UpdateUser.jsp" method="POST">
                                                                                                                <div class="form-group">
                                                                                                                    <input type="text" class="form-control form-control-user"id="InputUserName"name="InputUserName" aria-describedby="usernameHelp" value="" placeholder="Kullanıcı Adı" readonly/>
                                                                                                                </div>
                                                                                                                <div class="form-group" >
                                                                                                                    <input type="password" class="form-control form-control-user"
                                                                                                                           id="InputPassword" name="InputPassword" placeholder="Şifreyi değiştirmek için yazınız">
                                                                                                                </div>
                                                                                                                <div class="form-select" style="width:350px; border-radius: 50px; height: 45px"  >
                                                                                                                    <select name="InputUserType" style="border:none; margin-top: 5px" >
                                                                                                                        <option value="">Kullanıcı Tipi</option>
                                                                                                                        <option value="User">User</option>
                                                                                                                        <option value="Admin">Admin</option>                                                                                                                                                                              
                                                                                                                    </select>
                                                                                                                </div>
                                                                                                                <div class="form-group">

                                                                                                                </div>
                                                                                                                <input type="submit" class="btn btn-primary btn-user btn-block" value="Kaydet" />

                                                                                                            </form>

                                                                                                            <hr>
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
                                                                </div>
                                                            </div>



                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                            <!-- The Delete modal -->
                                            <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                                                 aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Kullanıcı Silmek İstediğinizden Emin Misiniz?</h5>
                                                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">x</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body" id="deleteusertext">Kullanıcıyı silmek için SİL butonuna basınız.</div>
                                                        <div class="modal-footer">
                                                            <form action="UpdateUser.jsp" method="POST">                                                                    
                                                                <input type="hidden" class="form-control form-control-user" id="InputUserID" name="InputUserID" aria-describedby="usernameHelp" readonly/>                                                                    
                                                                <input class="btn btn-secondary" type="button" data-dismiss="modal" value="Hayır"></input>
                                                                <input class="btn btn-secondary" name="btnDelete" type="submit" value="Evet"></input>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>                                                                  


                                            <!-- Content Row -->
                                            <div class="row">
                                                <!-- Content Row -->
                                                <div class="row">
                                                    <!-- Content Column -->
                                                    <div class="col-lg-6 mb-4">
                                                    </div>
                                                    <div class="col-lg-6 mb-4">
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.container-fluid -->
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


                                    <!-- Page level plugins -->

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

