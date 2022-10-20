<?php
    if(!empty($_POST['hostname'])){
       echo gethostbyname($_POST['hostname']); 
    }
    else {
       echo "NA"; 
    }
?>
