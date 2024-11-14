<?php
// Start session and include database connection
session_start();
include 'connection.php';

if (isset($_POST['verify'])) {
    // Get the verification code from the form
    $user_code = $_POST['verification_code'];

    if (empty($user_code)) {
        echo "Verification code is required.";
        exit;
    }

    // Use prepared statements to prevent SQL injection
    $stmt = $conn->prepare("SELECT * FROM users WHERE code = ? LIMIT 1");
    $stmt->bind_param("s", $user_code);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Code exists, update the user's account as verified
        $update_stmt = $conn->prepare("UPDATE users SET verified = 1 WHERE code = ?");
        $update_stmt->bind_param("s", $user_code);

        if ($update_stmt->execute()) {
            echo "Your account has been successfully verified!";
            // Optional: Redirect to login or dashboard
            // header("Location: login.php");
            exit();
        } else {
            echo "There was an error during verification. Please try again.";
        }
    } else {
        echo "Invalid verification code. Please check your email and try again.";
    }

    $stmt->close();
} else {
    echo "No verification code received.";
}
?>

<!-- Form for entering the verification code -->
<form method="post">
    <label for="verification_code">Enter Verification Code:</label>
    <input type="text" name="verification_code" id="verification_code" required>
    <button type="submit" name="verify">Verify</button>
</form>
