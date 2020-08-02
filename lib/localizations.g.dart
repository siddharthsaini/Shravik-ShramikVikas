part of 'localizations.dart';

// **************************************************************************
// SheetLocalizationGenerator
// **************************************************************************

class AppLocalizations {
  AppLocalizations(this.locale) : this.labels = languages[locale];

  final Locale locale;

  static final Map<Locale, AppLocalizations_Labels> languages = {
    Locale.fromSubtags(languageCode: "en"): AppLocalizations_Labels(
      auth: AppLocalizations_Labels_Auth(
        errormsg: "The number already exists or Password too short.",
        you: "You",
        distance: "Distance",
        choose1orMore: 'Please select one or more job options!',
        cancelBox: 'CANCEL',
        ok: "OK",
        oneorMore: 'Please choose one or more: (Maximum 10)',
        cook: "Cook",
        officeBoy: "Office Boy",
        others: "Others",
        salesman: "Salesman",
        tailor: "Tailor",
        supervisor: "Supervisor",
        guard: "Security Guard",
        driver: "Driver",
        plumber: "Plumber",
        carpenter: "Carpenter",
        electrician: "Electrician",
        maid: "Domestic Helper / Maid",
        factory2: "Factory Worker - Skilled",
        factory1: "Factory Worker - Helper",
        factory3: "Factory Worker - Non Skilled",
        construction: "Construction Labourer",
        searchAgain: "Search Again",
        openinmap: 'Open in Map',
        userProfile: "User Profile",
        searchUser: 'Search',
        chooseBoth: "*Choose from both",
        filter: "Filters:",
        searchEmp: "Search for\nEmployers",
        searchMig: "Search for\nMigrant Workers",
        category: "Category:",
        allowLocation: "Allow location access to continue.",
        company: 'Company name/ Profession/ Self:',
        experience: 'Years of Experience:',
        servicesReqd: 'Services required:',
        yourJob: 'Your job(s):',
        categoryQuestion: "Who are you?",
        shareApp: "SHARE APP",
        email: "EMAIL",
        call: "CALL",
        searchEmployers: "SEARCH FOR EMPLOYERS",
        search2: 'Search employers...',
        searchWorkers: "SEARCH FOR WORKERS",
        filter1: "FILTER USERS\nUSING THIS\nDROPDOWN",
        search1: "Search workers...",
        whichUser: "Who are you looking for?",
        profile: 'Profile',
        search: 'Search',
        updateLocation: "Update your Location",
        updatingLocation: "Updating Location",
        aboutYou: 'About:',
        residence: 'Residence:',
        job: 'Job:',
        enterLocation: "Enter location!",
        creatingAccount: "Creating account...",
        locationbutton1: 'Enter your Location',
        locationEntered: "Location Entered",
        radio2: "Employer",
        radio1: "Migrant Worker",
        uploadimage: "Upload Image",
        welcometitle: 'SHRAVIK',
        welcometitlefoot: 'SHRAMIK VIKAS',
        signInButton: "Sign In",
        signUpButton: "Sign Up",
        resetPasswordButton: "Send Password Reset",
        emailFormField: "Email",
        passwordFormField: "Password",
        nameFormField: "Name",
        signInError: "Login failed: email or password incorrect.",
        resetPasswordLabelButton: "Forgot password?",
        signUpLabelButton: "Create an Account",
        signUpError: "Sign up failed.",
        signInLabelButton: "Have an Account? Sign In.",
        resetPasswordNotice:
            "Check your email and follow the instructions to reset your password.",
        signInonResetPasswordLabelButton: "Sign In",
        updateUser: "Update Profile",
        updateUserSuccessNotice: "User updated successfully",
        updateUserFailNotice: "Failed to update user",
        enterPassword: "Enter your password",
        cancel: "Cancel",
        submit: "Submit",
        changePasswordLabelButton: "Change Password",
        resetPasswordTitle: "Reset Password",
        updateProfileTitle: "Update Profile",
        wrongPasswordNotice: "Password is incorrect.",
        unknownError: "Unknown Error",
      ),
      settings: AppLocalizations_Labels_Settings(
        title: "Settings",
        language: "Language / भाषा",
        theme: "Theme",
        signOut: "Sign Out",
        dark: "Dark",
        light: "Light",
        system: "System",
        updateProfile: "Update Profile",
      ),
      home: AppLocalizations_Labels_Home(
        about:
            "Write about you.\nEg: Where did you work? Why are you registering here?",
        phone: 'Phone number',
        title: "Home",
        nameLabel: "Name",
        uidLabel: "UID",
        emailLabel: "Email",
        adminUserLabel: "Admin User",
      ),
      app: AppLocalizations_Labels_App(
        title: "Flutter Starter Project",
      ),
      validator: AppLocalizations_Labels_Validator(
        email: "Please enter a valid email address.",
        password: "Password must be at least 6 characters.",
        name: "Please enter a name.",
        number: "*Enter a valid number.",
        notEmpty: "This is a required field.",
        amount:
            "Please enter a number i.e. 250 - no dollar symbol and no cents",
        req: "*Required",
      ),
    ),
    Locale.fromSubtags(languageCode: "hi"): AppLocalizations_Labels(
      auth: AppLocalizations_Labels_Auth(
        errormsg: "फ़ोन पहले से मौजूद है या पासवर्ड बहुत छोटा है।",
        you: "आप",
        distance: "दूरी",
        choose1orMore: 'कृपया एक या अधिक नौकरी विकल्प चुनें!',
        cancelBox: "रद्द करें",
        ok: 'ठीक है',
        oneorMore: 'कृपया एक या अधिक चुनें: (अधिकतम 10)',
        cook: "रसोइया / कुक",
        officeBoy: "ऑफिस बॉय",
        others: "अन्य",
        salesman: "सेल्समैन",
        tailor: "दर्जी",
        supervisor: "सुपरवाईजर",
        guard: "सुरक्षा कर्मी",
        driver: "चालक / ड्राईवर",
        carpenter: "बढ़ई / कारपेंटर",
        plumber: "प्लम्बर",
        electrician: "इलेक्ट्रीशियन",
        maid: "घरेलू हेल्पर / नौकरानी",
        factory3: "फैक्ट्री वर्कर - नॉन स्किल्ड",
        factory2: "फैक्ट्री वर्कर - स्किल्ड",
        factory1: "फैक्ट्री वर्कर - हेल्पर",
        construction: "निर्माण मजदूर / राजमिस्त्री",
        searchAgain: "फिर से खोजो",
        openinmap: "नक्षे पे खोलें",
        userProfile: "उपयोगकर्ता प्रोफ़ाइल",
        searchUser: 'सर्च',
        chooseBoth: "*दोनों में से चुनें",
        filter: "फ़िल्टर:",
        searchEmp: "नियोक्ताओं\nके लिए खोजें",
        searchMig: "प्रवासी कामगारों\nके लिए खोजें",
        category: "वर्ग:",
        allowLocation: "स्थान को जारी रखने की अनुमति दें।",
        company: 'कंपनी का नाम / पेशा / स्वयं:',
        experience: 'वर्षों का अनुभव:',
        servicesReqd: 'आवश्यक सेवाएँ:',
        yourJob: 'आपकी नौकरी / रोजगार:',
        categoryQuestion: 'आप कौन हैं?',
        shareApp: "ऐप शेयर करें",
        email: "ईमेल करें",
        call: "फ़ोन करें",
        searchEmployers: "नियोक्ताओं के लिए खोज",
        search2: 'खोज उद्यमी..',
        searchWorkers: "काम करने वालों की खोज",
        filter1: "उपयोगकर्ता\nफिल्टर करे",
        search1: 'श्रमिकों की खोज करें..',
        whichUser: "आप किसे ढूँढ रहे हैं?",
        profile: 'रूपरेखा',
        search: 'खोजें',
        updateLocation: 'अपना निवास अपडेट करें',
        updatingLocation: "लोकेशन अपडेट हो रही है",
        aboutYou: 'आपके बारे में:',
        residence: 'रहने का स्थान:',
        job: 'काम:',
        enterLocation: "स्थान दर्ज करें!",
        creatingAccount: "खाता बन रहा है...",
        locationbutton1: "अपना स्थान दर्ज कीजिये",
        locationEntered: "स्थान दर्ज किया गया",
        radio2: "उद्द्यमी",
        radio1: "प्रवासी श्रमिक",
        uploadimage: "तस्वीर डालिये",
        welcometitlefoot: "श्रमिक विकास",
        welcometitle: "श्रविक",
        signInButton: "साइन इन करें",
        signUpButton: "साइन अप करें",
        resetPasswordButton: "भेजें पासवर्ड रीसेट",
        emailFormField: "ईमेल",
        passwordFormField: "पासवर्ड",
        nameFormField: "नाम",
        signInError: "लॉगइन असफल: ईमेल या पासवर्ड गलत है।",
        resetPasswordLabelButton: "पासवर्ड भूल गए?",
        signUpLabelButton: "खाता बनाएं",
        signUpError: "साइन अप करने में विफल रहा।",
        signInLabelButton: "खाता है? साइन इन करें।",
        resetPasswordNotice:
            "अपने ईमेल की जाँच करें और निर्देशों का अपना पासवर्ड रीसेट करने का पालन करें।",
        signInonResetPasswordLabelButton: "साइन इन करें",
        updateUser: "प्रोफ़ाइल अपडेट करें",
        updateUserSuccessNotice: "प्रयोक्ता को सफलतापूर्वक अद्यतन",
        updateUserFailNotice: "उपयोगकर्ता अद्यतन करने में विफल",
        enterPassword: "अपना पासवर्ड डालें",
        cancel: "रद्द करना",
        submit: "प्रस्तुत",
        changePasswordLabelButton: "पासवर्ड बदलें",
        resetPasswordTitle: "पासवर्ड रीसेट",
        updateProfileTitle: "प्रोफ़ाइल अपडेट करें",
        wrongPasswordNotice: "पासवर्ड गलत है।",
        unknownError: "अज्ञात त्रुटि",
      ),
      settings: AppLocalizations_Labels_Settings(
        title: "समायोजन",
        language: "Language / भाषा",
        theme: "विषय",
        signOut: "प्रस्थान करें",
        dark: "अंधेरा",
        light: "रोशनी",
        system: "प्रणाली",
        updateProfile: "प्रोफ़ाइल अपडेट करें",
      ),
      home: AppLocalizations_Labels_Home(
        about:
            "आपके बारे में लिखें।\nउदाहरण: आपने कहाँ काम किया? आप यहाँ क्यों पंजीकरण कर रहे हैं?",
        phone: "फ़ोन नंबर",
        title: "घर",
        nameLabel: "नाम",
        uidLabel: "यूआईडी",
        emailLabel: "ईमेल",
        adminUserLabel: "व्यवस्थापक उपयोगकर्ता",
      ),
      app: AppLocalizations_Labels_App(
        title: "स्पंदन स्टार्टर परियोजना",
      ),
      validator: AppLocalizations_Labels_Validator(
        email: "कृपया एक वैध ई - मेल एड्रेस डालें।",
        password: "पासवर्ड कम से कम 6 अंकों का होना चाहिए।",
        name: "एक नाम दर्ज करें।",
        number: "*वैध संख्या दर्ज करें।",
        notEmpty: "यह एक ज़रूरी जगह हैं।",
        amount: "कोई डॉलर प्रतीक और कोई सेंट - एक नंबर अर्थात 250 दर्ज करें",
        req: "*आवश्यक",
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

class AppLocalizations_Labels_Auth {
  const AppLocalizations_Labels_Auth({
    this.signInButton,
    this.search,
    this.signUpButton,
    this.resetPasswordButton,
    this.emailFormField,
    this.passwordFormField,
    this.nameFormField,
    this.signInError,
    this.resetPasswordLabelButton,
    this.signUpLabelButton,
    this.signUpError,
    this.signInLabelButton,
    this.resetPasswordNotice,
    this.signInonResetPasswordLabelButton,
    this.updateUser,
    this.updateUserSuccessNotice,
    this.updateUserFailNotice,
    this.enterPassword,
    this.cancel,
    this.submit,
    this.changePasswordLabelButton,
    this.resetPasswordTitle,
    this.updateProfileTitle,
    this.wrongPasswordNotice,
    this.unknownError,
    this.welcometitle,
    this.welcometitlefoot,
    this.uploadimage,
    this.radio1,
    this.radio2,
    this.locationbutton1,
    this.locationEntered,
    this.creatingAccount,
    this.enterLocation,
    this.job,
    this.residence,
    this.aboutYou,
    this.updatingLocation,
    this.updateLocation,
    this.profile,
    this.whichUser,
    this.search1,
    this.filter1,
    this.searchWorkers,
    this.search2,
    this.searchEmployers,
    this.call,
    this.email,
    this.shareApp,
    this.categoryQuestion,
    this.yourJob,
    this.servicesReqd,
    this.experience,
    this.company,
    this.allowLocation,
    this.category,
    this.searchMig,
    this.searchEmp,
    this.filter,
    this.chooseBoth,
    this.searchUser,
    this.userProfile,
    this.openinmap,
    this.searchAgain,
    this.construction,
    this.factory1,
    this.factory2,
    this.factory3,
    this.maid,
    this.supervisor,
    this.plumber,
    this.guard,
    this.electrician,
    this.driver,
    this.carpenter,
    this.cook,
    this.officeBoy,
    this.tailor,
    this.salesman,
    this.others,
    this.oneorMore,
    this.ok,
    this.cancelBox,
    this.choose1orMore,
    this.distance,
    this.you,
    this.errormsg,
  });

  final String errormsg;

  final String searchAgain;

  final String you;

  final String distance;

  final String choose1orMore;

  final String ok;

  final String cancelBox;

  final String oneorMore;

  final String officeBoy;

  final String tailor;

  final String cook;

  final String salesman;

  final String others;

  final String electrician;

  final String carpenter;

  final String plumber;

  final String guard;

  final String driver;

  final String supervisor;

  final String factory1;

  final String factory2;

  final String factory3;

  final String maid;

  final String construction;

  final String filter;

  final String openinmap;

  final String userProfile;

  final String searchUser;

  final String chooseBoth;

  final String yourJob;

  final String searchEmp;

  final String searchMig;

  final String category;

  final String allowLocation;

  final String company;

  final String experience;

  final String servicesReqd;

  final String enterLocation;

  final String categoryQuestion;

  final String shareApp;

  final String call;

  final String email;

  final String searchEmployers;

  final String search2;

  final String searchWorkers;

  final String filter1;

  final String search1;

  final String whichUser;

  final String profile;

  final String search;

  final String updatingLocation;

  final String updateLocation;

  final String aboutYou;

  final String residence;

  final String job;

  final String welcometitle;

  final String creatingAccount;

  final String locationEntered;

  final String locationbutton1;

  final String radio2;

  final String radio1;

  final String uploadimage;

  final String welcometitlefoot;

  final String signInButton;

  final String signUpButton;

  final String resetPasswordButton;

  final String emailFormField;

  final String passwordFormField;

  final String nameFormField;

  final String signInError;

  final String resetPasswordLabelButton;

  final String signUpLabelButton;

  final String signUpError;

  final String signInLabelButton;

  final String resetPasswordNotice;

  final String signInonResetPasswordLabelButton;

  final String updateUser;

  final String updateUserSuccessNotice;

  final String updateUserFailNotice;

  final String enterPassword;

  final String cancel;

  final String submit;

  final String changePasswordLabelButton;

  final String resetPasswordTitle;

  final String updateProfileTitle;

  final String wrongPasswordNotice;

  final String unknownError;
}

class AppLocalizations_Labels_Settings {
  const AppLocalizations_Labels_Settings(
      {this.title,
      this.language,
      this.theme,
      this.signOut,
      this.dark,
      this.light,
      this.system,
      this.updateProfile});

  final String title;

  final String language;

  final String theme;

  final String signOut;

  final String dark;

  final String light;

  final String system;

  final String updateProfile;
}

class AppLocalizations_Labels_Home {
  const AppLocalizations_Labels_Home({
    this.title,
    this.nameLabel,
    this.uidLabel,
    this.emailLabel,
    this.adminUserLabel,
    this.phone,
    this.about,
  });

  final String about;

  final String title;

  final String phone;

  final String nameLabel;

  final String uidLabel;

  final String emailLabel;

  final String adminUserLabel;
}

class AppLocalizations_Labels_App {
  const AppLocalizations_Labels_App({this.title});

  final String title;
}

class AppLocalizations_Labels_Validator {
  const AppLocalizations_Labels_Validator({
    this.email,
    this.password,
    this.name,
    this.number,
    this.notEmpty,
    this.amount,
    this.req,
  });

  final String email;

  final String password;

  final String name;

  final String number;

  final String notEmpty;

  final String amount;

  final String req;
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels({
    this.auth,
    this.settings,
    this.home,
    this.app,
    this.validator,
  });

  final AppLocalizations_Labels_Auth auth;

  final AppLocalizations_Labels_Settings settings;

  final AppLocalizations_Labels_Home home;

  final AppLocalizations_Labels_App app;

  final AppLocalizations_Labels_Validator validator;
}
