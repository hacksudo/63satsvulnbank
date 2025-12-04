<?php
// statement.php
// Path: /statement.php
session_start();
include("includes/db.php");
include("includes/header.php");

// Determine logged in user (vulnerable)
$user_id = null;
if (isset($_SESSION['user'])) {
    $u = mysqli_real_escape_string($conn, $_SESSION['user']);
    $r = mysqli_query($conn, "SELECT id FROM users WHERE username='$u' LIMIT 1");
    if ($r && mysqli_num_rows($r) > 0) {
        $row = mysqli_fetch_assoc($r);
        $user_id = $row['id'];
    }
} elseif (isset($_COOKIE['UID'])) {
    $user_id = intval($_COOKIE['UID']);
}

// IDOR: allow ?uid= to view other users statement
$view_uid = isset($_GET['uid']) ? $_GET['uid'] : $user_id;

?>
<!doctype html>
<html lang="en" class="light">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Statements - 63sats Bank</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="css/style.css">
  <script defer src="js/theme.js"></script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 text-gray-800 dark:text-gray-100 min-h-screen">
<div class="max-w-4xl mx-auto p-6">
  <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
    <h1 class="text-xl font-semibold">Account Statement</h1>
    <p class="text-sm text-gray-600 dark:text-gray-300 mt-1">View recent transactions for an account.</p>

    <?php
    if ($view_uid) {
        // Vulnerable: using user-controlled input directly (SQLi potential)
        $sql = "SELECT id,from_id,to_id,amount,created_at,description FROM transactions WHERE from_id = $view_uid OR to_id = $view_uid ORDER BY id DESC LIMIT 50";
        $res = mysqli_query($conn, $sql);
        if ($res && mysqli_num_rows($res) > 0) {
            echo "<table class='w-full mt-4 text-sm'><tr><th>ID</th><th>From</th><th>To</th><th>Amount</th><th>Description</th><th>Date</th></tr>";
            while ($t = mysqli_fetch_assoc($res)) {
                // description printed raw to allow XSS/stored content testing
                echo "<tr><td>" . intval($t['id']) . "</td><td>" . intval($t['from_id']) . "</td><td>" . intval($t['to_id']) . "</td><td>" . htmlspecialchars($t['amount']) . "</td><td>" . $t['description'] . "</td><td>" . htmlspecialchars($t['created_at']) . "</td></tr>";
            }
            echo "</table>";
        } else {
            echo "<div class='mt-4 text-sm text-gray-500'>No transactions found.</div>";
        }
    } else {
        echo "<div class='mt-4 text-sm text-gray-500'>No account selected.</div>";
    }
    ?>

  </div>
</div>
</body>
</html>
