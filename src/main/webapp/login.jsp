<%-- 
    Document   : login
    Created on : 24 Eki 2022, 13:35:18
    Author     : alptugaltin
--%>
<%@page import="Cryptography.Crypting"%>
<%@page import="DBOperations.Login" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    if(session.getAttribute("username")!=null || session.getAttribute("username")!="")
    {
        session.setAttribute("username", null);
        session.setAttribute("userType", null); 
    }     
%>
<!DOCTYPE html>
<html lang="tr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

    <title>SB Admin 2 - Login</title>
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

            <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />

            <!-- Custom styles for this template-->
            <link href="css/sb-admin-2.min.css" rel="stylesheet">
                </head>

                <body class="bg-gradient-primary">

                <div class="container">

                    <!-- Outer Row -->
                    <div class="row justify-content-center">

                        <div class="col-xl-10 col-lg-12 col-md-9">

                            <div class="card o-hidden border-0 shadow-lg my-5">
                                <div class="card-body p-0">
                                    <!-- Nested Row within Card Body -->
                                    <div class="row">
                                        <div class="col-lg-6 d-none d-lg-block "><img src="img/loginimage_2.jpg"></div>
                                        <div class="col-lg-6">
                                            <div class="p-5 px-5">
                                                <div class="form-group">
                                                    <div class="text-center">
                                                        <h1 class="h4 text-gray-900 mb-4">Hoşgeldin</h1>
                                                    </div>
                                                </div>
                                                <form id="frmLogin" class="user" action="login.jsp" method="POST">
                                                    <div class="form-group">
                                                        <input type="text" class="form-control form-control-user"
                                                               id="InputUserName"name="InputUserName" aria-describedby="usernameHelp"
                                                               placeholder="Kullanıcı Adı">
                                                            
                                                    </div>
                                                    <div class="form-group" >
                                                        <input type="password" class="form-control form-control-user"
                                                               id="InputPassword" name="InputPassword" placeholder="Şifre">
                                                            
                                                    </div>
                                                    <!-- 
                                                    <div class="form-group">
                                                        <div class="custom-control custom-checkbox small">
                                                            <input type="checkbox" name="rememberMeButton" class="custom-control-input" id="customCheck" value="rememberMe">
                                                                <label class="custom-control-label" for="customCheck">Beni Hatırla</label>
                                                        </div>
                                                    </div>
                                                    -->
                                                    <div class="form-group">
                                                        <button id="btnLogin" type="submit" class="btn btn-primary btn-user btn-block">Giriş Yap</button>
                                                    </div>
                                                </form>
                                                
                                                

                                                <%
                                                    Crypting crypting = new Crypting();

                                                    //String rememberMe[] = request.getParameterValues("rememberMeButton");

                                                    if (request.getParameter("InputUserName") != null && request.getParameter("InputPassword") != null) {
                                                        Login login = new Login();
                                                        int canLogin = login.Login(request.getParameter("InputUserName"), request.getParameter("InputPassword"));
                                                        boolean isAdmin = login.isAdmin(request.getParameter("InputUserName"), request.getParameter("InputPassword"));
                                                        if (canLogin==1 && isAdmin) {                                                           
                                                            session.setAttribute("username", request.getParameter("InputUserName"));
                                                            session.setAttribute("userType", "Admin");
                                                            Cookie username = new Cookie("username", crypting.Encrypt(request.getParameter("InputUserName")).toString());
                                                            username.setMaxAge(60 * 60 * 24 * 30);
                                                            response.addCookie(username);
                                                            //try {
                                                                //if (rememberMe[0] == "rememberMe") {
                                                                    //Cookie username = new Cookie("username", crypting.Encrypt(request.getParameter("InputUserName")).toString());
                                                                    //Cookie userType = new Cookie("userType", crypting.Encrypt("Admin").toString());

                                                                    //username.setMaxAge(60 * 60 * 24 * 30);
                                                                    //userType.setMaxAge(60 * 60 * 24 * 30);

                                                                    //response.addCookie(username);
                                                                    //response.addCookie(userType);
                                                                //}
                                                            //} catch (Exception e) {
                                                            //}

                                                            %>  <jsp:forward page="admin-main.jsp"/>  <%                                                            } 
                                                                else if (canLogin==1 && !isAdmin) {
                                                                session.setAttribute("username", request.getParameter("InputUserName"));
                                                                session.setAttribute("userType", "User");
                                                                Cookie username = new Cookie("username", crypting.Encrypt(request.getParameter("InputUserName")).toString());
                                                                username.setMaxAge(60 * 60 * 24 * 30);
                                                                response.addCookie(username);
                                                                //try {
                                                                    //if (rememberMe[0] == "rememberMe") {
                                                                        //Cookie username = new Cookie("username", crypting.Encrypt(request.getParameter("InputUserName")).toString());
                                                                        //Cookie userType = new Cookie("userType", crypting.Encrypt("User").toString());

                                                                        //username.setMaxAge(60 * 60 * 24 * 30);
                                                                        //userType.setMaxAge(60 * 60 * 24 * 30);

                                                                        //response.addCookie(username);
                                                                        //response.addCookie(userType);
                                                                    //}
                                                                //} catch (Exception e) {
                                                                //}

                                                                %> <jsp:forward page="user-main.jsp"/> <%
                                                        }
                                                        else if (canLogin==0) {
                                                            if(request.getParameter("InputUserName")!="" && request.getParameter("InputPassword")!="")
                                                            {
                                                                %> 
                                                                
                                                                <div class="alert alert-danger">
                                                                    <strong>HATA!</strong> Yanlış kullanıcı adı veya şifre
                                                                </div> 
                                                                <%
                                                            }  
                                                            else if(request.getParameter("InputUserName") == "" && request.getParameter("InputPassword")!="") 
                                                            {
                                                                  %> 
                                                                
                                                                <div class="alert alert-warning">
                                                                     Kullanıcı Adı Boş Bırakılamaz.
                                                                </div> 
                                                                <%
                                                            }
                                                            else if(request.getParameter("InputUserName") != "" && request.getParameter("InputPassword") =="") 
                                                            {
                                                                  %> 
                                                                
                                                                <div class="alert alert-warning">
                                                                     Şifre Boş Bırakılamaz.
                                                                </div> 
                                                                <%
                                                            }
                                                             else if(request.getParameter("InputUserName") == "" && request.getParameter("InputPassword") =="") 
                                                            {
                                                                  %> 
                                                                  <div class="form-group">
                                                                    <div class="alert alert-warning">
                                                                         Kullanıcı Adı ve Şifre Boş Bırakılamaz.
                                                                    </div> 
                                                                </div>
                                                                <%
                                                            }
                                                            
                                                        }
                                                    }
                                                %>
                                               
                                            </div>
                                        </div>
                                    </div>
                                </div>
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

                <script>
                    if (window.history.replaceState) {
                        window.history.replaceState(null, null, window.location.href);
                    }
                </script>
                
                </body>

                </html>
