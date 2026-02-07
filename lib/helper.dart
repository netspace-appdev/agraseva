import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;


class AppText{
  static const String brandName="KSDPL";

  static const String home="Home";
  static const String category="Category";
  static const String all="All";
  static const String manageVacancy="Manage Vacancy";
  static const String manageInsuranceLeads="Manage Insurance Leads";
  static const String UploadDoc="Upload Document";
  static const String UploadedDoc="Uploaded Document";
  static const String cart="Cart";
  static const String sc_home="Science Home";
  static const String search="Search";
  static const String viewAll="View All";
  static const String latestProduct="Latest Product";
  static const String noData="No Data Found";
  static const String products="Products";
  static const String mobileNumber="Mobile Number";
  static const String password="Password";
  static const String submit="Submit";
  static const String adharVarify="Aadhar Verify";
  static const String phoneNumberRequired="Mobile number is required";
  static const String enterValidPhone="Enter a valid 10-digit phone number";
  static const String passwordRequired="Password is required";
  static const String password6characters="'Password must be at least 6 characters";
  static const String somethingWentWrong="Something went wrong";
  static const String lenderPanel="Lender Panel";
  static const String signIn="Sign in";
  static const String registration="Registration";

  static const String employeeID="Employee ID*";
  static const String lenderName="Lender Name*";
  static const String contactNo="Contact No. (Use for Login)*";
  static const String whatsappNo="Whatsapp No.*";
  static const String whatsappNoStar="Whatsapp No.";
  static const String contactNo2="Contact No";

  static const String email="Email*";
  static const String passwordStar="Password*";
  static const String alreadyRegistered="Are you already registered? ";
  static const String login="Login";
  static const String dontHaveAccount ="Don't have an account? ";
  static const String registerHere ="Register here";

  static const String bank ="Bank";
  static const String branch ="Branch";
  static const String roleLevel="Role Level*";
  static const String role ="Role*";
  static const String functionalSupervisorName ="Functional Supervisor Name*";
  static const String functionalSupervisorMobile ="Functional Supervisor Mobile No";
  static const String functionalSupervisorEmail ="Functional Supervisor Email";
  static const String administrativeSupervisorName ="Administrative Supervisor Name*";
  static const String administrativeSupervisorMobile="Administrative Supervisor Mobile No";
  static const String administrativeSupervisorEmail ="Administrative Supervisor Email";
  static const String agreeTerms="Agree with the terms and conditions ?";
  static const String termsConditions ="Terms and conditions";
  static const String underReview ="Add Under Review";
  static const String updateDisburseHistory ="Update Disburse History";
  static const String appSaction ="Add Loan Sanction";
 // static const String sanctionAmount ="Sanction Amount";
  static const String hintsanctionAmount ="Enter Sanction Amount";

  static const String unknownFunctionalSupervisor ="Unknown Functional Supervisor";
  static const String unknownAdminSupervisor ="Unknown Admin Supervisor";
  static const String unknownContact ="Unknown Contact Number";
  static const String unknownEmail ="Unknown Emailr";
  static const String noTokenFound ="No token found. Please login again.";
  static const String noOptions ="No options available";
  static const String weakPassword ="Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, and a special character.";
  static const String medium ="Medium";
  static const String strong ="Strong";
  static const String validEmailWarning ="Please enter a valid official email address (e.g., user@company.com). Public domains like gmail.com or yahoo.com are not allowed";
  static const String iAgreeTC ="I agree to the Terms and Conditions";
  static const String companyHeader ="KSDPL";
  static const String registrationsuccessfulMsg ="Lender registration successful. Please wait for verification.";
  static const String ok ="Ok";
  static const String message ="Message";
  static const String pleaseSelectBank ="Please select a bank";
  static const String pleaseSelectBranch ="Please select a branch";
  static const String pleaseSelectRoleLevel ="Please select a role level";
  static const String pleaseSelectRole ="Please select a role";
  static const String pleaseSelectFunctionalSupervisor ="Please select a Functional Supervisor";
  static const String pleaseSelectFuncSupervisor ="Please select a Functional Supervisor";
  static const String pleaseSelectAdminSupervisor ="Please select a Admin Supervisor";
  static const String pleaseSelectTnC ="Please select Terms and conditions";
  static const String phoneInUse ="This phone number is already in use";
  static const String uploaddoc ="Please upload a document";

  static const String manageProfile ="Manage Expense";
  static const String manageSenorList ="Senior List";
  static const String editProfile ="Edit Profile";
  static const String changePassword ="Change Password";
  static const String changePhoneNum ="Change Phone Number";
  static const String changeEmail ="Change Email";
  static const String lenderCode ="Lender Code";
  static const String oldPassword ="Old Password*";
  static const String newPassword ="New Password*";
  static const String confirmPassword ="Confirm Password*";
  static const String passwordMustBeSame ="New password and Confirm password must be same";
  static const String oldPasswordRequired="Old password is required";
  static const String newPasswordRequired="New password is required";
  static const String confirmPasswordRequired="Confirm password is required";
  static const String lightTheme="Light Theme";
  static const String darkTheme="Dark Theme";
  static const String systemTheme="System Theme";
  static const String changeTheme="Change Theme";
  static const String pleaseSelectproduct ="Please select a product";

  static const String sNo="S No.";
  static const String branchName="Branch Name";
  static const String IFSC="IFSC";
  static const String phoneNo="Phone No.";
  static const String alternatePhoneNo="Alternate Contact No.";
  static const String mobNo="Mobile No.";
  static const String eml="Email Address";
  static const String state="State";
  static const String district="District";
  static const String city="City";
  static const String mICRCode="MICR Code";
  static const String zipCode="Zip Code";
  static const String address="Address";
  static const String branchCode="Branch Code";
  static const String noDataFound="No data found";
  static const String clearFilters="Clear Filters";
  static const String clearSort="Clear Sort";
  static const String showAllColumns="Show all columns";
  static const String hideBranchNameColumn="Hide Branch Name Column";
  static const String sortBrNameAsc="Sort by Branch Name ascending";
  static const String sortBrNameDsc="Sort by Branch Name descending";
  static const String sort="Sort";
  static const String ascending="ascending";
  static const String descending="descending";
  static const String hide="Hide";
  static const String column="Column";

  static const String manageBranches="Manage Branches";
  static const String branchList="Branch List";
  static const String skillRequired="Skill Required";
  static const String manageEnforcement="Manage Enforcement";
  static const String uploadCommonTask="Upload Common Task";
  static const String uctList="Upload Common Task List";
  static const String uploadExcel="Upload Excel";
  static const String noFileSelected="No file selected";
  static const String chooseExcel="Please choose an Excel file (.xlsx, .xls) to upload.";
  static const String selectedFile="Selected File:";
  static const String noFileChosen="No File Chosen";
  static const String chooseFile="Chosen File";
  static const String preview="Preview";
  static const String uploadImage="Upload Image";
  static const String EmployeeadharNo="Employee Aadhar No";
  static const String enterEmployeeadharNo="Enter Employee Aadhar No";

  static const String addressEmployeeadharNo="Address As Per Aadhar";
  static const String enterAddressEmployeeadharNo="Enter Address As Per Aadhar";

  static const String enterAccDetails="Enter your account details below";
  static const String createNewAccount="Create new account";
  static const String forgotYourPassword="Forgot your password?";
  static const String dashboard="Dashboard";
  static const String companyProfile="Company Profile";
  static const String companyName="Company Name";
  static const String founderName="Founder Name";
  static const String ceoName="CEO Name";
  static const String tagline="Tagline";
  static const String foundingDate="Founding Date";
  static const String headquartLocation="Headquarters Location";
  static const String emailNoStar="Email";
  static const String phoneNumberNoStar="Phone Number";
  static const String UniversityName="University Name";
  static const String mobilenumber="Mobile Number";
  static const String whatsappNoNoStar="WhatsApp Number";
  static const String YearofPassing="Year of Passing";
  static const String fax="Fax";
  static const String InstitutionName="Institution Name";
  static const String website="Website URL";
  static const String linkedIn="LinkedIn";
  static const String facebook="Facebook";
  static const String twitter="Twitter";
  static const String companyAddress="Company Address";
  static const String gstNumber="GST Number";
  static const String panNumber="PAN Number";
  static const String cinNumber="CIN Number";
  static const String mapIntegration="Map Integration (Embed Code)";
  static const String privacyPolicy="Privacy Policy";
  static const String tncController="Terms and Conditions";
  static const String companyLogo="Company Logo";

  static const String leads="Manage Leads";
  static const String leadList="Lead List";
  static const String myProfile="My Profile";
  static const String logout="Logout";
  static const String notification="Notification";
  static const String percentageRequired="Percentage is required";
  static const String loanNumberRequired="Loan Application Number  is required";
  static const String leadDetails="Lead Details";
  static const String addLead="Add Lead";
  static const String fullName="Full Name";
  static const String Specialization="Specialization";
  static const String enterFullName="Enter Full Name";
  static const String dateOfBirth="Date of Birth";
  static const String enterPhNumber="Enter Phone Number";
  static const String enterMBmber="Enter Mobile Number";
  static const String lar="Loan Amount Requested";
  static const String enterLar="Enter Loan Amount Requested";
  static const String enterEA="Enter Email Address";
  static const String aadhar="Aadhar";
  static const String enterAadhar="Enter Aadhar";
  static const String enterPan="Enter PAN";
  static const String streetAdd="Street Address";
  static const String enterStreetAdd="Enter Street Address";
  static const String enterZipCode="Enter Zip Code";
  static const String nationality="Nationality";
  static const String enterNationality="Nationality";
  static const String employerName="Employer Name";
  static const String employerType="Employer Type";
  static const String enterEmployerName="Enter Employer Name";
  static const String monIncome="Monthly Income(Gross Income)";
  static const String enterMonIncome="Enter Monthly Income";
  static const String addIncome="Additional source of income (Monthly)"; // "Additional source of income" needs to be changed.,The label should say "Additional source of income (Monthly)"
  static const String enterAddIncome="Enter Additional source of income";
  static const String brLoc="Branch Location";
  static const String productTypeInt="KSDPL Product";//\n(Product Type Interested)
  static const String enterBrLoc="Enter Branch Location";
  static const String conName="Connector Name";
  static const String conMob="Connector Mobile";
  static const String conShare="Connector Share %";
  static const String enterConName="Enter Connector Name";
  static const String hintContact="Enter Contact No";
  static const String enterConMob="Enter Connector Mobile";
  static const String enterConShare="Enter Connector Share %";
  static const String mmddyyyy="mm/dd/yyyy";
  static const String yyyyMmDd="YYYY-MM-DD";
  static const String preferredBank="Preferred Bank for Loan";
  static const String connector="Connector";
  static const String gender="Gender";
  static const String existingRelationship="Existing Relationship with Bank?";
  static const String currEmpSt="Current Employement Status";
  static const String employed="Employed";
  static const String salaried="Salaried";
  static const String selfEmployed="Self-Employed";
  static const String unemployed="Unemployed";
  static const String retired="Retired";
  static const String student="Student";
  static const String upcomingBirthdays="🎉 Upcoming Birthdays 🎉";
  static const String sendWishes="Send Wishes";
  static const String noBirhday="No upcoming birthdays";
  static const String loanAppl="Loan Application";
  static const String coApplDetails="Co-Applicant Details";
  static const String fathersName="Father's Full Name";
  static const String enterFathersName = "Enter Father's Name";
  static const String qualification = "Qualification";
  static const String enterQualification = "Enter Qualification";
  static const String maritalStatus = "Marital Status";
  static const String status = "Status";
  static const String enterMaritalStatus = "Enter Marital Status";
  static const String employmentStatus = "Employment Status";
  static const String enterEmploymentStatus = "Enter Employment Status";
  static const String occupation = "Occupation";
  static const String enterOccupation = "Enter Occupation";
  static const String occupationSector = "Occupation Sector";
  static const String enterOccupationSector = "Enter Occupation Sector";
  static const String whatsappMsg = "Hello! We belong to KSDPL...";
  static const String couldNotCall = "Could not make a call";
  static const String couldNotWA = "Could not open WhatsApp";
  static const String couldNotMsg = "Could not open Messages";
  static const String openPollFilter = "Open Poll";
  static const String loanExchangeHub = "Loan Exchange Hub";
  static const String openPollLeads = "Open Poll Leads";
  static const String loanExchangeLeads = "Loan Exchange Leads";
  static const String followup = "Follow Up";
  static const String history = "History";
  static const String disburseHistory = "Disburse History";
  static const String details = "Details";
  static const String openPoll = "Open Poll";
  static const String leh = "LEH";
  static const String moveLeh = "Move to Loan Exchange Hub";
  static const String enterLeh = "Enter percentage for LEH";
  static const String enterPercentage = "Enter percentage";
  static const String interested = "Interested";
  static const String notInterested = "Not Interested";
  static const String doable = "Doable";
  static const String notDoable = "Not Doable";
  static const String leadHistory = "Lead History";
  static const String setFollowup = "Set Follow Up";
  static const String selectDate = "Select Date";
  static const String selectTime = "Select Time";
  static const String enterDetails = "Enter Follow-up details";
  static const String addFeedback = "Add Feedback";
  static const String addExpenses = "Add Expense";
  static const String vacancyList = "Vacancy List";
  static const String insuranceLeadsList = "Insurance Leads";
  static const String illustrationsList = "Illustrations Leads";
  static const String editExpenses = "Edit Expense";
  static const String viewExpenses = "View Expense";
  static const String callFeedback = "Call Feedback / Follow up Note";
  static const String leadFeedback = "Lead Feedback";
  static const String enterCallFeedback = "Enter the details";
  static const String enterLeadFeedback = "Enter Lead Feedback";
  static const String addFeedbackFirst = "Add feedback first";
  static const String settings = "Settings";
  static const String aboutUs = "About Us";
  static const String callReminder = "Call Reminder";
  static const String addFAndF = "Add Feedback & Followup";
  static const String noReminder = "No Reminder";
  static const String addFollowUp = "Add Follow-up";
  static const String followupNote = "Followup Note";
  static const String addDetailsFirst = "Add details first";
  static const String upcomingFollowUp = "Upcoming Follow up";
  static const String campaign = "Campaign";
  static const String customdash = "customDash";
  static const String allReminders = "All Reminders";
  static const String fillLeadForm = "Fill Lead form";
  static const String existingLoans = "Existing Loans";
  static const String noOfExistingLoans = "No. of Existing Loans";
  static const String enterExistingLoans = "Enter Existing Loans";
  static const String enterNoOfExistingLoans = "Enter No. of Existing Loans";
  static const String couldntConneect = "Couldn't connect";
  static const String ksdplBr = "KDSPL Branch";
  static const String searchLeads = "Search Leads";
  static const String fromDate = "From Date";
  static const String toDate = "To Date";
  static const String ddmmyyyy = "dd/mm/yyyy";
  static const String searchedLeads = "Searched Leads";
  static const String leadStage = "Lead Stage";
  static const String changeLeadStatus = "Change Status";
  static const String personInformation = "Person Information";
  static const String applFNmae = "Applicant's Full Name";
  static const String Academics = "Academics";
  static const String workExperience = "Work Experience";
  static const String experience = "Work Experience";
  static const String iAmFresher = "I am a fresher (No prior work experience)";
  static const String enterCompanyName = "Enter Company Name";
  static const String jobTitle = "Job Title";
  static const String jobRoll = "Job Role";
  static const String enterJobTitle = "Enter Job Title";

  static const String department = "Department";
  static const String enterDepartment = "Enter Department";

  static const String endDate = "End Date";
  static const String salaryRange = "Salary Range";

  static const String employmentType = "Employment Type";
  static const String selectEmploymentType = "Select Employment Type";

  static const String enterCompanyAddress = "Enter Company Address";

  static const String reasonForLeaving = "Reason For Leaving";
  static const String enterReasonForLeaving = "Enter Reason For Leaving";

  static const String lastDrawnSalary = "Last Drawn Salary";
  static const String enterLastDrawnSalary = "Enter Last Drawn Salary";

  static const String responsibilities = "Responsibilities";
  static const String enterResponsibilities = "Enter Responsibilities";

  static const String uploadDocuments = "Upload Documents";
  static const String uploadDocNote = "Only PDF files. Max 2 MB";

  static const String dsaCode = "DSA Code";
  static const String enterDsaCode = "Enter DSA Code";
  static const String loanApplicationNo = "Loan Application No";
  static const String loanApplicationDetails = "Loan Application Details";
  static const String enterLoanApplicationNo = "Enter Loan Application No";
  static const String bankNostar ="Bank";
  static const String brNostar ="Branch";
  static const String selectBank = "Select your Bank name";
  static const String selectBranch = "Select your Branch";
  static const String loanType = "Type of Loan";
  static const String selectLoanType = "Select your Loan Type";
  static const String panCardNo = "PAN Card Number";
  static const String enterPanCardNo = "Enter PAN Card Number";
  static const String aadharCardNo = "Aadhar Card Number";
  static const String enterAadharCardNo = "Enter Aadhar Card Number";
  static const String loanAmountApplied = "Loan Amount Applied";
  static const String enterLoanAmountApplied = "Enter Loan Amount Applied";
  static const String dsaStaffName = "DSA Staff Name";
  static const String enterDsaStaffName = "Enter DSA Staff Name";
  static const String uniqueLeadNumber = "Unique Lead Number";
  static const String leadName = "Lead Name";
  static const String enterUniqueLeadNumber = "Enter Unique Lead Number";
  static const String enterLeadName = "Enter Lead Name";
  static const String channel = "Channel";
  static const String channelName = "Channel Name";
  static const String selectChannel = "Select your Channel";
  static const String channelCode = "Channel Code";
  static const String enterChannelCode = "Enter Channel Code";
  static const String processingFee = "Processing Fee Against Loan Sanction Amount(%)";
  static const String processingFee2= "Processing Fee";
  static const String enterProcessingFee = "Enter Processing Fee";
  static const String chqDdSlipNo = "CHQ/DD Slip No";
  static const String enterChqDdSlipNo = "Enter CHQ/DD Slip No";
  static const String processingFeeDate = "Processing Fee Date";
  static const String enterProcessingFeeDate = "mm/dd/yyyy";
  static const String loanPurpose = "Loan Purpose";
  static const String enterLoanPurpose = "Enter Loan Purpose";
  static const String scheme = "Scheme";
  static const String enterScheme = "Enter Scheme";
  static const String repaymentType = "Repayment Type";
  static const String enterRepaymentType = "Enter Repayment Type";
  static const String loanTenure = "Loan Tenure (Years)";
  static const String enterLoanTenure = "Enter Loan Tenure in Years";
  static const String monthlyInstallment = "Monthly Installment";
  static const String enterMonthlyInstallment = "Enter Monthly Installment";
  static const String previousLoanApplied = "Previous Loan Applied";

  static const String loanRoi = "Loan ROI";
  static const String enterLoanRoi = "Enter Loan ROI";

  static const String applicantEmployerDetails = "Applicant's Employer Details";
  static const String organizationName = "Organization Name";
  static const String enterOrganizationName = "Enter Organization Name";
  static const String ownershipType = "Ownership Type";
  static const String selectOwnershipType = "Select Ownership Type";
  static const String natureOfBusiness = "Nature of Business";
  static const String enterNatureOfBusiness = "Enter Nature of Business";
  static const String staffStrength = "Staff Strength";
  static const String enterStaffStrength = "Enter Staff Strength";
  static const String salaryDate = "Salary Date";
  static const String dateOfSal = "Date of Salary";
  static const String enterSalaryDate = "mm/dd/yyyy";
  static const String presentAddress = "Present Address";
  static const String houseFlatNo = "House/Flat No";
  static const String enterHouseFlatNo = "Enter House/Flat No";
  static const String buildingNo = "Building No";
  static const String enterBuildingNo = "Enter Building No";
  static const String societyName = "Society Name";
  static const String enterSocietyName = "Enter Society Name";
  static const String locality = "Locality";
  static const String enterLocality = "Enter Locality";
  static const String streetName = "Street Name";
  static const String enterStreetName = "Enter Street Name";
  static const String pinCode = "Pin Code";
  static const String enterPinCode = "Enter Pin Code";
  static const String selectState = "Select your State";
  static const String selectDistrict = "Select your District";
  static const String selectCity = "Select your City";
  static const String taluka = "Taluka";
  static const String enterTaluka = "Enter Taluka";
  static const String country = "Country";
  static const String presentAdd = "Present Address";
  static const String permanentAdd = "Permanent Address";
  static const String officeAdd = "Office Address";
  static const String coApplicantDetails = "Co-Applicant Details";
  static const String applicantDetails = "Applicant Details";
  static const String propertyDetails = "Property Details";
  static const String chargeDetails = "Charge Details";
  static const String propertyId = "Property ID";
  static const String enterPropertyId = "Enter Property ID";
  static const String surveyNo = "Survey No";
  static const String enterSurveyNo = "Enter Survey No";
  static const String finalPlotNo = "Final Plot No";
  static const String enterFinalPlotNo = "Enter Final Plot No";
  static const String blockNo = "Block No";
  static const String enterBlockNo = "Enter Block No";
  static const String socBuildName = "Society/Building Name";
  static const String familyMember = "Family Member";
  static const String name = "Name";

  static const String relWithAppl = "Relation with Applicant ";
  static const String enterRelWithAppl = "Enter Relation with Applicant";
  static const String dependent = "Dependent ";
  static const String monthlyIncome  = "Monthly Income";
  static const String enterMonthlyIncome = "Enter Monthly Income ";
  static const String EmployedWith = "Employed with";
  static const String enterEmployedWith = "Enter Employed with";

  static const String creditCard = "Credit Card";
  static const String companyBank = "Company Bank";
  static const String enterCompanyBank = "Enter Company Bank";
  static const String cardNumber = "Card Number";
  static const String enterCardNumber = "Enter Card Number";
  static const String havingSince = "Having Since";
  static const String avgMonSpencing = "Average Monthly Spending";
  static const String enterAvgMonSpencing = "Enter Average Monthly Spending";

  static const String financialDetails = "Financial Details";
  static const String grossMonthlySalary = "Gross Monthly Salary";
  static const String grossMonthlyIncome = "Gross Monthly Income";
  static const String enterGrossMonthlySalary = "Enter Gross Monthly Salary";
  static const String enterGrossMonthlyIncome = "Enter Gross Monthly Income";
  static const String netMonthlySalary = "Net Monthly Salary";
  static const String enterNetMonthlySalary = "Enter Net Monthly Salary";
  static const String annualBonus = "Annual Bonus";
  static const String enterAnnualBonus = "Enter Annual Bonus";
  static const String avgMonOvertime = "Average Monthly Overtime";
  static const String enterAvgMonOvertime = "Enter Average Monthly Overtime";
  static const String enterAvgMonCommission = "Enter Average Monthly Commission";
  static const String avgMonCommission = "Average Monthly Commission";
  static const String monthlyPfDeduction = "Monthly PF Deduction";
  static const String enterMonthlyPfDeduction = "Enter Monthly PF Deduction";
  static const String enterOtherMonthlyIncome = "Enter Other Monthly Monthly";
  static const String otherMonthlyIncome = "Other Monthly Income";

  static const String references = "References";
  static const String enterReferenceName = "Enter Reference Name";
  static const String enterReferenceAdd = "Enter Reference Address";
  static const String enterReferencePhone = "Enter Reference Phone";
  static const String enterReferenceMob = "Enter Reference Mobile";
  static const String loanApplicationForm = "Loan Application Form";
  static const String dateOfBirth2="Date of Birth";
  static const String leadMobileNUmber="Lead Mobile Number";
  static const String enterLeadMobileNUmber="Enter Lead Mobile Number";

  static const String bankerDetails="Banker Details";
  static const String bankerName="Banker Name";
  static const String ChargesDetails="Charges Details";
  static const String bankerMobile="Banker Mobile Number";
  static const String bankerWhatsapp="Banker Whatsapp Number";
  static const String bankerEmail="Banker Email Address";

  static const String enterBankerName = "Enter Banker Name";
  static const String enterBankerMobile = "Enter Banker Mobile";
  static const String enterBankerWhatsapp = "Enter Banker Whatsapp";
  static const String enterBankerEmail = "Enter Banker Email";
  static const String manageProducts = "Manage Products";
  static const String managePPT = "View PPT";

  static const String manageCibil = "Manage CIBIL";
  static const String manageService = "Manage Service";

  static const String manageTutorial = "Tutorial";


  ///product
  static const String addProduct = "Add Product";
  static const String collateralSecurityExcluded = "Prime Security Excluded"; //Collateral is Prime now
  static const String enterCollateralSecurityExcluded = "Enter Prime Security Excluded";

  static const String profileExcluded = "Profile Excluded";
  static const String Profile = "Profile";
  static const String enterProfileExcluded = "Enter Profile Excluded";

  static const String ageLimitEarningApplicants = "Age at the time of loan maturity (earning applicant)"; //"Age limit earning applicant" should be changed to "Age at the time of loan maturity (earning applicant)".
  static const String enterAgeLimitEarningApplicants = "Enter Age ge at the time of loan maturity";
  static const String ageLimitNonEarningCoApplicant = "Age Limit Non-Earning Co-Applicant";
  static const String maxAgeLimitNonEarningCoApplicant = "Max Age Limit Non-Earning Co-Applicant";
  static const String enterAgeLimitNonEarningCoApplicant = "Enter Age Limit Non-Earning Co-Applicant";
  static const String minAgeEarningApplicants = "Minimum Age Earning Applicants";
  static const String enterMinAgeEarningApplicants = "Enter Minimum Age Earning Applicants";
  static const String minAgeNonEarningApplicants = "Minimum Age Non-Earning Applicants";
  static const String enterMinAgeNonEarningApplicants = "Enter Minimum Age Non-Earning Applicants";
  static const String minIncomeCriteria = "Minimum Income Criteria (Monthly) (₹)";
  static const String enterMinIncomeCriteria = "Enter Minimum Income Criteria";

  static const String minLoanAmount = "Minimum Loan Amount (₹)";
  static const String enterMinLoanAmount = "Enter Minimum Loan Amount";
  static const String maxLoanAmount = "Maximum Loan Amount (₹)";
  static const String enterMaxLoanAmount = "Maximum Loan Amount";

  static const String profitPercentage = "Profit Percentage";
  static const String eligibleProfitPercent = "Eligible Profit Percent (%)";
  static const String eligibleProfitForAppraisalIncome = "Eligible Profit for appraisal income (%)";
  static const String enterEligibleProfitPercent = "Enter Eligible Profit Percent";
  static const String enterProfitPercentage = "Enter Profit Percentage";
  static const String minCibil = "Minimum CIBIL";
  static const String enterMinCibil = "Enter Minimum CIBIL";
  static const String minTenor = "Minimum Tenor (Years)";
  static const String enterMinTenor = "Enter Minimum Tenor";
  static const String maxTenor = "Maximum Tenor (Years)";
  static const String enterMaxTenor = "Enter Maximum Tenor";

  static const String minRoi = "Minimum ROI (%)";
  static const String enterMinRoi = "Enter Minimum ROI";
  static const String maxRoi = "Maximum ROI (%)";
  static const String enterMaxRoi = "Enter Maximum ROI";

  static const String maxTenorEligibilityCriteria = "Maximum Tenor Eligibility Criteria";
  static const String ageAtMaturity = "Age at Maturity";
  static const String ageAtMaturityNonEarningApplicants = "Age at Maturity (Non-earning Applicants)";
  static const String  enterMaxTenorEligibilityCriteria = "EnterMaximum Tenor Eligibility Criteria";
  static const String enterAgeAtMaturity = "EnterMaximum Age at Maturity";

  static const String geoLimit = "Geo Limit (KM)";
  static const String enterGeoLimit = "Enter Geo Limit";

  static const String negativeProfiles = "Negative Profiles";
  static const String negativeProfilesExcluded = "Negative Profiles (Excluded)";
  static const String enterNegativeProfiles = "Enter Negative Profiles";
  static const String negativeProfilesHint = "Type & press Enter to add";
  static const String negativeAreas = "Negative Areas for security offered";

  static const String minPropertyValue = "Minimum Property Value (₹)";
  static const String enterMinPropertyValue = "Enter Minimum Property Value";
  static const String maxIir = "Maximum IIR (%)";
  static const String enterMaxIir = "Enter Maximum IIR";
  static const String maxFoir = "Maximum FOIR (%)";
  static const String enterMaxFoir = "Enter Maximum FOIR";
  static const String maxLtv = "Maximum LTV (%)";
  static const String enterMaxLtv = "Enter Maximum LTV";

  static const String legalFee = "Legal Vetting Charges (in ₹)";
  static const String enterLegalFee = "EnterLegal Vetting Charges";
  static const String technicalFee = "Technical Inspection Charges (in ₹)";
  static const String enterTechnicalFee = "EnterTechnical Inspection Charges";
  static const String adminFee = "Admin Fee Against Loan Sanction Amount (%)";
  static const String enterAdminFee = "Enter Admin Fee";
  static const String foreclosureCharges = "Foreclosure Charges against the principal outstanding (%)";
  static const String enterForeclosureCharges = "Enter Foreclosure Charges";
  static const String otherCharges = "Other Charges (₹)";
  static const String enterOtherCharges = "Enter Other Charges";
  static const String stampDuty = "Stamp Duty Against Loan Sanction Amount(%)";
  static const String tampDuty = "Stamp Duty";
  static const String enterStampDuty = "Enter Stamp Duty";

  static const String tsrYears = "Title Search Report (TSR) Years";
  static const String enterTsrYears = "Enter TSR Charges";

  static const String tsrCharges = "Title Search Report (TSR) - Legal Charges (₹)";
  static const String enterTsrCharges = "Enter TSR Legal Charges";
  static const String valuationCharges = "Valuation Charges (₹)";
  static const String enterValuationCharges = "Enter Valuation Charges";

  static const String ksdplProduct = "KSDPL Product";
  static const String selectKsdplProduct = "Select KSDPL Product";

  static const String productValidateFrom = "Product Validate From (If Festival Specific)";
  static const String productValidateTo = "Product Validate To (If Festival Specific)";

  static const String maxTat = "Maximum TAT from login to disbursement (Day)";
  static const String enterMaxTat = "Enter Maximum TAT";

  static const String additionalDocuments = "Product Specific Additional Documents";
  static const String documentDescriptionsHint = "Type and press Enter to add";

  static const String productDescriptions = "Product Descriptions";
  static const String pofileDescriptions = "Descriptions";
  static const String enterProductDescriptions = "Enter Product Descriptions";
  static const String productSegment = "Product Segment";
  static const String enterProductSegment = "Enter Product Segment";
  static const String writeYourContent = "Write your content";
  static const String workLocation = "Work Location";

  static const String prodName = "Product Name";
  static const String selectCustomerCategory = "Customer Category";
  static const String selectCustomerCategoryServied = "Customer Category (Servied)";
  static const String selectCollateralSecurityCategory = "Prime Security Category";
  static const String primeSecurityCategoriesServied = "Prime Security Categories Servied";
  static const String selectIncomeType = "Income Types (Allowed)";
  static const String productName = "Product Name";
  static const String productNameLPP = "Product Name (As per the lenders product policy) ";
  static const String enterProductName = "Enter product name";

  static const String noOfDocuments = "No. of Documents";
  static const String enterNoOfDocuments = "Enter No. of Documents";

  static const String showProducts = "Products";
  static const String productDetails = "Product Details";

  static const String editProduct = "Edit Product";
  static const String leadform_camnote = "Lead Form & Cam Note";

  static const String processingCharges = "Processing Charges/IMD (₹)";
  static const String enterProcessingCharges = "Enter Processing Charges";

  static const String processingCharges2 = "Processing Charges (₹)";
  /// cam note
  static const String totalLoanAvaileCibil = "Total Loan Availed On CIBIL (Amount)";
  static const String enterTotalLoanAvaileCibil = "Enter Total Loan Availed";

  static const String totalLiveLoan = "Total Live Loan";
  static const String enterTotalLiveLoan = "Enter Total Live Loan";


  static const String totalLiveLoanAvailedOnCibil = "Total Live Loan Availed on Cibil";
  static const String enterTotalLiveLoanAvailedOnCibil = "Enter Total Live Loan Availed on Cibil";

  static const String cibil = "CIBIL";
  static const String cibilRecord = "CIBIL Record List";
  static const String enterCibilScore = "Enter CIBIL Score";

  static const String totalEmi = "Total EMI";
  static const String enterTotalEmi = "Enter Total EMI";

  static const String emiStoppedBefore = "EMI Stopped On Before This Loan";
  static const String enterEmiStoppedBefore = "Enter Value";

  static const String emiWillContinue = "EMI Will Continue";
  static const String enterEmiWillContinue = "Enter Value";

  static const String totalOverdueCases = "Total Overdue Cases As Per CIBIL";
  static const String enterOverdueCases = "Enter Overdue Cases";

  static const String totalOverdueAmountCibil = "Total Overdue Amount As Per CIBIL";
  static const String totalAmountCibil = "Amount";
  static const String amountToBeRecovered = "Amount To Be Recovered";
  static const String enterOverdueAmountCibil = "Enter Overdue Amount";
  static const String enterAmountCibil = "Enter Amount";

  static const String totalEnquiries = "Total Enquiries Made As Per CIBIL";
  static const String enterTotalEnquiries = "Enter Number of Enquiries";

  static const String loanSegment = "Loan Segment";
  static const String selectLoanSegment = "Select Product Segment";

  static const String loanProduct = "Loan Product";
  static const String selectLoanProduct = "Select Product Segment";

  static const String offeredSecurityType = "Offered Security Type";
  static const String enterSecurityType = "Enter Security Type";

  static const String geoLocationProperty = "Geo Location Of Property";
  static const String enterGeoLocationProperty = "Enter Geo Location Of Property";

  static const String enterLatitude = "Enter Latitude";
  static const String enterLongitude = "Enter Longitude";

  static const String geoLocationResidence = "Geo Location Of Residence";
  static const String enterGeoLocationResidence = "Enter Geo Location Of Residence";

  static const String geoLocationOffice = "Geo Location Of Office";
  static const String enterGeoLocationOffice = "Enter Geo Location Of Office";

  static const String photosOfProperty = "Photos Of Property";
  static const String photosOfResidence = "Photos Of Residence";
  static const String photosOfOffice = "Photos Of Office";

  static const String incomeType = "Income Type";
  static const String pleaseSelectIncomeType = "Please Select";

  static const String earningCustomerAge = "Earning Customer Age";
  static const String cannotupload = "you can not upload photos now";
  static const String enterEarningCustomerAge = "Enter Age";

  static const String nonEarningCustomerAge = "Oldest Non-Earning Customer Age";
  static const String enterNonEarningCustomerAge = "Enter Age";

  static const String totalFamilyIncome = "Total Family Income (Monthly)";
  static const String enterTotalFamilyIncome = "Enter Total Income";

  static const String incomeCanBeConsidered = "Income Can Be Considered (Monthly)";
  static const String enterConsideredIncome = "Enter Considered Income";

  static const String loanAmountRequested = "Loan Amount Requested";
  static const String enterLoanAmountRequested = "Enter Loan Amount";

  static const String loanTenorRequested = "Loan Tenor Requested (In Month)";
  static const String enterLoanTenorRequested = "Enter Tenor in Month";

  static const String rateOfInterest = "Rate of Interest (ROI)";
  static const String enterRateOfInterest = "Enter ROI";

  static const String proposedEmi = "Proposed EMI";
  static const String autoCalculatedProposedEmi = "Auto-calculated Proposed EMI";

  static const String propertyValue = "Property Value As Per Customer";
  static const String enterPropertyValue = "Enter Property Value";

  static const String foir = "FOIR";
  static const String autoCalculatedFoir = "Auto-calculated FOIR";

  static const String ltv = "LTV";
  static const String doc = "Doc1";
  static const String autoCalculatedLtv = "Auto-calculated LTV";
  static const String sectionA = "Section A";
  static const String sectionB = "Section B";
  static const String sectionC = "Section C";
  static const String sectionD = "Section D";

  static const String section1 = "Section 1";
  static const String section2 = "Section 2";
  static const String section4 = "Section 4";
  static const String section3 = "Section 3 ";
  static const String obligation = "OBLIGATION FOR THE PROPOSED LOAN";
  static const String  CIBIL_REPORT_OVERVIEW = "CIBIL REPORT OVERVIEW";
  static const String  LOAN_REPAYMENT_HISTORY = "LOAN REPAYMENT HISTORY";
  static const String loanAccountSummary = "Loan Account Summary";
  static const String LOAN_SYNOPSIS = "LOAN SYNOPSIS";
  static const String downloadCibil = "Download CIBIL";

  static const String todaycall = "Today's Calls";
  static const String convertedToInterested = "Converted to Interested";
  static const String connectedCalls = "Connected Calls";
  static const String todaycallDuration = "Today's Call Duration";
  static const String leadCallYear = "Leads Called in The Year";
  static const String ongoingCallYTD= "Ongoing Call (YTD)";
  static const String employee = "Employee";
  static const String employeeRole = "Employee Role";
  static const String employeeName = "Employee Name";
  static const String GradePercentage = "Grade/Percentage";
  static const String JobRole = "Job Role";
  static const String WorkPlace = "Work Place";
  static const String ManagerName = "Manager Name";
  static const String EducationType = "Education Type";
  static const String TypeHireDate = "Enter Hire Date";

  static const String bankerMobileNo = "Banker Mobile No";
  static const String enterBankerMobileNo = "Enter Banker Mobile No";

  static const String enterWhatsappNo = "Enter WhatsApp No";


  static const String enterEmail = "Enter Email";

  static const String superiorName = "Superior Name";
  static const String enterSuperiorName = "Enter Superior Name";

  static const String superiorMobile = "Superior Mobile Number";
  static const String enterSuperiorMobile = "Enter Superior Mobile Number";

  static const String superiorWhatsapp = "Superior WhatsApp Number";
  static const String enterSuperiorWhatsapp = "Enter Superior WhatsApp Number";

  static const String superiorEmail = "Superior Email Address";
  static const String enterSuperiorEmail = "Enter Superior Email Address";

  static const String fromAmtRange = "From Amount Range (₹)";
  static const String enterFromAmtRange = "Enter From Amount Range";

  static const String toAmtRange = "To Amount Range (₹)";
  static const String enterToAmtRange = "Enter To Amount Range";

  static const String totalOverdueCases2 = "Total Overdue Cases";
  static const String enterTotalOverdueCases = "Enter Total Overdue Cases";

  static const String totalOverdueAmount = "Total Overdue Amount";
  static const String enterTotalOverdueAmount = "Enter Total Overdue Amount";

  static const String totalEnquiries2 = "Total Enquiries";
  static const String enterTotalEnquiries2 = "Enter Total Enquiries";

  static const String source = "Source";
  static const String enterSource = "Enter Source of Additional Income";
  static const String income = "Income";
  static const String enterIncome = "Enter the Income";
  static const String documents = "Documents";
  static const String download = "Download";
  static const String commonDocumentsForAllPproductDocuments = "Common Documents for all product Documents";
  static const String documentsName = "Document Name";
  static const String documentStatusByCustomer = "Document Status by Customer";
  static const String viewProducts = "View Products";
  static const String packageName = "Package Name";
  static const String enterPackageName = "Enter Package Name";
  static const String packageAmount = "Package Amount";
  static const String enterPackageAmount = "Enter Package Amount";
  static const String receivableAmount = "Received Amount";
  static const String enterReceivableAmount = "Enter Received Amount";
  static const String receivableDate = "Received Date";
  static const String receivedDate = "Received Date";

  static const String enterReceivableDate  = "Enter Received Date";

  static const String expenseDate = "Expense Date";
  static const String dateposted = "Date Posted";
  static const String postalcode = "Postal Code";
  static const String noOfVacancies = "No Of Vacancies";
  static const String jobLevel = "Job Level";
  static const String hiringManager = "Hiring Manager";
  static const String HireDate = "Hire Date";
  static const String qualificationRequired = "Qualification Required";
  static const String jobDescription  = "Job Desicription";

  static const String transactionDetails  = "UTR";
  static const String invoiceNumber  = "Invoice Number"; //UTR
  static const String enterTransactionDetails  = "Enter UTR";
  static const String enterinvoiceNumber  = "Enter invoice Number";
  static const String remark  = "Remark";
  static const String invoicePdf  = "Invoice Pdf";
  static const String ReceiptPdf  = "Receipt PDF";
  static const String enterRemark  = "Enter Remark";
  static const String enterZipcode  = "Please Add Zipcode in Step 1";
  static const String forgotMsg  = "We’ve sent a password reset link to your email address. Please check your inbox";
  static const String genAadhar  = "Generate by Aadhar";
  static const String genCibil  = "Generate Cibil";
  static const String genPan  = "Generate by PAN";
  static const String camNoteDetails = "Cam Note Details";
  static const String bankName = "Bank Name";
  static const String softSanctionStatus = "Soft Sanction Status";
  static const String sanctionAmount = "Sanction Amount";
  static const String sanctionTenor = "Sanction Tenor";
  static const String sanctionROI = "Sanction ROI";
  static const String sanctionCondition = "Sanction Condition";
  static const String sanctionProcessingFees = "Sanction Processing Fees";
  static const String sanctionStampDuty = "Sanction Stamp Duty";
  static const String softSanctionDate = "Soft Sanction Date";
  static const String rejectReason = "Reject Reason";
  static const String sanctionEstimatedEMI = "sanction Estimated EMI";
  static const String applicableLegalFee = "Applicable Legal Fee";
  static const String applicableTechnicalFee = "Applicable Technical Fee";
  static const String applicableAdminFee = "Applicable Admin Fee";
  static const String applicableForeclosureCharges = "Applicable Foreclosure Charges";
  static const String applicableOtherCharges = "Applicable Other Charges";
  static const String applicableTSRCharges = "Applicable TSR Charges:";
  static const String applicableValuationCharges = "Applicable Valuation Charges:";
  static const String manageAttendance = "Manage Attendance";
  static const String manageLeaves = "Manage Leaves";
  static const String attendance = "Attendance";
  static const String leaveStatus = "Leave Status";
  static const String reqLeave="Request a Leave";
  static const String leaveType="Leave Type";
  static const String startDate="Start Date";
  static const String enterStartDate="Please Enter Start Date";
  static const String enterEndDate="Please Enter End Date";
  static const String totalDays="Total Days";
  static const String reason="Reason";
  static const String enterReason="Please Enter Reason";
  static const String camNoteSentMessage="You have already sent Cam Note to this bank";
  static const String basicDetails="Basic Details";
  static const String otherDetails="Other Details";
  static const String geolocationPhotos="Geolocation & Photos";
  static const String packageDetails="Package Details";
  static const String sendEmail="Send Email & Whatsapp";
  static const String enterPhone="Please enter phone number";
  static const String pleaseEnterFullName="Please Enter Full Name";
  static const String pleaseEnterEmail="Please Enter Email";
  static const String cncMessage="Lead moved to could not connect successfully";
  static const String robmLogin="RO/BM Login";
  static const String aicLogin="AIC Login";
  static const String submitBasicDetails="Submit Basic Details";
  static const String submitCamnoteDetails="Submit Camnote Details";
  static const String sendEmailToCustomer="Send Email & WhatsApp to Customer";
  static const String reqCibilMsg="Do you want to send an email requesting the CIBIL report?";

  static const String sendCamMsg="Do you want to send a cam note for this bank? If it is sent once, you will not be able to make any changed in it.";

  static const String AdminFeeCharges="Admin Fee Charges";
  static const String ForeclosureCharges="Foreclosure Charges";
  static const String foreclosureChargesPO="Foreclosure Charges against the principal outstanding (%)";
  static const String StampDuty="Stamp Duty (%)";
  static const String LegalVettingCharges="Legal Vetting Charges";
  static const String TechnicalInspectionCharges="Technical Inspection Charges";
  static const String OtherCharges="Other Charges";
  static const String TSRLegalCharges="TSR Legal Charges";
  static const String ValuationCharges="Valuation Charges";
  static const String ProcessingCharges="Processing Charges";
  static const String ProcessingFees = "Processing Fees";
  static const String ChargesDetailshint= "0";
  static const String sanctionDate= "Sanction Date";
  static const String sanctionAmountRequired ="Please enter sanction amount";
  static const String sanctiondateRequired ="Please enter sanction Date";
  static const String partialAmountRequired ="Please enter Partial Amount";
  static const String transuctionDetailRequired ="Please enter Transuction Detail";
  static const String disburedbyRequired ="Please enter Name of Disbursed";
  static const String validateDisbursedBySuperiorName ="Please enter SuperiorName";
  static const String? enterValidAmount="";
  static const String? partialAmountCannotExceed = "The actual amount and disbursement amount should not exceed the sanctioned amount";
  static const String? maxPercentMsg = "The Maximum percentage should not be more than 100 %";
  ///on 12 sep
  static const String totalOverdueCasesAllowed = "Total Overdue Cases (Allowed)";
  //static const String enterTotalOverdueCases = "Enter Total Overdue Cases";

  static const String totalOverdueAmountAllowed = "Total Overdue Amount (Allowed) (₹)";
  //static const String enterTotalOverdueAmount = "Enter Total Overdue Amount";

  static const String totalCibilEnquiriesAllowed = "Total Cibil Enquiries (Allowed)";
  //static const String enterTotalEnquiries = "Enter Total Enquiries";

  static const String minCibilScoreAllowed = "Min Cibil Score (Allowed)";
 // static const String enterMinCibil = "Enter Min CIBIL";

  static const String customerCategoriesServied = "Customer Categories (Servied)";


  static const String commonDocumentsForAllProducts = "Common Documents for all product Documents *";

  //static const String productSegment = "Product Segment*";
  static const String selectProductSegment = "Select Product Segment";

 // static const String productName = "Product Name (As per the lenders product policy) *";
//  static const String enterProductName = "Enter Product Name";

  static const String maxAgeLimitNonEarningApplicants = "Max Age Limit Non-Earning Applicants";
 // static const String enterAgeLimitNonEarningCoApplicant = "Enter Age Limit for Non-Earning Co-Applicant";

  static const String minimumAgeEarningApplicants = "Minimum Age Earning Applicants";
  static const String enterMinimumAgeEarningApplicants = "Enter Minimum Age for Earning Applicants";

  static const String minimumAgeNonEarningApplicants = "Minimum Age Non-Earning Applicants";
  static const String enterMinimumAgeNonEarningApplicants = "Enter Minimum Age for Non-Earning Applicants";

  static const String minimumIncomeCriteria = "Minimum Income Criteria (Monthly) (₹)";
  static const String enterMinimumIncomeCriteria = "Enter Minimum Income Criteria";

  static const String minimumLoanAmount = "Minimum Loan Amount (₹)";
  static const String enterMinimumLoanAmount = "Enter Minimum Loan Amount";

  static const String maximumLoanAmount = "Maximum Loan Amount (₹)";
  static const String enterMaximumLoanAmount = "Enter Maximum Loan Amount";

  static const String eligibleProfitForAppraisal = "Eligible Profit for appraisal income (%)";
 // static const String enterEligibleProfitPercent = "Enter Eligible Profit Percent";

  static const String minimumLoanTenor = "Minimum Laon Tenor (Years)";
  static const String enterMinimumLoanTenor = "Enter Minimum Tenor (Years)";

  static const String maximumLoanTenor = "Maximum Loan Tenor (Years)";
  static const String enterMaximumLoanTenor = "Enter Maximum Tenor (Years)";

  static const String minimumROI = "Minimum ROI (%)";
  static const String enterMinimumROI = "Enter Minimum ROI";

  static const String maximumROI = "Maximum ROI (%)";
  static const String enterMaximumROI = "Enter Maximum ROI";

  static const String ageAtMaturityNonEarning = "Age at Maturity (Non-earning Applicants)";
 // static const String enterAgeAtMaturity = "Enter Age at Maturity";

//  static const String geoLimit = "Geo Limit (Km)";
 // static const String enterGeoLimit = "Enter Geo Limit";

 // static const String processingCharges = "Processing Charges/IMD (₹)";
 // static const String enterProcessingCharges = "Enter Processing Charges (₹)";

  static const String ageAtMaturityEarning = "Age at the time of loan maturity (earning applicant)";
  static const String enterAgeAtMaturityEarning = "Enter Age at the time of loan maturity (earning applicant)";

  static const String negativeAreasForSecurity = "Negative Areas for security offered";
  static const String typeAndPressEnter = "Type and press Enter to add";

  static const String minimumPropertyValue = "Minimum Property Value (₹)";
  static const String enterMinimumPropertyValue = "Enter Minimum Property Value";

  static const String maximumIIR = "Maximum IIR (%)";
  static const String enterMaximumIIR = "Enter Maximum IIR";

  static const String maximumFOIR = "Maximum FOIR (%)";
  static const String enterMaximumFOIR = "Enter Maximum FOIR";

  static const String maximumLTV = "Maximum LTV (%)";
  static const String enterMaximumLTV = "Enter Maximum LTV";

  static const String processingFeeAgainstLoan = "Processing Fee Against Loan Sanction Amount(%)";
 // static const String enterProcessingFee = "Enter Processing Fee";

  static const String legalVettingCharges = "Legal Vetting Charges (₹)";
  static const String enterLegalVettingCharges = "Enter Legal Vetting Charges";

  static const String technicalInspectionFee = "Technical Inspection Fee (₹)";
 // static const String enterTechnicalFee = "Enter Technical Fee";

  static const String adminFeeAgainstLoan = "Admin Fee Against Loan Sanction Amount (%)";
  //static const String enterAdminFee = "Enter Admin Fee";

//  static const String foreclosureCharges = "Foreclosure Charges against the principal outstanding (%)";
 // static const String enterForeclosureCharges = "Enter Foreclosure Charges";

 // static const String otherCharges = "Other Charges (₹)";
 // static const String enterOtherCharges = "Enter Other Charges";

  static const String stampDutyAgainstLoan = "Stamp Duty Against Loan Sanction Amount (%)";
 // static const String enterStampDuty = "Enter Stamp Duty";

//  static const String tsrYears = "Title Search Report (TSR) Years";
 // static const String enterTsrYears = "Enter TSR Years";

  static const String tsrLegalCharges = "Title Search Report (TSR) - Legal Charges (₹)";
  static const String enterTsrLegalCharges = "Enter TSR - Legal Charges";

  //static const String valuationCharges = "Valuation Charges (₹)";
 // static const String enterValuationCharges = "Enter Valuation Charges";

 // static const String productValidateFrom = "Product Validate From (If Festival Specific)";
  static const String productValidateFromHint = "mm/dd/yyyy";

 // static const String productValidateTo = "Product Validate To (If Festival Specific)";
  static const String productValidateToHint = "mm/dd/yyyy";

  static const String maximumTat = "Maximum TAT from login to disbursement (Day)";
  static const String enterMaximumTat = "Enter Maximum TAT (Days)";

  static const String productSpecificAdditionalDocument = "Product Specific Additional Document";
  static const String onlineServiceRecordsList = "Online Service Records List";
  static const String onlineServiceRecords = "Online Service Records";
  static const String  sameAsPhoneNo = " Same As Phone No";

  ///26 Sep
  static const String closedCases = "Closed Cases";
  static const String enterClosedCases = "Enter Closed Cases";

  static const String writtenOffCases = "Written Off Cases";
  static const String enterWrittenOffCases = "Enter Written Off Cases";

  static const String settlementCases = "Settlement Cases";
  static const String enterSettlementCases = "Enter Settlement Cases";

  static const String suitFiledWillfulDefaultCases = "Suit Filed Willful Default Cases";
  static const String enterSuitFiledWillfulDefaultCases = "Enter Suit Filed Willful Default Cases";

  static const String totalSanctionedAmount = "Total Sanctioned Amount";
  static const String enterTotalSanctionedAmount = "Enter Total Sanctioned Amount";

  static const String currentBalance = "Current Balance";
  static const String enterCurrentBalance = "Enter Current Balance";

  static const String closedAmount = "Closed Amount";
  static const String enterClosedAmount = "Enter Closed Amount";

  static const String writtenOffAmount = "Written Off Amount";
  static const String enterWrittenOffAmount = "Enter Written Off Amount";

  static const String settlementAmount = "Settlement Amount";
  static const String enterSettlementAmount = "Enter Settlement Amount";

  static const String suitFiledWillfulDefaultAmount = "Suit Filed Willful Default Amount";
  static const String enterSuitFiledWillfulDefaultAmount = "Enter Suit Filed Willful Default Amount";

  static const String standardCount = "Standard Count";
  static const String enterStandardCount = "Enter Standard Count";


  static const String standardCases = "Standard Cases";
  static const String enterStandardCases = "Enter Standard Cases";

  static const String numberOfDaysPastDueCount = "Number of days past due Count";
  static const String enterNumberOfDaysPastDueCount = "Enter Number of days past due Count";

  static const String lossCount = "Loss Count";
  static const String enterLossCount = "Enter Loss Count";

  static const String lossCases = "Loss Cases";
  static const String enterLossCases = "Enter Loss Cases";

  static const String substandardCount = "Substandard Count";
  static const String enterSubstandardCount = "Enter Substandard Count";

  static const String substandardCases = "Substandard Cases";
  static const String enterSubstandardCases = "Enter Substandard Cases";

  static const String doubtfulCount = "Doubtful Count";
  static const String enterDoubtfulCount = "Enter Doubtful Count";

  static const String doubtfulCases = "Doubtful Cases";
  static const String enterDoubtfulCases = "Enter Doubtful Cases";

  static const String specialMentionAccountCount = "Special Mention account Count";
  static const String enterSpecialMentionAccountCount = "Enter Special Mention account Count";

  static const String npt = "NPT";
  static const String enterNpt = "Enter NPT";

  static const String totalCounts = "Total Counts";
  static const String enterTotalCounts = "Enter Total Counts";

  static const String totalCases = "Total Cases";
  static const String enterTotalCases = "Enter Total Cases";

  static const String currentlyCasesBeingServed = "Currently Cases Being Served";
  static const String enterCurrentlyCasesBeingServed = "Enter Currently Cases Being Served";

  static const String casesToBeForeclosedOnOrBeforeDisb = "Cases To Be Foreclosed On Or Before Disb";
  static const String enterCasesToBeForeclosedOnOrBeforeDisb = "Enter Cases To Be Foreclosed On Or Before Disb";

  static const String casesToBeContenued = "Cases To Be Contenued";
  static const String enterCasesToBeContenued = "Enter Cases To Be Contenued";

  static const String emisOfExistingLiabilities = "EMIs Of Existing Liabilities";
  static const String enterEmisOfExistingLiabilities = "Enter EMIs Of Existing Liabilities";

  static const String iir = "IIR";
  static const String enterIir = "Enter IIR";
  static const String customerName = "Customer Name";
  static const String enterCustomerName = "Enter Customer Name";
  static const String accessRestrictedStep2and3Msg = "Access Restricted";
  static const String grade = "Grade";
  static const String feedback = "Feedback";
  static const String enterFeedback = "Enter feedback here";
  static const String missingField = "Missing Field";
  static const String plsSelectState = "Please select a State";
  static const String plsSelectCity = "Please select a City";
  static const String plsSelectDist = "Please select a District";

  static const String totalEnquiriesWithin12months = "Total Enquiries within 12 months";
  static const String entertotalEnquiriesWithin12months = "Enter Total Enquiries within 12 months";

  static const String EMIsCcasesNotReflecting = "EMIs Of cases not reflecting in CIBIL Report";
  static const String enterEMIsCcasesNotReflecting = "Enter EMIs Of cases not reflecting";

  static const String available  = "Available";
  static const String notAvailable  = "Not Available";
  static const String willProvideLetterOn  = "Will Provide Letter On";
  static const String substituteWillProvide  = "Substitute Will Provide";
  static const String validateDisbursedBySuperiorEmail ="Please enter Superior Email";
  static const String validateDisbursedBysuperiorContact ="Please enter Superior Contact";

  static const String uploadEmployeeImage="Employee Profile Pic ";
  static const String institution="Institution";
  static const String prodType="Product Type";
  static const String markForForeclosure="Mark for Foreclosure";
  static const String loanAccountNumber="Loan Account Number";
  static const String principalOutstanding="Principal Outstanding";
  static const String installmentAmount="Installment Amount";
  static const String DPD="DPD";
  static const String postDueAmount="Post Due Amount";
  static const String addPackage="Add Package";
  static const String generateQR="Generate QR";
  static const String paymentStatus="Payment Status";
  static const String actionNotAllowed="Action Not Allowed";
  static const String actionNotAllowedMsg="Please complete the previous package payment successfully before adding a new package.";

  static const String Payout="Payout";


//manshi
  static const String manageTicket="Manage Ticket";
  static const String raiseTicket="Raise Ticket";
  static const String ticketRaise="Ticket Raise";
  static const String ticketList="Ticket List";
  static const String subject="Subject";
  static const String panel="Panel";
  static const String priority="Priority";
  static const String file="file";
  static const String image="Image";
  static const String success="Success";
  static const String ticketNo="Ticket No";
  static const String ChooseFiles="Choose Files";
  static const String issueDetail="Issue Details";
  static const String issueDetailDes="Start Typing Here.......";

  static const String ticketId = "Ticket ID";
  static const String panelId = "Panel ID";
  static const String issueDetails = "Issue Details";
  static const String response = "Response";
  static const String createdBy = "Created By";
  static const String createdDate = "Created Date";
  static const String updatedBy = "Updated By";
  static const String updatedDate = "Updated Date";
  static const String closeBy = "Closed By";
  static const String closingDate = "Closing Date";
  static const String reopenDate = "Reopen Date";
  static const String recloseBy = "Reclosed By";
  static const String recloseDate = "Reclosed Date";
  static const String channelId = "Channel ID";
  static const String view="View";
  static const String ticketInfo="Ticket Info";
  static const String viewChat="View Chat";
  static const String userName="User Name";
  static const String close="Close";
  static const String ReClose="Re-Close";








}

class AppColor{
  static const Color primaryColor=Color(0xff32438e);
  // static const Color secondaryColor=Color(0xffFFCC29);
  static const Color secondaryColor=Color(0xffFF8900);
  static const Color secondaryColorLight=Color(0xffffb703);
  static const Color lightGrey=Colors.grey;
  static const Color platinumGrey=Color(0xfffefefe);
  static const Color appBlue=Color(0xfff9ffff);
  static const Color appBlue2=Color(0xffd0fffc);
  static const Color appWhite=Colors.white;
  static const Color appOffWhite=Color(0xffdee3f0);
  static const Color backgroundColor=Color(0xffF9F8F8);
  static const Color buttonSelectedColor=Color(0xff65558f);
  static const Color black45=Colors.black45;
  static const Color black54=Colors.black54;
  static const Color black87=Colors.black87;
  static const Color grey200=Color(0xFFE0E0E0);
  static const Color grey300=Color(0xFFCDCDCD);
  static const Color blackColor=Colors.black;
  static const Color redColor=Colors.red;
  static const Color lightYellow=Color(0xFFfef4ea);
  static const Color grey1=Color(0xFF8A7B7B);
  static const Color grey2=Color(0xFF5E5F60);
  static const Color grey3=Color(0xFFEBEBEB);
  // static const Color orangeColor=Color(0xFFFFB057);
  static const Color orangeColor=Color(0xFFFF8900);
/*  static const Color primaryLight=Color(0xFF384F9F);
  static const Color primaryDark=Color(0xFF323F6E);*/
  static const Color primaryLight=Color(0xFF3850A5);
  static const Color primaryDark=Color(0xFF313E6C);
  static const Color black1=Color(0xFF3D3D3D);
  static const Color amberVersion=Color(0x38FFB057);
  static const Color grey4=Color(0xFFE1E1E1);
  static const Color pinkColor=Colors.pink;
  static const Color purpleColor=Colors.purple;
  static const Color tealColor= Colors.teal;
  static const Color bgMore=Color(0xFFFFF6DC);
  static const Color grey700=Color(0xFF616161);
  static const Color lightYellow2=Color(0xFFF5F5F5);
  static const Color borderColor=Color(0xFFDCDADA);
  static const Color blackLight=Color(0xFF3D3D3D);
  static const Color lightGreen=Color(0xFF00B383);
  static const Color lightBrown=Color(0xFF704F38);
  static const Color lightPrimary2=Color(0xFFDEE5FD);
  static const Color lightRed=Color(0xFFf79999);
  static const Color greenColor= Colors.green;
  static const Color pendigColor=  Color(0xFF919109);




}

class AppFSize{
  static const double mediumFont=15.0;
  static const double largeFont=20.0;
  static const double smallFont=12.0;
}

class AppImage{

  static const String ok="assets/lottie/ok.json";
  static const String applicationcompleted="assets/lottie/applicationcompleted.json";
  static const String empty="assets/lottie/empty.json";
  static const String noDataGirl="assets/lottie/nodata_girl.json";
  static const String nodataCofee="assets/lottie/nodata_cofee.json";
  static const String noBirthday="assets/lottie/no_birthday.json";
  static const String noNews="assets/lottie/no_news.json";
  static const String noTreasure="assets/lottie/no_treasure.json";
  static const String handshake="assets/lottie/handshake.json";
  static const String searchLotie="assets/lottie/search_glass.json";
  static const String moneyStack="assets/lottie/money_stack.json";
  static const String loginJson="assets/lottie/Login.json";
  static const String AuthenticationJson="assets/lottie/Authentication.json";
  static const String login_successJson="assets/lottie/login_success.json";

  static const String drawerIcon="assets/svgIcon/drawerIcon.svg";

  static const String splash="assets/images/logo.png";
  static const String logo1="assets/images/logo1.png";
  static const String intro1="assets/images/intro1.png";
  static const String phoneIcon="assets/images/phoneIcon.png";
  static const String passwordIcon="assets/images/passwordIcon.png";
  static const String bellIcon="assets/images/bellIcon.png";
  static const String searchIcon="assets/images/searchIcon.png";
  static const String offerImage="assets/images/offerImage.png";
  static const String doc="assets/images/doc.png";
  static const String arrow="assets/images/arrow.png";
  static const String addIcon="assets/images/addIcon.png";
  static const String addcivil="assets/images/loan.png";
  static const String addppt="assets/images/powerpoint.png";
  static const String addIconYellow="assets/images/addIcon_yellow.png";
  static const String faq="assets/images/faq.png";
  static const String searchGlass="assets/images/searchGlass.png";
  static const String editImage="assets/images/editImage.png";
  static const String homeIcon="assets/images/homeIcon.png";
  static const String personIcon="assets/images/personIcon.png";
  static const String personYellow="assets/images/personYellow.png";
  static const String settingIcon="assets/images/settingIcon.png";
  static const String settingYellow="assets/images/settingYellow.png";
  static const String peopleGroup="assets/images/peopleGroup.png";
  static const String moreIcon="assets/images/moreIcon.png";
  static const String homeYellow="assets/images/homeYellow.png";
  static const String backDrawer="assets/images/backDrawer.png";
  static const String home2="assets/images/home2.png";
  static const String manInBlack="assets/images/manInBlack.png";
  static const String powerIcon="assets/images/powerIcon.png";
  static const String forwardIcon="assets/images/forwardIcon.png";
  static const String noti_icon="assets/images/noti_icon.png";
  static const String searchIcon2="assets/images/searchIcon2.png";
  static const String filterIcon="assets/images/filterIcon.png";
  static const String deleteIcon="assets/images/trash.svg";
  static const String call1="assets/images/call1.png";
  static const String call_disable="assets/images/call_disable.png";
  static const String chat1="assets/images/chat1.png";
  static const String message1="assets/images/message1.png";
  static const String whatsapp="assets/images/whatsapp.png";
  static const String arrowLeft="assets/images/arrowLeft.png";
  static const String down_arrow="assets/images/down_arrow.png";
  static const String news="assets/images/news.jpg";
  static const String noImage="assets/images/no_image2.png";
  static const String poll_white="assets/images/poll_yellow.png";
  static const String poll_yellow="assets/images/poll_white.png";
  static const String lead_white="assets/images/lead_white.png";
  static const String lead_yellow="assets/images/lead_yellow.png";
  static const String img_not_found="assets/images/img_not_found.jpg";
  static const String webImg="assets/images/webImg.png";
  static const String product="assets/images/product.png";

  static const String logout="assets/images/logout.png";
  static const String email="assets/images/email.png";
  static const String telephone="assets/images/telephone.png";
  static const String lock="assets/images/lock.png";
  static const String user="assets/images/user.png";
  static const String division="assets/images/division.png";
  static const String changePassword="assets/images/change_password.png";
  static const String changePhone="assets/images/change_number.png";
  static const String changeEmail="assets/images/change_email.png";
  static const String choosefile="assets/images/choosefile.png";
  static const String downloadImg="assets/images/downloadImg.png";
  static const String downloadImg_disable="assets/images/downloadImg_disable.png";
  static const String noDataFound="assets/images/noDataFound.png";

  //manshi
  static const String ticket="assets/images/tickets.png";
  static const String message ="assets/images/message.png";



}

class AppStyles {
  static const TextStyle headerTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );
}
class Helper{
  /* static Future<void> checkInternet(Future<void> Function() onConnected) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await onConnected(); // Internet is really available
          return;
        }
      } on SocketException catch (_) {
        // Still no real internet
      }
    }

    ToastMessage.msg("Please check your internet connection");
  }

///Ix
  static Future<void> checkInternet(Future<dynamic> callback) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      callback.asStream();
      // callback.call();
    } else {
      Fluttertoast.showToast(msg: "Check Internet connection");
    }
  }*/

  static Widget CustomCNImage(String imageURL, double cHeight, double cWidth){
    return CachedNetworkImage(
      imageUrl: imageURL,//"",//"https://img.freepik.com/free-photo/close-up-portrait-brunette-smiling-woman-looking-confident-front-standing-hoodie-against-white-wall_176420-39066.jpg?t=st=1737785621~exp=1737789221~hmac=e5648802111562bfcb27f8ed3e9c8d2ca70f826e407a1b9007a98e326b455929&w=1380",
      imageBuilder: (context, imageProvider) => Container(
        width: cHeight, // Must be 2 * radius to fit
        //height: cWidth, // Must be 2 * radius to fit
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            /*  colorFilter:
                               ColorFilter.mode(Colors.red, BlendMode.colorBurn)*/
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>ClipOval(
        child: Container(
          width: 80, // Must be 2 * radius to fit
          height: 80, // Must be 2 * radius to fit
          color: Colors.white,
          child: Icon(Icons.person, size: 40,),
        ),
      ),
    );
  }


  static Widget CustomCNImageBig(String imageURL, double cHeight, double cWidth){
    return CachedNetworkImage(
      imageUrl: imageURL,//"",//"https://img.freepik.com/free-photo/close-up-portrait-brunette-smiling-woman-looking-confident-front-standing-hoodie-against-white-wall_176420-39066.jpg?t=st=1737785621~exp=1737789221~hmac=e5648802111562bfcb27f8ed3e9c8d2ca70f826e407a1b9007a98e326b455929&w=1380",
      imageBuilder: (context, imageProvider) => Container(
        width: cHeight, // Must be 2 * radius to fit
        //height: cWidth, // Must be 2 * radius to fit
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            /*  colorFilter:
                               ColorFilter.mode(Colors.red, BlendMode.colorBurn)*/
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[300],

          ),
        ),
      ),
      errorWidget: (context, url, error) =>Center(
        child: Container(
          width: 200, // Must be 2 * radius to fit
          height: 200, // Must be 2 * radius to fit
          color: Colors.white,
          child: Image.asset(AppImage.img_not_found),
        ),
      ),
    );
  }

  static Map<String, String> splitName(String fullName) {
    List<String> nameParts = fullName.trim().split(' ');

    if (nameParts.length == 1) {
      return {
        'firstName': nameParts[0],
        'lastName': '',
      };
    }

    String firstName = nameParts.sublist(0, nameParts.length - 1).join(' ');
    String lastName = nameParts.last;

    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }


  static Widget customDivider({
    required color
}){
    return SizedBox(
      height: 10,
      child: Divider(
        color: color,
        height: 10,
      ),
    );
  }

  static String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }
  static String formatDate(String dateTime) {


    try {
      // Parse the input date-time string
      DateTime parsedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SS").parse(dateTime);

      // Format to "dd-MM-yyyy, HH:mm a"
      return DateFormat("dd-MM-yyyy, HH:mm a").format(parsedDateTime);
    } catch (e) {
      return "Invalid Date Format";
    }
  }
  static String convertToIso8601(String dateString) {
    try {
      // Parse the input date in "MM/dd/yyyy" format
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateString);

      // Convert to ISO 8601 format with UTC
      return parsedDate.toIso8601String(); // returns "2025-04-01T00:00:00.000Z"
    } catch (e) {
      return "Invalid Date Format";
    }
  }
  static String convertFromIso8601(String? isoDateString) {
    try {
      if (isoDateString == null || isoDateString.isEmpty) {
        return ""; // or whatever fallback you want
      }

      DateTime parsedDate = DateTime.parse(isoDateString);
      return DateFormat("yyyy-MM-dd").format(parsedDate.toLocal());
    } catch (e) {
      return "Invalid Date";
    }
  }

  static String convertDateTime(String dateTimeStr) {
    try {
      // Parse the input date-time string
      DateTime parsedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTimeStr);

      // Subtract one day
     // parsedDateTime = parsedDateTime.subtract(Duration(days: 1));

      // Format to "dd-MM-yyyy, HH:mm a"
      return DateFormat("dd-MM-yyyy, HH:mm a").format(parsedDateTime);
    } catch (e) {
      return "Invalid Date Format";
    }
  }

  static String birthdayFormat(String dateTime) {
    // Split the string at 'T' to get the date part
    String datePart = dateTime.split('T')[0];

    // Split the date into year, month, and day
    List<String> parts = datePart.split('-');

    // Get the current year
    String currentYear = DateTime.now().year.toString();

    // Return the date in DD-MM-YYYY format with the current year
    return '${parts[2]}-${parts[1]}-$currentYear';
  }
  static String formatTimeAgo(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays >= 1) {
      // If more than a day, show formatted date & time
      return DateFormat('dd-MM-yyyy, h:mm a').format(dateTime);
    } else {
      // Show relative time like "5 min ago"
      return timeago.format(dateTime, locale: 'en');
    }
  }
  static String formatCallDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    List<String> parts = [];

    if (hours > 0) parts.add("${hours}h");
    if (minutes > 0) parts.add("${minutes}m");
    if (remainingSeconds > 0 || parts.isEmpty) parts.add("${remainingSeconds}s");

    return parts.join(" ");
  }

  static String attendanceDateFormat(String dateTime) {
    // Split the string at 'T' to get the date part
    String datePart = dateTime.split('T')[0];

    // Split the date into year, month, and day
    List<String> parts = datePart.split('-');

    // Get the current year
    String currentYear = DateTime.now().year.toString();

    // Return the date in DD-MM-YYYY format with the current year
    // return '${parts[2]}-${parts[1]}-$currentYear';
    return '$currentYear-${parts[1]}-${parts[2]}';
  }

  static String convertUnixTo12HourFormat(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('h:mm:ss a').format(dateTime); // local time
  }


  static String convertListToCsvSafe(List<String?> items) {
    return items
        .where((item) => item != null && item.trim().isNotEmpty)
        .map((e) => e!.trim())
        .join(',');
  }
  static String safeValueForField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppText.customdash;
    }
    return value;
  }
  static String safeValueForBoolYesNo(bool? value) {
    if (value == null) {
      return AppText.customdash; // Your "-"
    }
    return value ? "Yes" : "No";
  }
  static String safeValueForInt(int? value) {
    if (value == null || value == 0) {
      return AppText.customdash; // "-"
    }
    return value.toString();
  }
  static String formatDateForLoanString(String? date) {
    if (date == null || date.trim().isEmpty) {
      return AppText.customdash; // "-"
    }

    try {
      DateTime dt = DateTime.parse(date);
      return "${dt.day.toString().padLeft(2, '0')}-"
          "${dt.month.toString().padLeft(2, '0')}-"
          "${dt.year}";
    } catch (e) {
      return AppText.customdash; // if parsing fails
    }
  }
  static String formatDateTimeLoan(DateTime? date) {
    if (date == null) {
      return AppText.customdash; // "-"
    }

    try {
      return "${date.day.toString().padLeft(2, '0')}-"
          "${date.month.toString().padLeft(2, '0')}-"
          "${date.year}";
    } catch (e) {
      return AppText.customdash;
    }
  }
  static String safeValueForNum(num? value) {
    if (value == null || value == 0) {
      return AppText.customdash;
    }
    return value.toString();
  }
  static void ApiReq(String url, dynamic data) {
    print("🛰️ [API Request] ➡️ $url\n📝 Payload: $data\n-----------------------------");
  }

  /// 📥 Logs API Response
  static void ApiRes(String url, dynamic response) {
    print("🎁 [API Response] ⬅️ $url\n📄 Response: $response\n=============================");
  }

  static String cleanText(String text) {
    return text.trim().isEmpty ? "" : text.trim();
  }
  static void debugJsonTypes(dynamic json, [String parentKey = ""]) {
    if (json is Map<String, dynamic>) {
      json.forEach((key, value) {
        final fullKey = parentKey.isEmpty ? key : "$parentKey.$key";
        print("I am here-->1");
        debugJsonTypes(value, fullKey);
      });
    } else if (json is List) {
      for (int i = 0; i < json.length; i++) {
        print("I am here-->2");
        debugJsonTypes(json[i], "$parentKey[$i]");
      }
    } else {
      print("$parentKey -> ${json.runtimeType} -> $json");
    }
  }
  static int calculateAge(String dobString) {
    DateTime dob = DateTime.parse(dobString); // parse from API
    DateTime today = DateTime.now();

    int age = today.year - dob.year;

    // If birthday hasn’t occurred yet this year → subtract 1
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }

    return age;
  }

  static String formatAddressLoan({
    String? houseFlatNo,
    String? buildingNo,
    String? societyName,
    String? locality,
    String? streetName,
    String? city,
    String? taluka,
    String? district,
    String? state,
    String? country,
    String? pinCode,
  }) {
    // Create a list of all fields
    final parts = [
      houseFlatNo,
      buildingNo,
      societyName,
      locality,
      streetName,
      city,
      taluka,
      district,
      state,
      country,
    ]
        .where((value) => value != null && value.trim().isNotEmpty)
        .toList();

    // Join with commas
    String address = parts.join(', ');

    // Add pincode with a dash only if it's available
    if (pinCode != null && pinCode.trim().isNotEmpty) {
      address = "$address - $pinCode";
    }

    // If everything is empty, return your dash
    return address.isEmpty ? AppText.customdash : address;
  }

  static String formatStringToSerialNumbers(String input, {String separator = ','}) {
    // Split string by separator, trim spaces, and remove empty parts
    final parts = input.split(separator).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    // Map with serial numbers
    final formatted = parts.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final value = entry.value.toUpperCase(); // if you want everything in caps
      return "($index) $value";
    }).join('\n');

    return formatted;
  }

  static String capitalizeWords(String input) {
    if (input.isEmpty) return input;

    return input
        .split(' ') // split by spaces
        .map((word) {
      if (word.trim().isEmpty) return word; // keep multiple spaces intact
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    })
        .join(' ');
  }

  static int? parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}


class HelperClass {



  static Widget _buildImagePickerSheet() {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text("Take Photo"),
            onTap: () => Navigator.of(Get.context!).pop(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Choose from Gallery"),
            onTap: () => Navigator.of(Get.context!).pop(ImageSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text("Cancel"),
            onTap: () => Navigator.of(Get.context!).pop(),
          ),
        ],
      ),
    );
  }


}





class ToastMessage {
  static void msg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColor.secondaryColor,
        textColor: Colors.white);
  }

  static void alertmsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColor.primaryColor,
        textColor: Colors.white);
  }

  static void msgRed(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: Colors.red,
        textColor: AppColor.appWhite);
  }
  static void msgPrimary(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColor.primaryColor,
        textColor: AppColor.secondaryColor);
  }
}

class MultipartFieldHelper {
  /// Adds a field if [value] is not null and not equal to "string"
  /// If invalid, assigns "null" (as string)
  static void addField(Map<String, String> fields, String key, String? value) {
    if (value != null && value != "string") {
      fields[key] = value;
    } else {
      fields[key] = "null";
    }
  }

  static void addFieldWithoutNull(Map<String, String> fields, String key, String? value) {
    if (value != null && value != "string") {
      fields[key] = value;
    } else {
      fields[key] = "";
    }
  }

  /// Overloaded version with default fallback (optional)
  static void addFieldWithDefault(
      Map<String, String> fields,
      String key,
      String? value, {
        String fallback = "0",
      }) {

    if (value != null && value != "" && value != "null") {
      fields[key] = value;
    } else {
      fields[key] = fallback;
    }
  }


}