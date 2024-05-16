class API {
  static const baseUrl = 'https://ehab.sdo1.top/api';
  static const baseImageUrl = 'https://ehab.sdo1.top/storage/';

  static const register = '/userRegister';
  static const login = '/userlogin';
  static const verifyOtp = '/resetOtp';
  static const UpdateFcm = '/resetOtp';
  static const verifyOtpAndResetPassword = '/verifyOtpAndResetPassword';
  static const contactTest = '/contactTest';
  static const getContact = '/getContact';
  static const eventApp = '/eventApp';
  static const characters = '/getAllCharacters';
  static const newEventApp = '/NewEventApp';
  static const getHome = '/getPeerConv';
  static const getCalendar = '/getGroupConv';
  static const createPeerConversation = '/FirestoreData';
  static const searchUser = '/users';
  static String imageUrl(String path) => '$baseImageUrl$path';
}
