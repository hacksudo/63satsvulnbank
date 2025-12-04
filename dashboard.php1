<?php
// dashboard.php
session_start();
include("includes/db.php");
include("includes/header.php");

// Vulnerable authentication: trusts session or cookie interchangeably
$user = null;
$user_id = null;

if (isset($_SESSION['user'])) {
    $user = $_SESSION['user'];
    $r = mysqli_query($conn, "SELECT id FROM users WHERE username = '" . mysqli_real_escape_string($conn, $user) . "' LIMIT 1");
    if ($r && mysqli_num_rows($r) > 0) {
        $row = mysqli_fetch_assoc($r);
        $user_id = $row['id'];
    }
} elseif (isset($_COOKIE['UID'])) {
    $user_id = intval($_COOKIE['UID']);
    $r = mysqli_query($conn, "SELECT username FROM users WHERE id = $user_id LIMIT 1");
    if ($r && mysqli_num_rows($r) > 0) {
        $row = mysqli_fetch_assoc($r);
        $user = $row['username'];
    } else {
        $user = null;
    }
}

// View other user's profile if uid param provided (IDOR)
$view_uid = isset($_GET['uid']) ? $_GET['uid'] : $user_id;
?>
<!doctype html>
<html lang="en" class="light">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Dashboard - 63Sats Bank</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="css/style.css">
  <script defer src="js/theme.js"></script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 text-gray-800 dark:text-gray-100 min-h-screen">
<div class="max-w-5xl mx-auto p-6">
  <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-2xl font-semibold">Account Dashboard</h1>
        <?php if ($user): ?>
          <p class="text-sm text-gray-600 dark:text-gray-300 mt-1"><?php echo htmlspecialchars($user); ?></p>
        <?php else: ?>
          <p class="text-sm text-gray-600 dark:text-gray-300 mt-1">Guest</p>
        <?php endif; ?>
      </div>
      <div>
        <a href="transfer.php" class="px-3 py-2 bg-blue-600 text-white rounded">Make Transfer</a>
      </div>
    </div>

    <div class="mt-6">
      <?php
      if ($view_uid) {

          // FIXED QUERY: JOIN users + accounts to get balance
          $sql = "
              SELECT 
                  users.id,
                  users.username,
                  users.email,
                  accounts.balance
              FROM users
              LEFT JOIN accounts ON users.id = accounts.user_id
              WHERE users.id = $view_uid
              LIMIT 1
          ";

          $res = mysqli_query($conn, $sql);
          if ($res && mysqli_num_rows($res) > 0) {
              $u = mysqli_fetch_assoc($res);
              ?>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="p-4 border rounded">
                  <h3 class="font-medium">Profile</h3>
                  <p class="mt-2"><strong>Username:</strong> <?php echo htmlspecialchars($u['username']); ?></p>
                  <p class="mt-1"><strong>Email:</strong> <?php echo $u['email']; ?></p>
                </div>

                <div class="p-4 border rounded">
                  <h3 class="font-medium">Account</h3>
                  <p class="mt-2"><strong>Account ID:</strong> <?php echo intval($u['id']); ?></p>
                  <p class="mt-1"><strong>Balance:</strong> ₹ <?php echo htmlspecialchars($u['balance']); ?></p>
                </div>
              </div>

              <div class="mt-4 flex gap-2">
                <a href="edit.php?uid=<?php echo intval($u['id']); ?>" class="px-3 py-2 bg-yellow-500 rounded text-white">Edit Profile</a>
                <a href="statement.php?uid=<?php echo intval($u['id']); ?>" class="px-3 py-2 bg-gray-200 dark:bg-gray-700 rounded">View Statements</a>
              </div>
              <?php
          } else {
              echo '<div class="p-4 bg-red-50 dark:bg-red-900 text-red-700 rounded">No account found.</div>';
          }
      }
      ?>
    </div>

    <div class="mt-6">
      <h3 class="font-medium">Search</h3>
      <form method="GET" action="dashboard.php" class="mt-2 flex gap-2">
        <input name="q" class="flex-1 rounded border px-3 py-2 bg-gray-50 dark:bg-gray-700" placeholder="Search transactions" value="<?php echo isset($_GET['q']) ? htmlspecialchars($_GET['q']) : ''; ?>">
        <button type="submit" class="px-4 py-2 bg-gray-700 text-white rounded">Search</button>
      </form>

      <?php
      if (isset($_GET['q'])) {
          echo '<div class="mt-3 p-3 border rounded bg-gray-50 dark:bg-gray-700">Results for: ' . $_GET['q'] . '</div>';
      }
      ?>
    </div>
  </div>
</div>
</body>
</html>
