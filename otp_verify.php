<?php
session_start();
include 'connection.php'; // Ensure database connection

// Initialize message
$msg = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['verify'])) {
    // Get OTP from the form
    $entered_otp = mysqli_real_escape_string($database, $_POST['otp']);

    // Ensure OTP exists in the session
    if (isset($_SESSION['otp']) && isset($_SESSION['email'])) {
        $stored_otp = $_SESSION['otp'];
        $email = $_SESSION['email'];

        if ($entered_otp == $stored_otp) {
            // Update the database to mark the user as verified
            $update = mysqli_query($database, "UPDATE users SET verified = 1 WHERE email = '$email'");
            if ($update) {
                if (mysqli_affected_rows($database) > 0) {
                    $msg = "Account verified successfully! You can now log in.";
                    session_unset(); // Clear session data
                    header("Location: login.php");
                    exit();
                } else {
                    $msg = "Database update did not affect any rows.";
                }
            } else {
                $msg = "Database error: " . mysqli_error($conn);
            }
        } else {
            $msg = "Incorrect OTP. Please try again.";
        }
    } else {
        $msg = "OTP or email is not set. Please retry the signup process.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="otp_verify.css">
    <title>OTP Verification</title>
</head>
<body>
    <center>
        <div class="container">
            <h1>OTP Verification</h1>
            <p style="color: red;"><?= $msg ?></p>

            <!-- OTP Verification Form -->
            <form method="post">
                <label for="otp">Enter OTP:</label>
                <input type="text" name="otp" id="otp" required>
                <button type="submit" name="verify">Verify</button>
            </form>
        </div>
    </center>
</body>
</html>
