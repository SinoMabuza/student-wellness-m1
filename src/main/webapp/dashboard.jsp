<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
   String name = (String) request.getAttribute("name");
   String surname = (String) request.getAttribute("surname");
   String studentNumber = (String) request.getAttribute("studentNumber");
   String email = (String) request.getAttribute("email");
   String initials = "";
   if (name != null && !name.isEmpty()) initials += name.substring(0, 1);
   if (surname != null && !surname.isEmpty()) initials += surname.substring(0, 1);
   initials = initials.toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Wellness Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
    }

    .sidebar {
      transition: all 0.3s ease;
      background: linear-gradient(180deg, #4f46e5 0%, #7c3aed 100%);
    }

    .sidebar.collapsed {
      width: 80px;
    }

    .sidebar.collapsed .nav-text {
      display: none;
    }

    .sidebar.collapsed .user-info {
      flex-direction: column;
      align-items: center;
      text-align: center;
    }

    .sidebar.collapsed .user-details {
      display: none;
    }

    .main-content {
      transition: all 0.3s ease;
    }

    .sidebar.collapsed ~ .main-content {
      margin-left: 80px;
    }

    .progress-ring__circle {
      transition: stroke-dashoffset 0.35s;
      transform: rotate(-90deg);
      transform-origin: 50% 50%;
    }

    .chart-container {
      height: 250px;
    }

    .activity-dot {
      width: 10px;
      height: 10px;
      border-radius: 50%;
      display: inline-block;
      margin-right: 8px;
    }

    .sleep-dot { background-color: #6366f1; }
    .stress-dot { background-color: #f59e0b; }
    .activity-dot { background-color: #10b981; }
    .nutrition-dot { background-color: #ec4899; }

    /* Custom scrollbar */
    ::-webkit-scrollbar {
      width: 6px;
    }

    ::-webkit-scrollbar-track {
      background: #f1f1f1;
    }

    ::-webkit-scrollbar-thumb {
      background: #cbd5e1;
      border-radius: 3px;
    }

    ::-webkit-scrollbar-thumb:hover {
      background: #94a3b8;
    }

    /* Custom animations */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .fade-in {
      animation: fadeIn 0.5s ease-out forwards;
    }

    .card-hover {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card-hover:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
    }

    .pulse {
      animation: pulse 2s infinite;
    }

    @keyframes pulse {
      0% { box-shadow: 0 0 0 0 rgba(79, 70, 229, 0.4); }
      70% { box-shadow: 0 0 0 10px rgba(79, 70, 229, 0); }
      100% { box-shadow: 0 0 0 0 rgba(79, 70, 229, 0); }
    }

    .progress-bar {
      transition: width 1s ease-in-out;
    }

    /* Custom toggle switch */
    .toggle-checkbox:checked {
      right: 0;
      border-color: #4f46e5;
    }

    .toggle-checkbox:checked + .toggle-label {
      background-color: #4f46e5;
    }
  </style>
</head>
<body class="text-gray-800">
  <div class="flex h-screen overflow-hidden">
    <!-- Sidebar -->
    <div class="sidebar w-64 fixed h-full z-50 text-white shadow-xl">
      <div class="p-4 flex items-center justify-between border-b border-indigo-400/30">
        <div class="flex items-center">
          <i class="fas fa-heartbeat text-2xl mr-3 text-indigo-200"></i>
          <span class="text-xl font-semibold text-white"></span>
        </div>
        <button id="toggleSidebar" class="text-indigo-200 hover:text-white focus:outline-none transition-colors">
          <i class="fas fa-chevron-left"></i>
        </button>
      </div>

      <div class="p-4 border-b border-indigo-400/30">
        <div class="user-info flex items-center">
          <div class="w-10 h-10 rounded-full bg-indigo-300 flex items-center justify-center shadow-md">
            <span class="text-lg font-semibold text-indigo-800"><%= initials %></span>
          </div>
          <div class="user-details ml-3">
            <div class="font-medium text-white"><%= name %><%= surname %></div>
            <div class="text-xs text-indigo-200"><%= email %></div>
          </div>
        </div>
      </div>

      <nav class="p-4">
        <ul class="space-y-2">
          <li>
            <a href="#" class="flex items-center p-3 rounded-lg bg-white/10 text-white hover:bg-white/20 transition-colors">
              <i class="fas fa-tachometer-alt mr-3 text-indigo-200"></i>
              <span class="nav-text">Dashboard</span>
            </a>
          </li>
          <li>
            <a href="#" class="flex items-center p-3 rounded-lg hover:bg-white/10 text-white transition-colors">
              <i class="fas fa-moon mr-3 text-indigo-200"></i>
              <span class="nav-text">Sleep Tracker</span>
            </a>
          </li>
          <li>
            <a href="#" class="flex items-center p-3 rounded-lg hover:bg-white/10 text-white transition-colors">
              <i class="fas fa-heartbeat mr-3 text-indigo-200"></i>
              <span class="nav-text">Activity Log</span>
            </a>
          </li>
          <li>
            <a href="#" class="flex items-center p-3 rounded-lg hover:bg-white/10 text-white transition-colors">
              <i class="fas fa-utensils mr-3 text-indigo-200"></i>
              <span class="nav-text">Nutrition</span>
            </a>
          </li>
          <li>
            <a href="#" class="flex items-center p-3 rounded-lg hover:bg-white/10 text-white transition-colors">
              <i class="fas fa-chart-line mr-3 text-indigo-200"></i>
              <span class="nav-text">Progress</span>
            </a>
          </li>
          <li>
            <a href="#" class="flex items-center p-3 rounded-lg hover:bg-white/10 text-white transition-colors">
              <i class="fas fa-book mr-3 text-indigo-200"></i>
              <span class="nav-text">Study Planner</span>
            </a>
          </li>
          <li>
            <a href="#" class="flex items-center p-3 rounded-lg hover:bg-white/10 text-white transition-colors">
              <i class="fas fa-cog mr-3 text-indigo-200"></i>
              <span class="nav-text">Settings</span>
            </a>
          </li>
        </ul>
      </nav>

      <div class="absolute bottom-0 w-full p-4">
        <form action="DashboardServlet" method="post">
            <button class="w-full flex items-center justify-center p-3 rounded-lg bg-white/10 hover:bg-white/20 text-white transition-colors">
               <i class="fas fa-sign-out-alt mr-2 text-indigo-200"></i>
               <span class="nav-text">Log Out</span>
            </button>
          </form>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-content flex-1 overflow-auto ml-64">
      <!-- Top Navigation -->
      <header class="bg-white shadow-sm sticky top-0 z-40">
        <div class="flex items-center justify-between px-6 py-4">
          <div class="flex items-center">
            <h1 class="text-2xl  text-indigo-700">Student Wellness Dashboard</h1>
          </div>
          <div class="flex items-center space-x-6">
            <div class="relative group">
              <i class="fas fa-bell text-gray-500 text-xl hover:text-indigo-600 cursor-pointer transition-colors"></i>
              <span class="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full text-white text-xs flex items-center justify-center">3</span>
              <div class="absolute right-0 mt-2 w-72 bg-white rounded-lg shadow-xl p-4 hidden group-hover:block z-50 border border-gray-100">
                <h4 class="font-semibold text-gray-800 mb-2">Notifications</h4>
                <div class="space-y-2">
                  <div class="text-sm p-2 hover:bg-gray-50 rounded cursor-pointer">
                    <p class="font-medium">Wellness check-in reminder</p>
                    <p class="text-gray-500 text-xs">10 minutes ago</p>
                  </div>
                  <div class="text-sm p-2 hover:bg-gray-50 rounded cursor-pointer">
                    <p class="font-medium">New meditation guide available</p>
                    <p class="text-gray-500 text-xs">2 hours ago</p>
                  </div>
                  <div class="text-sm p-2 hover:bg-gray-50 rounded cursor-pointer">
                    <p class="font-medium">Your sleep score improved!</p>
                    <p class="text-gray-500 text-xs">Yesterday</p>
                  </div>
                </div>
                <a href="#" class="block text-center text-indigo-600 text-sm mt-2 font-medium">View All</a>
              </div>
            </div>

            <div class="relative group">
              <i class="fas fa-envelope text-gray-500 text-xl hover:text-indigo-600 cursor-pointer transition-colors"></i>
              <span class="absolute -top-1 -right-1 w-4 h-4 bg-blue-500 rounded-full text-white text-xs flex items-center justify-center">5</span>
              <div class="absolute right-0 mt-2 w-72 bg-white rounded-lg shadow-xl p-4 hidden group-hover:block z-50 border border-gray-100">
                <h4 class="font-semibold text-gray-800 mb-2">Messages</h4>
                <div class="space-y-2">
                  <div class="text-sm p-2 hover:bg-gray-50 rounded cursor-pointer">
                    <p class="font-medium">From: Health Center</p>
                    <p class="text-gray-500 text-xs truncate">Reminder about your upcoming wellness appointment...</p>
                  </div>
                  <div class="text-sm p-2 hover:bg-gray-50 rounded cursor-pointer">
                    <p class="font-medium">From: Study Group</p>
                    <p class="text-gray-500 text-xs truncate">We're meeting tomorrow at the library at 2pm...</p>
                  </div>
                </div>
                <a href="#" class="block text-center text-indigo-600 text-sm mt-2 font-medium">View All</a>
              </div>
            </div>

            <div class="flex items-center space-x-2">
              <div class="w-8 h-8 rounded-full bg-indigo-100 flex items-center justify-center">
                <span class="text-sm font-semibold text-indigo-700"><%= initials %></span>
              </div>
              <span class="hidden md:inline text-sm font-medium"><%= name %><%= surname %></span>
            </div>
          </div>
        </div>
      </header>

      <main class="p-6">
        <!-- Welcome Banner -->
        <div class="bg-gradient-to-r from-indigo-500 to-purple-600 rounded-xl p-6 mb-6 text-white shadow-lg relative overflow-hidden fade-in">
          <div class="absolute -right-10 -top-10 w-32 h-32 bg-white/10 rounded-full"></div>
          <div class="absolute -right-5 -bottom-5 w-24 h-24 bg-white/5 rounded-full"></div>
          <div class="relative z-10 flex flex-col md:flex-row md:items-center md:justify-between">
            <div>
              <h2 class="text-2xl mb-2">Welcome back, <%= name %>!</h2>
              <p class="opacity-90 max-w-lg">Your wellness score is 82 this week - great job! Keep tracking your habits for better academic performance.</p>
            </div>
            <button class="mt-4 md:mt-0 bg-white text-indigo-600 px-6 py-3 rounded-lg font-medium hover:bg-opacity-90 transition shadow-md flex items-center pulse">
              <i class="fas fa-plus-circle mr-2"></i> Daily Check-in
            </button>
          </div>
        </div>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
          <!-- Sleep Card -->
          <div class="bg-white rounded-xl shadow-sm p-6 card-hover fade-in" style="animation-delay: 0.1s">
            <div class="flex items-center justify-between">
              <div>
                <p class="text-gray-500 flex items-center">
                  <i class="fas fa-moon mr-2 text-indigo-400"></i> Sleep Quality
                </p>
                <h3 class="text-2xl font-bold mt-2">7.5 <span class="text-sm font-normal text-gray-500">/10</span></h3>
                <div class="mt-3 flex items-center">
                  <div class="w-full bg-gray-200 rounded-full h-2">
                    <div class="bg-indigo-500 h-2 rounded-full progress-bar" style="width: 75%"></div>
                  </div>
                  <span class="text-xs text-gray-500 ml-2">75%</span>
                </div>
              </div>
              <div class="text-indigo-500 text-3xl">
                <i class="fas fa-bed"></i>
              </div>
            </div>
          </div>

          <!-- Stress Card -->
          <div class="bg-white rounded-xl shadow-sm p-6 card-hover fade-in" style="animation-delay: 0.2s">
            <div class="flex items-center justify-between">
              <div>
                <p class="text-gray-500 flex items-center">
                  <i class="fas fa-brain mr-2 text-amber-400"></i> Stress Level
                </p>
                <h3 class="text-2xl font-bold mt-2">3 <span class="text-sm font-normal text-gray-500">/10</span></h3>
                <div class="mt-3 flex items-center">
                  <div class="w-full bg-gray-200 rounded-full h-2">
                    <div class="bg-amber-400 h-2 rounded-full progress-bar" style="width: 30%"></div>
                  </div>
                  <span class="text-xs text-gray-500 ml-2">30%</span>
                </div>
              </div>
              <div class="text-amber-400 text-3xl">
                <i class="fas fa-cloud"></i>
              </div>
            </div>
          </div>

          <!-- Activity Card -->
          <div class="bg-white rounded-xl shadow-sm p-6 card-hover fade-in" style="animation-delay: 0.3s">
            <div class="flex items-center justify-between">
              <div>
                <p class="text-gray-500 flex items-center">
                  <i class="fas fa-running mr-2 text-green-400"></i> Activity
                </p>
                <h3 class="text-2xl font-bold mt-2">4 <span class="text-sm font-normal text-gray-500">days</span></h3>
                <div class="mt-3 flex items-center">
                  <div class="w-full bg-gray-200 rounded-full h-2">
                    <div class="bg-green-400 h-2 rounded-full progress-bar" style="width: 80%"></div>
                  </div>
                  <span class="text-xs text-gray-500 ml-2">80%</span>
                </div>
              </div>
              <div class="text-green-400 text-3xl">
                <i class="fas fa-dumbbell"></i>
              </div>
            </div>
          </div>

          <!-- Hydration Card -->
          <div class="bg-white rounded-xl shadow-sm p-6 card-hover fade-in" style="animation-delay: 0.4s">
            <div class="flex items-center justify-between">
              <div>
                <p class="text-gray-500 flex items-center">
                  <i class="fas fa-glass-whiskey mr-2 text-blue-400"></i> Hydration
                </p>
                <h3 class="text-2xl font-bold mt-2">6 <span class="text-sm font-normal text-gray-500">glasses</span></h3>
                <div class="mt-3 flex items-center">
                  <div class="w-full bg-gray-200 rounded-full h-2">
                    <div class="bg-blue-400 h-2 rounded-full progress-bar" style="width: 60%"></div>
                  </div>
                  <span class="text-xs text-gray-500 ml-2">60%</span>
                </div>
              </div>
              <div class="text-blue-400 text-3xl">
                <i class="fas fa-tint"></i>
              </div>
            </div>
          </div>
        </div>

        <!-- Charts and Activity Section -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
          <!-- Sleep Chart -->
          <div class="bg-white rounded-xl shadow-sm p-6 lg:col-span-2 card-hover fade-in">
            <div class="flex items-center justify-between mb-4">
              <h3 class="text-lg font-semibold">Weekly Wellness Overview</h3>
              <div class="flex items-center space-x-2">
                <select class="bg-gray-100 border-0 rounded-lg px-3 py-1 text-sm focus:ring-2 focus:ring-indigo-500">
                  <option>This Week</option>
                  <option>Last Week</option>
                  <option>Last Month</option>
                </select>
                <button class="bg-indigo-100 text-indigo-600 p-1 rounded-lg hover:bg-indigo-200 transition">
                  <i class="fas fa-ellipsis-h"></i>
                </button>
              </div>
            </div>
            <div class="chart-container">
              <canvas id="wellnessChart"></canvas>
            </div>
          </div>

          <!-- Recent Activity -->
          <div class="bg-white rounded-xl shadow-sm p-6 card-hover fade-in">
            <div class="flex items-center justify-between mb-4">
              <h3 class="text-lg font-semibold">Recent Activity</h3>
              <button class="text-indigo-600 text-sm font-medium hover:text-indigo-800">
                <i class="fas fa-ellipsis-h"></i>
              </button>
            </div>
            <div class="space-y-4 max-h-96 overflow-y-auto pr-2">
              <div class="flex items-start p-3 hover:bg-gray-50 rounded-lg transition cursor-pointer">
                <div class="activity-dot sleep-dot mt-1 flex-shrink-0"></div>
                <div class="ml-3">
                  <p class="font-medium">Recorded 8 hours of sleep</p>
                  <p class="text-sm text-gray-500">Today, 7:30 AM</p>
                  <div class="mt-1 flex items-center text-xs text-indigo-500">
                    <i class="fas fa-star mr-1"></i> Excellent sleep quality
                  </div>
                </div>
              </div>
              <div class="flex items-start p-3 hover:bg-gray-50 rounded-lg transition cursor-pointer">
                <div class="activity-dot stress-dot mt-1 flex-shrink-0"></div>
                <div class="ml-3">
                  <p class="font-medium">Completed stress assessment</p>
                  <p class="text-sm text-gray-500">Yesterday, 6:15 PM</p>
                  <div class="mt-1 flex items-center text-xs text-amber-500">
                    <i class="fas fa-smile mr-1"></i> Low stress level detected
                  </div>
                </div>
              </div>
              <div class="flex items-start p-3 hover:bg-gray-50 rounded-lg transition cursor-pointer">
                <div class="activity-dot activity-dot mt-1 flex-shrink-0"></div>
                <div class="ml-3">
                  <p class="font-medium">30 min yoga session</p>
                  <p class="text-sm text-gray-500">Yesterday, 4:00 PM</p>
                  <div class="mt-1 flex items-center text-xs text-green-500">
                    <i class="fas fa-fire mr-1"></i> 250 calories burned
                  </div>
                </div>
              </div>
              <div class="flex items-start p-3 hover:bg-gray-50 rounded-lg transition cursor-pointer">
                <div class="activity-dot nutrition-dot mt-1 flex-shrink-0"></div>
                <div class="ml-3">
                  <p class="font-medium">Logged 3 healthy meals</p>
                  <p class="text-sm text-gray-500">Yesterday, 9:30 PM</p>
                  <div class="mt-1 flex items-center text-xs text-pink-500">
                    <i class="fas fa-check-circle mr-1"></i> Balanced nutrition
                  </div>
                </div>
              </div>
              <div class="flex items-start p-3 hover:bg-gray-50 rounded-lg transition cursor-pointer">
                <div class="activity-dot sleep-dot mt-1 flex-shrink-0"></div>
                <div class="ml-3">
                  <p class="font-medium">Study session with breaks</p>
                  <p class="text-sm text-gray-500">Yesterday, 2:00 PM</p>
                  <div class="mt-1 flex items-center text-xs text-blue-500">
                    <i class="fas fa-clock mr-1"></i> 2 hours focused
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Wellness Tips and Goals -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <!-- Wellness Tips -->
          <div class="bg-white rounded-xl shadow-sm p-6 card-hover fade-in">
            <div class="flex items-center justify-between mb-4">
              <h3 class="text-lg font-semibold">Personalized Wellness Tips</h3>
              <button class="text-indigo-600 text-sm font-medium hover:text-indigo-800">
                <i class="fas fa-sync-alt"></i>
              </button>
            </div>
            <div class="space-y-3">
              <div class="flex items-start p-3 bg-indigo-50 rounded-lg hover:bg-indigo-100 transition cursor-pointer">
                <div class="bg-indigo-100 p-2 rounded-lg mr-3">
                  <i class="fas fa-moon text-indigo-500"></i>
                </div>
                <div>
                  <p class="font-medium">Sleep consistency</p>
                  <p class="text-sm text-gray-600">Your bedtime varies by 1.5 hours. Try going to bed within 30 minutes of the same time each night.</p>
                </div>
              </div>
              <div class="flex items-start p-3 bg-green-50 rounded-lg hover:bg-green-100 transition cursor-pointer">
                <div class="bg-green-100 p-2 rounded-lg mr-3">
                  <i class="fas fa-walking text-green-500"></i>
                </div>
                <div>
                  <p class="font-medium">Movement break</p>
                  <p class="text-sm text-gray-600">You've been sitting for 2 hours. Take a 5-minute walk to refresh your mind.</p>
                </div>
              </div>
              <div class="flex items-start p-3 bg-blue-50 rounded-lg hover:bg-blue-100 transition cursor-pointer">
                <div class="bg-blue-100 p-2 rounded-lg mr-3">
                  <i class="fas fa-book text-blue-500"></i>
                </div>
                <div>
                  <p class="font-medium">Study technique</p>
                  <p class="text-sm text-gray-600">Try the Pomodoro technique: 25 minutes focused study, 5-minute break.</p>
                </div>
              </div>
            </div>
          </div>

          <!-- Weekly Goals -->
          <div class="bg-white rounded-xl shadow-sm p-6 card-hover fade-in">
            <div class="flex items-center justify-between mb-4">
              <h3 class="text-lg font-semibold">Weekly Goals Progress</h3>
              <button class="text-indigo-600 text-sm font-medium hover:text-indigo-800 flex items-center">
                <i class="fas fa-plus mr-1"></i> Add Goal
              </button>
            </div>
            <div class="space-y-4">
              <div class="group">
                <div class="flex items-center justify-between mb-1">
                  <span class="font-medium flex items-center">
                    <i class="fas fa-moon text-indigo-500 mr-2"></i> 7+ hours sleep
                  </span>
                  <span class="text-sm text-gray-500">4/7 days</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-indigo-500 h-2 rounded-full progress-bar" style="width: 57%"></div>
                </div>
              </div>

              <div class="group">
                <div class="flex items-center justify-between mb-1">
                  <span class="font-medium flex items-center">
                    <i class="fas fa-running text-green-500 mr-2"></i> 30 min activity
                  </span>
                  <span class="text-sm text-gray-500">3/5 sessions</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-green-500 h-2 rounded-full progress-bar" style="width: 60%"></div>
                </div>
              </div>

              <div class="group">
                <div class="flex items-center justify-between mb-1">
                  <span class="font-medium flex items-center">
                    <i class="fas fa-brain text-purple-500 mr-2"></i> Meditate daily
                  </span>
                  <span class="text-sm text-gray-500">2/7 days</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-purple-500 h-2 rounded-full progress-bar" style="width: 28%"></div>
                </div>
              </div>

              <div class="group">
                <div class="flex items-center justify-between mb-1">
                  <span class="font-medium flex items-center">
                    <i class="fas fa-tint text-blue-500 mr-2"></i> 8 glasses water
                  </span>
                  <span class="text-sm text-gray-500">5/7 days</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-blue-500 h-2 rounded-full progress-bar" style="width: 71%"></div>
                </div>
              </div>

              <div class="group">
                <div class="flex items-center justify-between mb-1">
                  <span class="font-medium flex items-center">
                    <i class="fas fa-book text-amber-500 mr-2"></i> Study sessions
                  </span>
                  <span class="text-sm text-gray-500">6/10 sessions</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-amber-400 h-2 rounded-full progress-bar" style="width: 60%"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="mt-6 bg-white rounded-xl shadow-sm p-6 card-hover fade-in">
          <h3 class="text-lg font-semibold mb-4">Quick Actions</h3>
          <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
            <button class="flex flex-col items-center justify-center p-4 rounded-lg bg-indigo-50 hover:bg-indigo-100 transition text-indigo-600">
              <i class="fas fa-moon text-xl mb-2"></i>
              <span class="text-sm font-medium">Log Sleep</span>
            </button>
            <button class="flex flex-col items-center justify-center p-4 rounded-lg bg-green-50 hover:bg-green-100 transition text-green-600">
              <i class="fas fa-running text-xl mb-2"></i>
              <span class="text-sm font-medium">Add Activity</span>
            </button>
            <button class="flex flex-col items-center justify-center p-4 rounded-lg bg-blue-50 hover:bg-blue-100 transition text-blue-600">
              <i class="fas fa-utensils text-xl mb-2"></i>
              <span class="text-sm font-medium">Log Meal</span>
            </button>
            <button class="flex flex-col items-center justify-center p-4 rounded-lg bg-purple-50 hover:bg-purple-100 transition text-purple-600">
              <i class="fas fa-brain text-xl mb-2"></i>
              <span class="text-sm font-medium">Mood Check</span>
            </button>
          </div>
        </div>
      </main>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
    // Toggle sidebar
    document.getElementById('toggleSidebar').addEventListener('click', function() {
      const sidebar = document.querySelector('.sidebar');
      sidebar.classList.toggle('collapsed');

      const icon = this.querySelector('i');
      if (sidebar.classList.contains('collapsed')) {
        icon.classList.remove('fa-chevron-left');
        icon.classList.add('fa-chevron-right');
      } else {
        icon.classList.remove('fa-chevron-right');
        icon.classList.add('fa-chevron-left');
      }
    });

    // Initialize charts
    document.addEventListener('DOMContentLoaded', function() {
      // Wellness Chart
      const wellnessCtx = document.getElementById('wellnessChart').getContext('2d');
      const wellnessChart = new Chart(wellnessCtx, {
        type: 'line',
        data: {
          labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          datasets: [
            {
              label: 'Sleep (hours)',
              data: [6.5, 7, 7.5, 8, 7, 8.5, 9],
              borderColor: 'rgba(99, 102, 241, 1)',
              backgroundColor: 'rgba(99, 102, 241, 0.05)',
              borderWidth: 2,
              tension: 0.3,
              fill: true,
              pointBackgroundColor: 'rgba(99, 102, 241, 1)',
              pointRadius: 4,
              pointHoverRadius: 6,
              yAxisID: 'y'
            },
            {
              label: 'Stress Level',
              data: [4, 3, 5, 2, 4, 3, 2],
              borderColor: 'rgba(245, 158, 11, 1)',
              backgroundColor: 'rgba(245, 158, 11, 0.05)',
              borderWidth: 2,
              tension: 0.3,
              fill: true,
              pointBackgroundColor: 'rgba(245, 158, 11, 1)',
              pointRadius: 4,
              pointHoverRadius: 6,
              yAxisID: 'y1'
            },
            {
              label: 'Activity (min)',
              data: [30, 45, 20, 60, 30, 0, 90],
              borderColor: 'rgba(16, 185, 129, 1)',
              backgroundColor: 'rgba(16, 185, 129, 0.05)',
              borderWidth: 2,
              tension: 0.3,
              fill: true,
              pointBackgroundColor: 'rgba(16, 185, 129, 1)',
              pointRadius: 4,
              pointHoverRadius: 6,
              yAxisID: 'y2'
            }
          ]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: 'top',
              align: 'end',
              labels: {
                usePointStyle: true,
                padding: 20
              }
            },
            tooltip: {
              mode: 'index',
              intersect: false
            }
          },
          scales: {
            y: {
              type: 'linear',
              display: true,
              position: 'left',
              title: {
                display: true,
                text: 'Hours'
              },
              min: 5,
              max: 10
            },
            y1: {
              type: 'linear',
              display: true,
              position: 'right',
              grid: {
                drawOnChartArea: false
              },
              title: {
                display: true,
                text: 'Stress (1-10)'
              },
              min: 0,
              max: 10,
              reverse: true
            },
            y2: {
              type: 'linear',
              display: false,
              position: 'right',
              min: 0,
              max: 120
            }
          }
        }
      });

      // Animate progress bars
      const progressBars = document.querySelectorAll('.progress-bar');
      progressBars.forEach(bar => {
        const width = bar.style.width;
        bar.style.width = '0';
        setTimeout(() => {
          bar.style.width = width;
        }, 100);
      });

      // Simulate loading animation for stats
      const statValues = document.querySelectorAll('.text-2xl.font-bold');
      statValues.forEach((stat, index) => {
        const originalText = stat.textContent;
        stat.textContent = '0';

        let count = 0;
        const target = parseFloat(originalText);
        const increment = target / 20;

        const timer = setInterval(() => {
          count += increment;
          if (count >= target) {
            stat.textContent = originalText;
            clearInterval(timer);
          } else {
            stat.textContent = count.toFixed(1);
          }
        }, 50 + (index * 20));
      });
    });

    // Dark mode toggle functionality
    const darkModeToggle = document.createElement('div');
    darkModeToggle.innerHTML = `
      <div class="fixed bottom-6 right-6 z-50">
        <div class="relative inline-block w-12 mr-2 align-middle select-none">
          <input type="checkbox" name="toggle" id="toggle" class="toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4 appearance-none cursor-pointer"/>
          <label for="toggle" class="toggle-label block overflow-hidden h-6 rounded-full bg-gray-300 cursor-pointer"></label>
        </div>
        <label for="toggle" class="text-xs text-gray-700 dark:text-gray-200">
          <i class="fas fa-moon"></i>
        </label>
      </div>
    `;
    document.body.appendChild(darkModeToggle);

    document.getElementById('toggle').addEventListener('change', function() {
      if(this.checked) {
        document.documentElement.classList.add('dark');
        document.body.classList.add('bg-gray-900');
        document.body.classList.remove('bg-gray-50');
      } else {
        document.documentElement.classList.remove('dark');
        document.body.classList.remove('bg-gray-900');
        document.body.classList.add('bg-gray-50');
      }
    });
  </script>
</body>
</html>