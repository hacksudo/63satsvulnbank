<?php
// transfer.php
// Path: /transfer.php
session_start();
include("includes/db.php");
include("includes/header.php");

$message = "";

// Determine authenticated user id (vulnerable: trusts session or cookie)
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

// Process transfer (no CSRF token, minimal validation)
if (isset($_POST['transfer'])) {
    // Attacker can forge form from another site (CSRF)
    $from = intval($_POST['from'] ?? $user_id);
    $to   = intval($_POST['to'] ?? 0);
    $amt  = floatval($_POST['amount'] ?? 0);

    if ($amt <= 0) {
        $message = "Invalid amount.";
    } else {
        // Simple logic: subtract from sender, add to receiver (no race checks)
        // Vulnerable to IDOR if 'from' is provided by attacker
        mysqli_autocommit($conn, false);

        $q1 = "UPDATE users SET balance = balance - $amt WHERE id = $from";
        $q2 = "UPDATE users SET balance = balance + $amt WHERE id = $to";

        $r1 = mysqli_query($conn, $q1);
        $r2 = mysqli_query($conn, $q2);

        if ($r1 && $r2) {
            mysqli_commit($conn);
            $message = "Transfer completed.";
            // Log transaction
            $tsql = "INSERT INTO transactions (from_id,to_id,amount,created_at) VALUES ($from,$to,$amt,NOW())";
            @mysqli_query($conn, $tsql);
        } else {
            mysqli_rollback($conn);
            $message = "Transfer failed.";
        }
    }
}
?>
<!doctype html>
<html lang="en" class="light">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Transfer - 63Sats Bank</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="css/style.css">
  <script defer src="js/theme.js"></script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 text-gray-800 dark:text-gray-100 min-h-screen">
<div class="max-w-3xl mx-auto p-6">
  <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
    <div class="flex justify-between items-center">
      <h1 class="text-lg font-semibold">Make a Transfer</h1>
      <?php if ($message): ?>
        <div class="text-sm text-green-700 dark:text-green-300"><?php echo htmlspecialchars($message); ?></div>
      <?php endif; ?>
    </div>
    <form method="POST" class="mt-4 space-y-4">
      <div>
        <label class="block text-sm">From Account ID</label>
        <input name="from" value="<?php echo htmlspecialchars($user_id); ?>" class="mt-1 w-full rounded border px-3 py-2 bg-gray-50 dark:bg-gray-700" />
      </div>

      <div>
        <label class="block text-sm">To Account ID</label>
        <input name="to" required class="mt-1 w-full rounded border px-3 py-2 bg-gray-50 dark:bg-gray-700" />
      </div>

      <div>
        <label class="block text-sm">Amount</label>
        <input name="amount" type="number" step="0.01" required class="mt-1 w-full rounded border px-3 py-2 bg-gray-50 dark:bg-gray-700" />
      </div>

      <div class="flex justify-end">
        <button type="submit" name="transfer" class="px-4 py-2 bg-blue-600 text-white rounded">Send</button>
      </div>
    </form>

    <div class="mt-6">
      <h2 class="text-sm font-medium">Recent Transfers</h2>
      <div class="mt-2 text-sm text-gray-600 dark:text-gray-300">
        <?php
        // Show recent transactions for current user id (if known)
        $uid = intval($user_id ?: 0);
        $res = mysqli_query($conn, "SELECT * FROM transactions WHERE from_id = $uid OR to_id = $uid ORDER BY id DESC LIMIT 10");
        if ($res && mysqli_num_rows($res) > 0) {
            echo "<table class='w-full mt-2 text-sm'><tr><th>ID</th><th>From</th><th>To</th><th>Amount</th><th>Date</th></tr>";
            while ($t = mysqli_fetch_assoc($res)) {
                echo "<tr><td>" . intval($t['id']) . "</td><td>" . intval($t['from_id']) . "</td><td>" . intval($t['to_id']) . "</td><td>" . htmlspecialchars($t['amount']) . "</td><td>" . htmlspecialchars($t['created_at']) . "</td></tr>";
            }
            echo "</table>";
        } else {
            echo "<div class='text-sm text-gray-500'>No recent transfers.</div>";
        }
        ?>
      </div>
    </div>
  </div>
</div>
</body>
</html>
