<?php
    require '../vendor/autoload.php';
    // Including Mail Configuration
    include("../mail-config.php");

    session_start();

    if(isset($_SESSION["user"])){
        if(($_SESSION["user"])=="" or $_SESSION['usertype']!='a'){
            header("location: ../login.php");
        }

    }else{
        header("location: ../login.php");
    }
    
    
    if($_GET){
        //import database
        include("../connection.php");
        $id=$_GET["id"];

        $sqlmain = "select * from appointment where appoid=?";
        $stmt = $database->prepare($sqlmain);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $userrow = $stmt->get_result();
        $appoFetch = $userrow->fetch_assoc();
        $apponum = $appoFetch["apponum"];
        $date = $appoFetch["appodate"];

        $sqlPatient = "select * from patient where pid=?";
        $stmt = $database->prepare($sqlPatient);
        $stmt->bind_param("i", $appoFetch["pid"]);
        $stmt->execute();
        $patientDetails = $stmt->get_result();
        $patientFetch = $patientDetails->fetch_assoc();
        $patientEmail = $patientFetch["pemail"];
        $patientName = $patientFetch["pname"];

        $docDetails = getDoctorDetails($database, $appoFetch["scheduleid"]);
        $docname = $docDetails["docname"];
        $docEmail = $docDetails["docemail"];

        // notify for appointment cancellation for patient
        notifyCancellation($patientEmail, $patientName, $apponum, $date, $docname);

        // notify for appointment cancellation for doctor
        notifyCancellationDoctor($docEmail, $apponum, $date, $patientName);

        // notify for appointment cancellation for admin
        $sql = "select * from admin";
        $result = $database->query($sql);
        while ($adminrow = $result->fetch_assoc()) {
            notifyCancellationAdmin($adminrow["aemail"], $apponum, $date, $patientName, $docname);
        }


        //$result001= $database->query("select * from schedule where scheduleid=$id;");
        //$email=($result001->fetch_assoc())["docemail"];
        $database->query("delete from appointment where appoid='$id';");
        //$sql= $database->query("delete from doctor where docemail='$email';");
        //print_r($email);
        header("location: appointment.php");
        exit();
    }


?>