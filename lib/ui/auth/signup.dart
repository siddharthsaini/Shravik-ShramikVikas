import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Shravik/localizations.dart';
import 'package:Shravik/ui/components/components.dart';
import 'package:Shravik/helpers/helpers.dart';
import 'package:Shravik/services/services.dart';
import 'package:Shravik/ui/components/jobcheckbox.dart';
import 'package:Shravik/ui/components/reusablelogo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:location/location.dart' as loc;

class Signup extends StatefulWidget {
  Signup({this.category});
  final String category;

  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = new TextEditingController();
  // final TextEditingController _email = new TextEditingController();
  final TextEditingController _phone = new TextEditingController();
  String _email;
  Position _position;
  String _address, _subLocality, _locality, _subAdminArea, _adminArea;
  double lat, long;
  // String _category = 'Worker';
  String _about;
  String url;
  List<dynamic> _job;
  String _exp;
  final TextEditingController _password = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StorageReference storageReference =
      FirebaseStorage(storageBucket: 'gs://shramikvikas-app.appspot.com').ref();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    // _email.dispose();
    _password.dispose();
    super.dispose();
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });

    compressUpload();
  }

  Future<Null> compressUpload() async {
    var result = await FlutterImageCompress.compressWithFile(
      _image.absolute.path,
      minWidth: 400,
      minHeight: 400,
      quality: 72,
    );
    StorageUploadTask storageUploadTask = storageReference
        .child("${DateTime.now().millisecondsSinceEpoch}.jpg")
        .putData(result);

    var dowurl =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();
  }

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    bool _loading = false;

    return Scaffold(
      key: _scaffoldKey,
      body: LoadingScreen(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 55.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Hero(
                            tag: 'reusable-widget',
                            child: ReusableLogo(),
                          ),
                          Container(
                            height: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  labels.auth.signUpButton,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.category == 'Worker'
                                      ? labels.auth.radio1
                                      : labels.auth.radio2,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _image == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  iconSize: 60,
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () {
                                    getImage();
                                  }),
                              SizedBox(height: 6),
                              Text(
                                labels.auth.uploadimage,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  foregroundColor: Colors.blue,
                                  radius: 85,
                                  child: ClipOval(
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                      width: 150.0,
                                      height: 150.0,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  foregroundColor: Colors.black,
                                  radius: 23,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(height: 48.0),
                    FormInputFieldWithIcon(
                      controller: _name,
                      iconPrefix: Icons.person,
                      labelText: labels.auth.nameFormField,
                      validator: Validator(labels).name,
                      onChanged: (value) => null,
                      onSaved: (value) => _name.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _phone,
                      iconPrefix: Icons.phone,
                      labelText: labels.home.phone,
                      validator: Validator(labels).number,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => null,
                      onSaved: (value) => _phone.text = value,
                    ),
                    FormVerticalSpace(),
                    TextFormField(
                      // controller: _email,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.email),
                        labelText: labels.auth.emailFormField,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (input) {
                        if (input.isNotEmpty) {
                          if (input.contains('@') && input.contains('.')) {
                            _email = input;
                          } else {
                            return labels.validator.email;
                          }
                        } else {
                          _email = input;
                        }
                      },
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _password,
                      iconPrefix: Icons.lock,
                      labelText: labels.auth.passwordFormField,
                      validator: Validator(labels).password,
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) => null,
                      onSaved: (value) => _password.text = value,
                    ),
                    FormVerticalSpace(),
                    JobCheckbox(
                      onPress: (value) {
                        if (value == null) return;
                        setState(() {
                          List<dynamic> job = value;
                          _job = job;
                          // .toString()
                          // .replaceAll('[', '')
                          // .replaceAll(']', '');
                          print(_job);
                        });
                      },
                      title: widget.category == 'Worker'
                          ? labels.auth.yourJob
                          : labels.auth.servicesReqd,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        inputFormatters: widget.category == 'Worker'
                            ? [LengthLimitingTextInputFormatter(2)]
                            : null,
                        validator: (input) {
                          if (input.isEmpty) {
                            return labels.validator.req;
                          } else {
                            _exp = input;
                          }
                        },
                        keyboardType: widget.category == 'Worker'
                            ? TextInputType.number
                            : null,
                        decoration: InputDecoration(
                          // labelText: 'About You',
                          hintText: widget.category == 'Worker'
                              ? labels.auth.experience
                              : labels.auth.company,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        validator: (input) {
                          // if (input.isEmpty) {
                          //   return '*Required';
                          // } else {
                          _about = input;
                          // }
                        },
                        // expands: true,
                        // onSaved: (value) => _about = value,
                        maxLength: 400,
                        maxLines: 13,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          // labelText: 'About You',
                          hintText: labels.home.about,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormVerticalSpace(),
                    RaisedButton(
                      color: Colors.blue[800],
                      onPressed: () async {
                        loc.Location location = new loc.Location();
                        bool _serviceEnabled;

                        _serviceEnabled = await location.serviceEnabled();
                        if (!_serviceEnabled) {
                          _serviceEnabled = await location.requestService();
                          if (_serviceEnabled) {
                            _position = await Geolocator().getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.high);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.green[600],
                              content: Text(labels.auth.locationEntered),
                            ));
                            final coordinates = new Coordinates(
                                _position.latitude, _position.longitude);

                            lat = _position.latitude;
                            long = _position.longitude;

                            var addresses = await Geocoder.local
                                .findAddressesFromCoordinates(coordinates);
                            var first = addresses.first;
                            _address = first.addressLine;
                            _subLocality = first.subLocality;
                            _locality = first.subLocality;
                            _subAdminArea = first.subAdminArea;
                            _adminArea = first.adminArea;
                          } else if (!_serviceEnabled) {
                            _serviceEnabled = await location.requestService();
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.red[600],
                              content: Text(labels.auth.allowLocation),
                            ));
                          }
                        } else if (_serviceEnabled) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: Colors.green[600],
                            content: Text(labels.auth.locationEntered),
                          ));
                          _position = await Geolocator().getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);
                          final coordinates = new Coordinates(
                              _position.latitude, _position.longitude);

                          lat = _position.latitude;
                          long = _position.longitude;

                          var addresses = await Geocoder.local
                              .findAddressesFromCoordinates(coordinates);
                          var first = addresses.first;
                          _address = first.addressLine;
                          _subLocality = first.subLocality;
                          _locality = first.subLocality;
                          _subAdminArea = first.subAdminArea;
                          _adminArea = first.adminArea;
                        }
                      },
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.my_location),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            labels.auth.locationbutton1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    FormVerticalSpace(),
                    Container(
                      width: double.infinity,
                      child: PrimaryButton(
                          labelText: labels.auth.signUpButton,
                          onPressed: () async {
                            print(_email);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.green[600],
                              content: Text(labels.auth.creatingAccount),
                            ));
                            if (_adminArea != null) {
                              if (_formKey.currentState.validate()) {
                                SystemChannels.textInput.invokeMethod(
                                    'TextInput.hide'); //to hide the keyboard - if any
                                AuthService _auth = AuthService();
                                bool _isRegisterSucccess =
                                    await _auth.registerWithEmailAndPassword(
                                  _name.text,
                                  _email,
                                  _password.text,
                                  _phone.text,
                                  widget.category,
                                  _about,
                                  _address,
                                  _subLocality,
                                  _locality,
                                  _subAdminArea,
                                  _adminArea,
                                  url,
                                  _job,
                                  _exp,
                                  lat,
                                  long,
                                );

                                if (_isRegisterSucccess == false) {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(labels.auth.errormsg),
                                  ));
                                }
                              }
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(labels.auth.enterLocation),
                              ));
                            }
                          }),
                    ),
                    FormVerticalSpace(),
                    LabelButton(
                      labelText: labels.auth.signInLabelButton,
                      onPressed: () =>
                          // Navigator.pushReplacementNamed(context, '/'),
                          Navigator.pushReplacementNamed(context, '/signin'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
