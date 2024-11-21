import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: ImageCaptureApp()));
}

class ImageCaptureApp extends StatefulWidget {
  @override
  _ImageCaptureAppState createState() => _ImageCaptureAppState();
}

class _ImageCaptureAppState extends State<ImageCaptureApp> {
  CameraController? _cameraController;
  Interpreter? _interpreter;
  String? _detectedLabel;
  List<String>? _labels;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadModel();
    _loadLabels();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(frontCamera, ResolutionPreset.high);
    await _cameraController!.initialize();
    setState(() {});
  }

  Future<void> _loadModel() async {
    _interpreter = await Interpreter.fromAsset('faces.tflite'); // Ensure 'faces.tflite' is added to your assets
  }

  Future<void> _loadLabels() async {
    final labelsData = await rootBundle.loadString('assets/labels.txt');
    _labels = labelsData.split('\n');
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  Future<void> _captureAndClassifyImage() async {
    try {
      final imageFile = await _cameraController!.takePicture();

      // Run inference on the captured image
      await _detectObject(imageFile);

      setState(() {
        _detectedLabel = _detectedLabel ?? 'Face not recognized'; // Display result
      });
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  Future<void> _detectObject(XFile imageFile) async {
    // Load and process the image
    TensorImage inputImage = TensorImage.fromFile(File(imageFile.path));
    final imageProcessor = ImageProcessorBuilder()
        .add(ResizeOp(224, 224, ResizeMethod.NEAREST_NEIGHBOUR)) // Adjust to match model's input requirements
        .build();
    inputImage = imageProcessor.process(inputImage);

    // Prepare input and output for the interpreter
    var inputBuffer = inputImage.buffer;

    // Initialize output as List<List<double>>
    var outputBuffer = List.generate(1, (_) => List.filled(_labels?.length ?? 1, 0.0));

    // Run the model on the processed image
    _interpreter?.run(inputBuffer, outputBuffer);

    // Parse output to find label
    final label = _parseLabel(outputBuffer);
    setState(() {
      _detectedLabel = label;
    });
  }

  String _parseLabel(List<List<double>> output) {
    final index = output[0].indexWhere((element) => element == output[0].reduce(max));
    return _labels != null && index < _labels!.length ? _labels![index] : 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Face Recognition')),
      body: _cameraController == null || !_cameraController!.value.isInitialized
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(_cameraController!),
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _captureAndClassifyImage,
                        child: Text('Capture & Recognize Face'),
                      ),
                      if (_detectedLabel != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _detectedLabel!,
                            style: TextStyle(fontSize: 24, color: Colors.white, backgroundColor: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
