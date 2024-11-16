<?php

use PHPMailer\PHPMailer\PHPMailer;

function sendEmail($recipientEmail, $subject, $bodyContent) {
    $mail = new PHPMailer(true);

    try {
        // Server settings
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'info.doctorappointmentsystem@gmail.com';
        $mail->Password   = 'toku xsvx fbdf hmep'; // Consider using environment variables for security
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
        $mail->Port       = 465;

        // Sender and recipient
        $mail->setFrom('info.doctorappointmentsystem@gmail.com', 'Doctor Appointment System');
        $mail->addAddress($recipientEmail);

        // Content
        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body    = $bodyContent;

        $mail->send();
        return "<div class='alert alert-info'>Email has been sent successfully to {$recipientEmail}.</div>";
    } catch (Exception $e) {
        return "<div class='alert alert-danger'>Message could not be sent. Mailer Error: {$mail->ErrorInfo}</div>";
    }
}

function getDoctorDetails($database, $scheduleid) {
    $sql3 = "SELECT * FROM schedule WHERE scheduleid=?";
    $stmt = $database->prepare($sql3);
    $stmt->bind_param("i", $scheduleid);
    $stmt->execute();
    $schedulerow = $stmt->get_result();
    $schedulefetch = $schedulerow->fetch_assoc();
    $docid = $schedulefetch["docid"];

    $sql4 = "SELECT * FROM doctor WHERE docid=?";
    $stmt = $database->prepare($sql4);
    $stmt->bind_param("i", $docid);
    $stmt->execute();
    $docrow = $stmt->get_result();
    return $docrow->fetch_assoc();
}

// notifying patient
function notifyPatient($patientEmail, $username, $apponum, $date, $docname) {
    $subject = "Appointment Booked";
    $body = "Dear " . $username . ",<br><br>Your appointment has been successfully booked.<br><br>Appointment Number: " . $apponum . "<br>Appointment Date: " . $date . "<br>
    Doctor Name: " . $docname . "<br><br>Please be on time for your appointment.<br><br>
    <br>Thank you for using our service.<br><br>Regards,<br>Doctor Appointment System";
    return sendEmail($patientEmail, $subject, $body);
}

// notify doctor
function notifyDoctor($docemail, $docname, $apponum, $date) {
    $subject = "New Appointment";
    $body = "Dear Dr. " . $docname . ",<br><br>A new appointment has been booked.<br><br>Appointment Number: " . $apponum . "<br>Appointment Date: " . $date . "<br><br>Thank you for using our service.<br><br>Regards,<br>Doctor Appointment System";
    return sendEmail($docemail, $subject, $body);
}

// notify admin
function notifyAdmin($adminEmail, $apponum, $date, $username, $doctorName) {
    $subject = "New Appointment";
    $body = "Dear Admin,<br><br>A new appointment has been booked.<br><br>Appointment Number: " . $apponum . "<br>Appointment Date: " . $date . "<br>Patient Name: " . $username . "<br>Doctor Name: " . $doctorName . "<br><br>Thank you for using our service.<br><br>Regards,<br>Doctor Appointment System";
    return sendEmail($adminEmail, $subject, $body);
}

// notify for appointment cancellation for patient
function notifyCancellation($email, $patientName, $apponum, $date, $docname) {
    $subject = "Appointment Cancellation";
    $body = "Dear " . $patientName . ",<br><br>Your appointment has been cancelled.<br><br>Appointment Number: " . $apponum . "<br>Appointment Date: " . $date . "<br>
    Doctor Name: " . $docname . "<br><br>Regards,<br>Doctor Appointment System";
    return sendEmail($email, $subject, $body);
}

// notify for appointment cancellation for doctor
function notifyCancellationDoctor($email, $apponum, $date, $patientName) {
    $subject = "Appointment Cancellation";
    $body = "Dear Dr. " . $email . ",<br><br>Your appointment has been cancelled.<br><br>Appointment Number: " . $apponum . "<br>Appointment Date: " . $date . "<br>
    Patient Name: " . $patientName . "<br><br>Regards,<br>Doctor Appointment System";
    return sendEmail($email, $subject, $body);
}

// notify for appointment cancellation for admin
function notifyCancellationAdmin($email, $apponum, $date, $patientName, $docname) {
    $subject = "Appointment Cancellation";
    $body = "Dear Admin,<br><br>An appointment has been cancelled.<br><br>Appointment Number: " . $apponum . "<br>Appointment Date: " . $date . "<br>
    Patient Name: " . $patientName . "<br>Doctor Name: " . $docname . "<br><br>Regards,<br>Doctor Appointment System";
    return sendEmail($email, $subject, $body);
}
        

?>