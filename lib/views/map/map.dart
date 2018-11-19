import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liulo/utils/network_util.dart';

class MapScreen extends StatefulWidget {

  @override
  State createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  GoogleMapController _mapController;
  
  String _filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                ),
              ),
            ),
            RaisedButton(
              child: const Text('Go to London'),
              onPressed: _mapController == null ? null : () {
                _mapController.animateCamera(CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    bearing: 270.0,
                    target: LatLng(51.5160895, -0.1294527),
                    tilt: 30.0,
                    zoom: 17.0,
                  ),
                ));
              },
            ),
            Center(
              child: _filePath == null
                  ? new Text('No file selected.')
                  : new Text('Path' + _filePath),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getFilePath,
        tooltip: 'Select file',
        child: new Icon(Icons.sd_storage),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { _mapController = controller; });
  }

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.IMAGE);
      if (filePath == '') return;
      print("File path: " + filePath);
      setState((){this._filePath = filePath;});
      uploadFileToServer(filePath);
    } catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  void uploadFileToServer(String filePath) async {
    NetworkUtil().uploadFile("https://file.io", filePath, "file").then((res) {
      print(res);
    });
  }

}
