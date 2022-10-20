<?php
require '/var/www/vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable('/var/www/');
$dotenv->load();
?>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
    <title>AWS – joviber t</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        var count = 0;
        var control = 1;        
        var nrows = 10;
	var f_path = "<?php echo $_ENV['F_PATH']; ?>";
  	var asg = "<?php echo $_ENV['ASG']; ?>"; 
	var dbcluster = "<?php echo $_ENV['DBCLUSTER']; ?>";
        var dbreader = "<?php echo $_ENV['DBREADER']; ?>";
	var instanceip = "<?php echo $_SERVER['SERVER_ADDR']; ?>";
	var clientip = "<?php echo $_SERVER['HTTP_X_FORWARDED_FOR']; ?>";
	function f_instanceip (){
           $("#js_result_ips").text(instanceip);
        }; 
        function f_clientip (){
           $("#js_result_ipc").text(clientip);
        };   
	function get_numberofinstances (){
           url = f_path + "/get_numberofinstances.php";   
           data = { asgroup : asg }; 
           $.post( url, data, function(data) {
                      $("#js_result_asg").text(data);
           });
        };
	function get_hostbyname (){
           url = f_path + "/get_hostbyname.php";
           data = { hostname : dbreader };
           $.post( url, data, function(data) {
                      $("#js_result_r").text(data);
           });
           data = { hostname : dbcluster };
           $.post( url, data, function(data) {
                      $("#js_result_w").text(data);
           });
        };
	function post_insertrow (){
	   url = f_path + "/post_insertrow.php";	
	   data = { name : "", lastname : "" }
	   $.post( url, data, function(data) {
                      $("#js_result_row").text(data);
           });
        };
	function updatelist(){
                if (count >= nrows) {
                $("#rows").empty();
                count = 0;
                };
                if (control == 0){
                        url = f_path + "/post_insertrow.php";
                        $.get( url, function(data, status){
                            $("#rows").append("<li>" + data + "</li>");
                        });
                        count++;
                };
        };
	function stopload (){
                control = 1;
        };
        function startload (){
                control = 0;
                updatelist();        
        };
	$(document).ready(function() {
	   setInterval(updatelist, 5000); 
           get_numberofinstances();
           get_hostbyname();
	   f_clientip();
	   f_instanceip();
	   get_hostbyname();
	   $("#js_result_dbr").text(dbreader);
	   $("#js_result_dbw").text(dbcluster);
	});	
  </script> 
  </head>
  <body>
    <h1><span style="color:Orange">AWS</span> – AB3 AnyCompany</h1>
    <h2>Connected to server: <span id="js_result_ips"></h3>
    <h4>IP client: <span id="js_result_ipc"></span></h4>
    <hr/> 
    <h2>Total instances in group: <span id="js_result_asg"></span></h3>
    <button id="btn4" type="button" onclick="get_numberofinstances()">Update</button>
    <hr/>
    <h4>DB access Aurora:</h4>
    <p>ReaderEndPoint: <span id="js_result_dbr"></span> [<span id="js_result_r"></span>]</p>
    <p>WriterEndPoint: <span id="js_result_dbw"></span> [<span id="js_result_w"></span>]</p>
    <button id="btn3" type="button" onclick="get_hostbyname()">Update</button>
    <hr/>
    <h4>Insert table test:</h4>
    <button id="btn5" type="button" onclick="post_insertrow()">Insert ramdom</button> Result: <span id="js_result_row"></span>
    <hr/>
    <h4>Databse test</h4>
        <div id="div1">
            <button id="btn1" type="button" onclick="startload()">Start DB load</button>
            <button id="btn2" type="button" onclick="stopload()">Stop DB load</button>
        </div>
        <div id="div2">
            <ol id="rows"></ol>
        </div>
  </body>
</html>

