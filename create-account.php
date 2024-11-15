<?php
// Import PHPMailer classes into the global namespace
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

// Start the session
session_start();
if (isset($_SESSION['SESSION_EMAIL'])) {
    header("Location: otp_verify.php");
    die();
}

// Load Composer's autoloader
require 'vendor/autoload.php';

// Include database connection
include 'connection.php';
$msg = ""; // Initialize message variable

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['submit'])) {
    // Validate form inputs
    if (!empty($_POST['tele']) && !empty($_POST['nic']) && !empty($_POST['email']) && !empty($_POST['password']) && !empty($_POST['confirm-password'])) {
        $tele = mysqli_real_escape_string($conn, $_POST['tele']);
        $nic = mysqli_real_escape_string($conn, $_POST['nic']);
        $email = mysqli_real_escape_string($conn, $_POST['email']);
        $password = $_POST['password'];
        $confirm_password = $_POST['confirm-password'];
        $code = mysqli_real_escape_string($conn, md5(rand())); // Generate verification code

        // Validate phone number and NIC number
        if (strlen($tele) != 10 || !is_numeric($tele)) {
            $msg = "<div class='alert alert-danger'>Phone number must be exactly 10 digits.</div>";
        } elseif (strlen($nic) != 9) {
            $msg = "<div class='alert alert-danger'>NIC number must be exactly 9 characters.</div>";
        } else {
            // Check if email or phone number already exists
            $check_user = mysqli_query($conn, "SELECT * FROM users WHERE email='{$email}' OR tele='{$tele}'");
            if (mysqli_num_rows($check_user) > 0) {
                $msg = "<div class='alert alert-danger'>Email or phone number already registered.</div>";
            } else {
                // Check if password and confirm password match
                if ($password === $confirm_password) {
                    // Hash the password
                    $password_hash = password_hash($password, PASSWORD_DEFAULT);

                    // Generate a random 6-digit OTP
                    $otp = rand(100000, 999999);

                    // Insert new user into the database with OTP
                    $sql = "INSERT INTO users (tele, nic, email, password, code, otp, verified) VALUES ('{$tele}', '{$nic}', '{$email}', '{$password_hash}', '{$code}', '{$otp}', 0)";
                    $result = mysqli_query($conn, $sql);

                    if ($result) {
                        // Send OTP email
                        $mail = new PHPMailer(true);
                        try {
                            $mail->isSMTP();
                            $mail->Host       = 'smtp.gmail.com';
                            $mail->SMTPAuth   = true;
                            $mail->Username   = 'info.doctorappointmentsystem@gmail.com';
                            $mail->Password   = 'toku xsvx fbdf hmep'; // Consider using environment variables for security
                            $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
                            $mail->Port       = 465;

                            $mail->setFrom('info.doctorappointmentsystem@gmail.com', 'Doctor Appointment System');
                            $mail->addAddress($email);

                            $mail->isHTML(true);
                            $mail->Subject = 'Account Verification OTP';
                            $mail->Body    = 'Please use the following OTP to verify your account: <b>' . $otp . '</b>';

                            $mail->send();
                            $msg = "<div class='alert alert-info'>An OTP has been sent to your email address.</div>";

                            //setting generated otp to session variable
                            $_SESSION['otp'] = $otp;
                            $_SESSION['email'] = $email;

                            //redirecting to verify OTP page
                            header("Location: otp_verify.php");
                            exit();
                        } catch (Exception $e) {
                            $msg = "<div class='alert alert-danger'>Message could not be sent. Mailer Error: {$mail->ErrorInfo}</div>";
                        }
                    } else {
                        $msg = "<div class='alert alert-danger'>Something went wrong. Please try again.</div>";
                    }
                } else {
                    $msg = "<div class='alert alert-warning'>Passwords do not match.</div>";
                }
            }
        }
    } else {
        $msg = "<div class='alert alert-danger'>All fields are required.</div>";
    }
}
?>

<!-- HTML form for user registration -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/animations.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/signup.css">
    <title>Create Account</title>
    <style>
        .container {
            animation: transitionIn-X 0.5s;
        }
    </style>
</head>
<body>
    <center>
        <div class="container">
            <form action="" method="POST">
                <table border="0">
                    <tr>
                        <td colspan="2">
                            <p class="header-text">Create Your Account</p>
                            <p class="sub-text">Sign up with your details below</p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="label-td">
                            <input type="text" name="tele" class="input-text" placeholder="Phone Number (10 digits)" required>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="label-td">
                            <input type="text" name="nic" class="input-text" placeholder="NIC Number (9 characters)">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="label-td">
                            <input type="email" name="email" class="input-text" placeholder="Email Address" required>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="label-td">
                            <input type="password" name="password" class="input-text" placeholder="Create Password" required>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="label-td">
                            <input type="password" name="confirm-password" class="input-text" placeholder="Confirm Password" required>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="reset" value="Reset" class="btn-primary-soft btn"></td>
                        <td><input type="submit" name="submit" value="Sign Up" class="btn-primary btn"></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="label-td">
                            <p class="sub-text">Already have an account? <a href="login.php" class="login-link">Login</a></p>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </center>
    <?php echo $msg; ?>
</body>
</html>
