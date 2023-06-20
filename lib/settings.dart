import 'dart:io';

class TelemedSettings {
  static String appName = "Telemed";
  static DateTime startDate = DateTime(1970);
  static DateTime endDate = DateTime.now().add(const Duration(days: 3660));
  static String initialCountryCode = "63";
  static String CONTANT_UNAUTHENTICATED = "Unauthenticated";

  // Server details
  static String authority = "192.168.22.1";
  static String unencodedPath = "telemed/public/api";

  static getHttpHeaders({String? token}) {
    Map<String, String> httpHeaders = {};
    httpHeaders.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json; charset=UTF-8');
    if (token != null) {
      httpHeaders.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $token');
    }
    return httpHeaders;
  }
}
class TelemedJsendStatus {
  static String success = 'success';
  static String fail = 'fail';
  static String error = 'error';
}

class TelemedStrings {
  static String unauthenticatedAccessTitle = "Unauthenticated Access";
  static String unauthenticatedAccessMessage = "Sorry. This seems like an unauthenticated access. Please verify yourself by signing in again.";
  static String loading = "Loading";
  static String pleaseWait = "Please wait...";
  static String patient = "Patient";
  static String doctor = "Doctor";
  static String signIn = "Sign In";
  static String signUp = "Sign Up";
  static String signOut = "Sign out";
  static String cancel = "Cancel";
  static String ok = "ok";
  static String fail = "fail";
  static String success = "success";
  static String deleteSuccessful = "deleteSuccessful";

  // Patient Registration
  static String createAccount = "Create an account";
  static String pleaseEnterText = "Please enter text";
  static String email = "Email";
  static String password = "Password";
  static String here2SeeYou = "Here2SeeU";
  static String signInToYourAccount = "Sign in to your account";
  static String welcomeBack = "Welcome back! You have been missed.";
  static String remember = "Remember for 30 days";
  static String forgotPassword = "Forgot Password?";
  static String signInWith = "or Sign In with";
  static String noAccount = "Don't have an account?";
  static String getStarted = "Let's get you started. Please enter your details";
  static String passwordStrength = "Password strength:";
  static String proceed = "Continue";
  static String toProceed = "By tapping 'Continue', you agree to accept our ";
  static String privacyPolicy = "Privacy Policy";
  static String termsOfService = "Terms of Service";
  static String and = "and";
  static String haveAccount = "Already have an account?";
  static String basicInformation = "Basic Information";
  static String basicInfo =
      "Please tell us some basic information to complete your profile:";
  static String firstName = "First Name";
  static String lastName = "Last Name";
  static String address = "Address";
  static String selectDateOfBirth = "Select date of birth";
  static String dateOfBirth = "Date of Birth";
  static String month = "Month";
  static String day = "Day";
  static String year = "Year";
  static String bloodPressure = "Blood Pressure";
  static String bloodType = "Blood Type";
  static String gender = "Gender";
  static String male = "Male";
  static String female = "Female";
  static String phoneNumber = "Phone Number";
  static String phoneNote =
      "By providing your mobile number you give us permission to contact you via text.";
  static String healthInsurance = "Health Insurance";
  static String hInsurance =
      "Search for your heath insurance provider to see if you're cover";
  static String search = "Search";
  static String insuranceEx = "e.g PhilHealth, MediCard etc.";
  static String save = "Save";
  static String skipInsurance = "Skip Insurance";
  static String skipIns = "You can see a doctor without insurance";

  // Home
  static String greetings = "Greetings!";
  static String supp = "What do you want to do today?";
  static String upcomingAppointments = "Upcoming Appointments";
  static String scheduledAppointments =
      "You currently don't have an appointment scheduled."; //this will direct the patient user to the Calendar only if they have an appointment booked. if not, they will direct to booking page
  static String bookNow = "Book an appointment today!";
  static String generalNeeds = "For General Needs";
  static String generalNeedsChoosePrimary =
      "Choose a Primary Care Doctor and complete your first video appointment.";
  static String gNeeds =
      "Get medical advice prescriptions, test & referrals by video appointment with our doctors.";
  static String specificNeeds = "For Specific Needs";
  static String specificNeedsPrimary =
      "Our primary care doctors can help you with a broad range of health issues, medications and more by video appointment.";
  static String childrenHealth = "Children's Health";
  static String childHealth =
      "Cold & Flu symptoms, Diarrhea or Constipation, Skin rashed, & Allergies";
  static String seniorHealth = "seniorHealth";
  static String senHealth =
      "Muscle or joint pain, Medication management, Preventive Health method.";
  static String home = "Home";
  static String calendar = "Calendar";
  static String message = "Message";
  static String profile = "Profile";

  // Book Appointment
  static String patientLocation = "What is the patient's current location?";
  static String patientConnection =
      "This would help us connect you with the best available licensed Doctor for that location on our platform.";
  static String reasonOfVisit = "What’s the main reason for your visit?";
  static String newHealthConcern = "New Health Concern";
  static String findDoctor = "Find a doctor";
  static String routineCheckup = "Routine checkup, Follow-up or Screening";
  static String prescRefills = "Prescriptions or Refills";
  static String talkToPharmacist = "Talk to a Pharmacist";
  static String mentalHealthConcern = "General Mental Health Concerns";
  static String otherMedReason = "Other Medical Reasons";
  static String medEmergency =
      "For medical emergencies, please call 112 (or your local emergency number) or go to the nearest emergency hospital.";
  static String nextIsCader = "Next -- Select a Cader >";

  // Select Field
  static String selectCaderHeader = "Select a Cader";
  static String caders = "Caders";
  static String cardiologist = "Cardiologist";
  static String cardio = "Heart Specialist";
  static String neurologist = "Neurologist";
  static String neuro = "Brain Specialist";
  static String dentist = "Dentist";
  static String dent = "Dental Surgeon";
  static String opthalmologist = "Opthalmologist";
  static String optha = "Eye Specialist";
  static String medicalOfficers = "Medical Officers";
  static String childSpecialist = "Child Specialist";

  // Choose Doctor
  static String doctorsCloseby = "Doctors close-by";
  static String selectDoc = "Doctor";
  static String nextIsBooking = "Next -- Book an Appointment >";

  // Set an Appointment / Book Appointment
  static String bookingHeader = "Book an Appointment";
  static String bookingNote =
      "Confirm a date and time for your appointment with a general practitioner. Include a note as well";
  static String docLabel = "DOCTOR";
  static String selectedDoctor = "";
  static String serviceLabel = "SERVICE";
  static String serviceTitle = "Medical Officer -- Video Consultation ₱500";
  static String dateandtimeLabel = "DATE AND TIME";
  static String dateandtimeSelection = "Date and Time Picker";
  static String availableDate = "MM DD YYYY";
  static String availableTime = "00:00";
  static String noteLabel = "NOTE";
  static String inputComplaints = "Type your complaints...";
  static String nextIsHealthProfile = "Next -- Health Profile >";

  // Health Profile / Book Appointment
  static String healthprofileHeader = "Health Profile";
  static String hpText =
      "Kindly provide the patient's medical information and history";
  static String consultConcern = "";
  static String hpQ1 = "How long have you felt this way?";
  static String calendrical = "";
  static String hpQ2 = "Do you have any of these symptoms?";
  static String generalSymptomslabel = "General Symptoms";
  static String checkDifficultysleeping = "Difficulty sleeping";
  static String checkFever = "Fever";
  static String checkMoodChanges = "Mood changes";
  static String checkFatigue = "Fatigue / weakness";
  static String checkLossAppetite = "Loss of appetite";
  static String checkNightsweats = "Night sweats";
  static String headOrneck = "Head / Neck";
  static String checkCongestions = "Congesitons";
  static String checkEyeRedness = "Eye Redness";
  static String checkLossOfSmell = "Loss of smell";
  static String checkEarPain = "Ear pain";
  static String checkHeadaches = "Headaches";
  static String checkLossOfTaste = "Loss of taste";
  static String hpQ3 = "Are you currently taking any medications?";
  static String hpQ3text1 =
      "Please consider any medications you are currently taking, including those taken in a regular basis.";
  static String checkYes = "Yes";
  static String checkNo = "No";
  static String hpQ3text2 = "List medications below:";
  static String inputMedication = "";
  static String listHowLong = "How long?";
  static String addInputMedication = "Add new medication";
  static String hpQ4 = "Are you allergic to any drugs?";
  static String hpQ5 =
      "Do you have any medical conditions? Example: High Cholesterol, Insomnia, Asthma";
  static String hpQ6 =
      "Have you had any surgeries? Examples: Appendectomy, Tonsillectomy, Knee replacement.";
  static String hpQ7 =
      "Has anyone in your family had any medical conditions? Please only include first-degree relatives (parents, siblings, and children)";
  static String nextIsReviewProfile = "Next -- Review Profile >";

  // Review Profile / Display Answers
  static String reviewprofileHeader = "Review Profile";
  static String reviewprofileText =
      "Mase sure all details are correct as these information would aid the Medical Practitioner";
  static String rpQ1 = "How long have you felt this way?";
  static String answerhpQ1 = "";
  static String change = "Change";
  static String answer = "";
}

class TelemedImage {
  static String doctorImage = "assets/images/logo.png";
  static String clockImage = "assets/images/ic_farm.png";
}
