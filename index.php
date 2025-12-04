<?php
// 🔥 Start session BEFORE any output
include("includes/header.php");

// Intentionally vulnerable LFI
if (isset($_GET['page'])) {
    include($_GET['page']);
}
?>
<!doctype html>
<html lang="en" class="light">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>63Sats Bank</title>

  <!-- Tailwind CDN -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Your Custom CSS -->
  <link rel="stylesheet" href="css/style.css">

  <!-- Theme toggle -->
  <script defer src="js/theme.js"></script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 text-gray-800 dark:text-gray-100 min-h-screen">

<main class="max-w-6xl mx-auto p-6">
  <section class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-2xl font-semibold">Welcome to 63Sats Bank</h1>
        <p class="mt-2 text-sm text-gray-600 dark:text-gray-300">
          Manage your accounts, view statements, and interact with services.
        </p>
      </div>
      <img src="https://via.placeholder.com/120x80?text=Logo" alt="logo" class="rounded">
    </div>

    <div class="mt-6 grid grid-cols-1 md:grid-cols-3 gap-4">
      <a href="dashboard.php" class="block p-4 bg-gray-50 dark:bg-gray-700 rounded hover:shadow">
        <h3 class="font-medium">Dashboard</h3>
        <p class="text-sm text-gray-500 dark:text-gray-300 mt-1">Your account overview</p>
      </a>

      <a href="transfer.php" class="block p-4 bg-gray-50 dark:bg-gray-700 rounded hover:shadow">
        <h3 class="font-medium">Transfer</h3>
        <p class="text-sm text-gray-500 dark:text-gray-300 mt-1">Send money securely</p>
      </a>

      <a href="blog.php" class="block p-4 bg-gray-50 dark:bg-gray-700 rounded hover:shadow">
        <h3 class="font-medium">News & Updates</h3>
        <p class="text-sm text-gray-500 dark:text-gray-300 mt-1">Read bank announcements</p>
      </a>
    </div>
  </section>

  <section class="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
    <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
      <h2 class="text-lg font-semibold">Quick Links</h2>
      <ul class="mt-4 space-y-2 text-sm text-gray-600 dark:text-gray-300">
        <li><a class="underline" href="login.php">Login</a></li>
        <li><a class="underline" href="register.php">Register</a></li>
        <li><a class="underline" href="contact.php">Contact</a></li>
        <li><a class="underline" href="about.php">About</a></li>
      </ul>
    </div>

    <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
      <h2 class="text-lg font-semibold">Recent Articles</h2>
      <div class="mt-4 space-y-3">

        <article class="p-3 border rounded">
          <a href="blog_view.php?id=1" class="font-medium block">Service updates</a>
          <p class="text-sm text-gray-500 dark:text-gray-300 mt-1">
            Monthly maintenance schedule and details.
          </p>
        </article>

        <article class="p-3 border rounded">
          <a href="blog_view.php?id=2" class="font-medium block">Security notices</a>
          <p class="text-sm text-gray-500 dark:text-gray-300 mt-1">
            Important announcements for customers.
          </p>
        </article>

      </div>
    </div>
  </section>
</main>

<footer class="py-6 text-center text-sm text-gray-500 dark:text-gray-400">
  &copy; <?php echo date('Y'); ?> 63sats Bank. All rights reserved.
</footer>

</body>
</html>
