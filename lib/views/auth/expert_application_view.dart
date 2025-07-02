import 'package:flutter/material.dart';

class ExpertApplicationView extends StatefulWidget {
  const ExpertApplicationView({super.key});

  @override
  State<ExpertApplicationView> createState() => _ExpertApplicationViewState();
}

class _ExpertApplicationViewState extends State<ExpertApplicationView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _universityController = TextEditingController();
  final _facultyController = TextEditingController();
  final _departmentController = TextEditingController();
  String? _diplomaPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(), title: Text('MindEase')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Text(
                'Join Our Online Psychologist Network',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              _buildTextField(_nameController, 'Name - Surname'),
              SizedBox(height: 16),
              _buildTextField(_phoneController, 'Phone Number', keyboardType: TextInputType.phone),
              SizedBox(height: 16),
              _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
              SizedBox(height: 16),
              _buildTextField(_universityController, 'University'),
              SizedBox(height: 16),
              _buildTextField(_facultyController, 'Faculty'),
              SizedBox(height: 16),
              _buildTextField(_departmentController, 'Department'),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.upload_file),
                label: Text('Upload Diploma'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {},
                child: Text('Apply'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }
}
