import 'dart:io';

import 'package:intl/intl.dart';

class TelemedSettings {
  static String appName = "Telemed";
  static String initialCountryCode = "PH";
  static String CONTANT_UNAUTHENTICATED = "Unauthenticated";

  // Server details
  // static String authority = "192.168.22.1";
  static String authority =
      "d3a7-2001-4451-874c-6900-b5af-264d-e00-999c.ngrok-free.app";
  static String unencodedPath = "telemed/public/api";

  //

  // Reason for visit ID's
  static int newHealthConcern = 1;
  static int routineCheckUp = 2;
  static int prescriptionsOrRefills = 3;
  static int genMentalHealthConcerns = 4;
  static int otherMedicalReasons = 5;

  //

  static String costOfVideoConsultation = "₱1000";

  static int doctorId = 2;
  static int patientId = 3;

  static String darkMode = "darkMode";
  static String lightMode = "lightMode";

  static DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  static DateFormat timeFormat = DateFormat("h:mm a");
  static DateFormat timeDateFormat = DateFormat("h:mm:ss a dd-MM-yyyy");
  static DateFormat timeDateFormatDateFirst =
      DateFormat("dd-MM-yyyy h:mm:ss a");
  static DateTime startDate = DateTime(1970);
  static DateTime endDate = DateTime.now().add(const Duration(days: 3660));

  static NumberFormat decimalPatternDisplayFormat =
      NumberFormat.decimalPattern('en_IN');

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
  static String alertTitle = "Alert";
  static String alertMessageNavToMessages =
      "Please navigate to the messages screen to continue the conversation.";
  static String unauthenticatedAccessTitle = "Unauthenticated Access";
  static String unauthenticatedAccessMessage =
      "Sorry. This seems like an unauthenticated access. Please verify yourself by signing in again.";
  static String loading = "Loading";
  static String pleaseWait = "Please wait...";
  static String patient = "Patient";
  static String doctor = "Doctor";
  static String signIn = "Sign In";
  static String signUp = "Sign Up";
  static String signOut = "Sign out";
  static String areYouSureYouWantToSignOut =
      "Are you sure you want to sign out?";
  static String cancel = "Cancel";
  static String ok = "ok";
  static String fail = "fail";
  static String success = "success";
  static String deleteSuccessful = "deleteSuccessful";
  static String close = "close";
  static String yearsOld = "years old";
  static String payment = "Payment";
  static String textSize = "TextSize";
  static String date = "Date";
  static String pwdExpirationDate = "pwd expiration date";
  static String time = "Time";
  static String transactions = "Transactions";
  static String videoConsultationFee = "Video consultation fee";
  static String symptoms = "Symptoms";
  static String add = "Add";
  static String medications = "Medications";
  static String drugAllergies = "Drug allergies";
  static String medicalConditions = "Medical conditions";
  static String familyMedicalConditions = "Family medical conditions";
  static String surgeries = "Surgeries";
  static String reminders = "Reminders";
  static String dontForgetSchedule =
      "Don't forget schedule for upcoming appointment";

  // Patient Registration
  static String createAccount = "Create an account";
  static String pleaseEnterText = "Please enter text";
  static String pleaseEnterNumber = "Please enter a number";
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
  static String doctorsPhoneNumber = "Doctor's Phone Number";
  static String phoneNote =
      "By providing your mobile number you give us permission to contact you via text.";
  static String medicalSchoolOfGraduation = "Medical school of graduation";
  static String medicalSchoolOfGraduationHint =
      "Please list them in the following format:\nSto Tomas - 2023\nLa Salle - 2024";
  static String complaints = "Complaints";
  static String patientComplaintsHint =
      "Example: Severe headache, high fever, running nose";
  static String healthInsurance = "Health Insurance";
  static String hInsurance =
      "Search for your heath insurance provider to see if you're cover";
  static String search = "Search";
  static String insuranceEx = "e.g PhilHealth, MediCard etc.";
  static String save = "Save";
  static String skipInsurance = "Skip Insurance";
  static String skipIns = "You can see a doctor without insurance";
  static String qualifications = "Qualifications";
  static String speciality = "Speciality";
  static String boardCertified = "Board certified";
  static String pdeaRegistrationNumber = "PDEA Registration Number";
  static String currentMedicalLicenseNumber = "Current Medical License Number";
  static String dateIssued = "Date issued";
  static String view = "View";
  static String settings = "Settings";
  static String configureYourAccount = "Configure your account";
  static String helpAndSupport = "Help and Support";
  static String logOut = "Help and Support";
  static String securelyLogOut = "Securely logout of the site";
  static String healthProfile = "Health profile";

  // Home
  static String greetings = "Greetings";
  static String supp = "What do you want to do today?";
  static String upcomingAppointments = "Upcoming Appointments";
  static String todaysAppointments = "Today's Appointments";
  static String scheduledAppointments =
      "You currently don't have an appointment scheduled."; //this will direct the patient user to the Calendar only if they have an appointment booked. if not, they will direct to booking page
  static String bookNow = "Book an appointment today!";
  static String bookAnAppointment = "Book an appointment";
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
  static String messages = "Messages";
  static String patientProfile = "Patient profile";
  static String profile = "Profile";

  // Book Appointment
  static String appointments = "Appointments";
  static String patientLocation = "What is the patient's current location?";
  static String patientConnection =
      "This would help us connect you with the best available licensed Doctor for that location on our platform.";
  static String reasonOfVisit = "Reason for your visit";
  static String whatIsReasonOfVisit = "What’s the main reason for your visit?";
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
  static String hpQ3text2 = "List medications here";
  static String hpQ3text2Hint = "Paracetamol 3mg = 0-0-1";
  static String inputMedication = "";
  static String listHowLong = "How long?";
  static String typeComplaints = "Type your complaints";
  static String typeDrugComplaintsHint =
      "I am allergic to paracetamol because my body is already cold.";
  static String typeMedicalConditionsComplaintsHint =
      "I am suffering from insomnia since teenage.";
  static String typeFamilyMedicalConditionsComplaintsHint =
      "My grandfather suffers from insomnia.";
  static String typeSurgeriesComplaintsHint =
      "I've had a heart surgery in the last year. So, treat me with caution.";
  static String addInputMedication = "Add new medication";
  static String hpQ4 = "Are you allergic to any drugs?";
  static String hpQ5 =
      "Do you have any medical conditions? Example: High Cholesterol, Insomnia, Asthma";
  static String hpQ6 =
      "Have you had any surgeries? Examples: Appendectomy, Tonsillectomy, Knee replacement.";
  static String hpQ7 =
      "Has anyone in your family had any medical conditions? Please only include first-degree relatives (parents, siblings, and children)";
  static String reviewProfile = "Review Profile";

  // Review Profile / Display Answers
  static String reviewprofileHeader = "Review Profile";
  static String reviewprofileText =
      "Mase sure all details are correct as these information would aid the Medical Practitioner";
  static String rpQ1 = "How long have you felt this way?";
  static String answerhpQ1 = "";
  static String change = "Change";
  static String answer = "";
  static String pwdIDnumber = "PWD ID No.";
  static String pwdIDExpirationDate = "PWD No. Expiration Date";
  static String paymentReferenceNumber = "Payment reference Number";
  static String appointmentConfirmed = "Appointment confirmed";
  static String at = "At";
  static String appointmentConfirmationDialogMessage =
      "Your upcoming virtual meeting has been scheduled with ";
}

class TelemedImage {
  static String doctorImage = "assets/images/doctor.png";
  static String clockImage = "assets/images/clock.png";
  static String logoImage = "assets/images/logo.png";
}

enum TelemedTextSizeEnum {
  small,
  medium,
  large,
}

extension TelemedTextSizeExtension on TelemedTextSizeEnum {
  String get name {
    switch (this) {
      case TelemedTextSizeEnum.small:
        return "Small";
      case TelemedTextSizeEnum.medium:
        return "Medium";
      case TelemedTextSizeEnum.large:
        return "Large";
    }
  }
}
