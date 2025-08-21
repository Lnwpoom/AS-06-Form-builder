import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ข้อมูลนักศึกษา',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
          primary: Colors.blue,
          secondary: Colors.lightBlue,
          background: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        cardTheme: CardThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 5,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/form': (context) => const FormPage(),
        '/list': (context) => const ListPage(),
      },
      localizationsDelegates: const [FormBuilderLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('th')],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightBlue[100]!,
              Colors.blue[200]!,
              Colors.blue[400]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            // Added Center widget to center the content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'app_icon',
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.school_rounded,
                            size: 50,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'ระบบจัดการข้อมูลนักศึกษา',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'จัดการข้อมูลนักศึกษาอย่างง่ายดาย',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Menu Cards Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center vertically
                      children: [
                        Expanded(
                          child: _MenuCard(
                            icon: Icons.person_add_rounded,
                            title: 'กรอกข้อมูลนักศึกษา',
                            subtitle: 'เพิ่มข้อมูลนักศึกษาใหม่',
                            gradientColors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                            onTap: () => Navigator.pushNamed(context, '/form'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: _MenuCard(
                            icon: Icons.list_alt_rounded,
                            title: 'ดูข้อมูลนักศึกษา',
                            subtitle: 'เรียกดูรายชื่อนักศึกษาทั้งหมด',
                            gradientColors: [
                              Theme.of(context).colorScheme.tertiary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                            onTap: () => Navigator.pushNamed(context, '/list'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Rest of the code (e.g., _MenuCard, FormPage, ListPage) remains unchanged

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.1))
                  .toList(),
            ),
          ),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColors),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _saveStudentData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('students_json') ?? '[]';
    final List<dynamic> students = jsonDecode(jsonString);
    students.add(data);
    await prefs.setString('students_json', jsonEncode(students));
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('กรอกข้อมูลนักศึกษา'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                _buildSection('ข้อมูลส่วนตัว', [
                  FormBuilderTextField(
                    name: 'name',
                    initialValue: 'ชื่อ นามสกุลตัวอย่าง',
                    decoration: const InputDecoration(
                      labelText: 'ชื่อ-นามสกุล',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'กรุณากรอกชื่อ-นามสกุล',
                      ),
                      FormBuilderValidators.minLength(
                        5,
                        errorText: 'อย่างน้อย 5 ตัวอักษร',
                      ),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'student_id',
                    initialValue: '1234567890',
                    decoration: const InputDecoration(
                      labelText: 'รหัสนักศึกษา',
                      prefixIcon: Icon(Icons.badge),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'กรุณากรอกรหัสนักศึกษา',
                      ),
                      FormBuilderValidators.numeric(
                        errorText: 'ต้องเป็นตัวเลข',
                      ),
                      FormBuilderValidators.equalLength(
                        10,
                        errorText: 'ต้องเป็น 10 หลัก',
                      ),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderDateTimePicker(
                    name: 'birthdate',
                    initialValue: DateTime.now().subtract(
                      const Duration(days: 365 * 20),
                    ),
                    inputType: InputType.date,
                    format: DateFormat('dd/MM/yyyy'),
                    decoration: const InputDecoration(
                      labelText: 'วันเกิด',
                      prefixIcon: Icon(Icons.cake),
                    ),
                    validator: FormBuilderValidators.required(
                      errorText: 'กรุณาเลือกวันเกิด',
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormBuilderRadioGroup<String>(
                    name: 'gender',
                    initialValue: 'ชาย',
                    decoration: const InputDecoration(
                      labelText: 'เพศ',
                      prefixIcon: Icon(Icons.people),
                      border: InputBorder.none,
                    ),
                    options: const [
                      FormBuilderFieldOption(
                        value: 'ชาย',
                        child: Text('👨 ชาย'),
                      ),
                      FormBuilderFieldOption(
                        value: 'หญิง',
                        child: Text('👩 หญิง'),
                      ),
                      FormBuilderFieldOption(
                        value: 'อื่นๆ',
                        child: Text('🏳️‍⚧️ อื่นๆ'),
                      ),
                    ],
                    validator: FormBuilderValidators.required(
                      errorText: 'กรุณาเลือกเพศ',
                    ),
                  ),
                ]),

                _buildSection('ข้อมูลการติดต่อ', [
                  FormBuilderTextField(
                    name: 'email',
                    initialValue: 'student@example.com',
                    decoration: const InputDecoration(
                      labelText: 'อีเมล',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'กรุณากรอกอีเมล',
                      ),
                      FormBuilderValidators.email(
                        errorText: 'รูปแบบอีเมลไม่ถูกต้อง',
                      ),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'phone',
                    initialValue: '0812345678',
                    decoration: const InputDecoration(
                      labelText: 'เบอร์โทร',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'กรุณากรอกเบอร์โทร',
                      ),
                      FormBuilderValidators.numeric(
                        errorText: 'ต้องเป็นตัวเลข',
                      ),
                      FormBuilderValidators.minLength(
                        10,
                        errorText: 'อย่างน้อย 10 หลัก',
                      ),
                    ]),
                  ),
                ]),

                _buildSection('ข้อมูลการศึกษา', [
                  FormBuilderDropdown<String>(
                    name: 'major',
                    initialValue: 'วิทยาการคอมพิวเตอร์',
                    decoration: const InputDecoration(
                      labelText: 'สาขาวิชา',
                      prefixIcon: Icon(Icons.school),
                    ),
                    items:
                        [
                              '🖥️ วิทยาการคอมพิวเตอร์',
                              '⚙️ วิศวกรรมศาสตร์',
                              '💼 บริหารธุรกิจ',
                              '🎨 ศิลปศาสตร์',
                            ]
                            .map(
                              (major) => DropdownMenuItem(
                                value: major,
                                child: Text(major),
                              ),
                            )
                            .toList(),
                    validator: FormBuilderValidators.required(
                      errorText: 'กรุณาเลือกสาขาวิชา',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FormBuilderSlider(
                        name: 'gpa',
                        initialValue: 3.5,
                        min: 0.0,
                        max: 4.0,
                        divisions: 40,
                        decoration: const InputDecoration(
                          labelText: 'เกรดเฉลี่ย (GPA)',
                          border: InputBorder.none,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'กรุณาเลือก GPA',
                          ),
                          FormBuilderValidators.min(
                            0.0,
                            errorText: 'GPA ต้องไม่ต่ำกว่า 0',
                          ),
                          FormBuilderValidators.max(
                            4.0,
                            errorText: 'GPA ต้องไม่เกิน 4',
                          ),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderDateRangePicker(
                    name: 'study_period',
                    initialValue: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now().add(const Duration(days: 1460)),
                    ),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                    format: DateFormat('dd/MM/yyyy'),
                    decoration: const InputDecoration(
                      labelText: 'ช่วงเวลาศึกษา',
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    validator: FormBuilderValidators.required(
                      errorText: 'กรุณาเลือกช่วงเวลาศึกษา',
                    ),
                  ),
                ]),

                _buildSection('ความสนใจและทักษะ', [
                  FormBuilderCheckboxGroup<String>(
                    name: 'interests',
                    initialValue: const ['กีฬา', 'ดนตรี'],
                    decoration: const InputDecoration(
                      labelText: 'ความสนใจ',
                      border: InputBorder.none,
                    ),
                    options: const [
                      FormBuilderFieldOption(
                        value: 'กีฬา',
                        child: Text('⚽ กีฬา'),
                      ),
                      FormBuilderFieldOption(
                        value: 'ดนตรี',
                        child: Text('🎵 ดนตรี'),
                      ),
                      FormBuilderFieldOption(
                        value: 'อ่านหนังสือ',
                        child: Text('📚 อ่านหนังสือ'),
                      ),
                      FormBuilderFieldOption(
                        value: 'เทคโนโลยี',
                        child: Text('💻 เทคโนโลยี'),
                      ),
                    ],
                    validator: FormBuilderValidators.minLength(
                      1,
                      errorText: 'เลือกอย่างน้อย 1 รายการ',
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormBuilderField<List<String>>(
                    name: 'skills',
                    initialValue: const ['プログラミング', 'ออกแบบ'],
                    validator: FormBuilderValidators.minLength(
                      1,
                      errorText: 'เลือกอย่างน้อย 1 ทักษะ',
                    ),
                    builder: (FormFieldState<List<String>> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ทักษะพิเศษ',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12.0,
                            runSpacing: 8.0,
                            children: [
                              _SkillChip(
                                label: '💻 プログラミング',
                                value: 'プログラミング',
                                field: field,
                              ),
                              _SkillChip(
                                label: '🎨 ออกแบบ',
                                value: 'ออกแบบ',
                                field: field,
                              ),
                              _SkillChip(
                                label: '📈 การตลาด',
                                value: 'การตลาด',
                                field: field,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ]),

                _buildSection('ข้อมูลเพิ่มเติม', [
                  Card(
                    color: Theme.of(
                      context,
                    ).colorScheme.tertiaryContainer.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FormBuilderRangeSlider(
                        name: 'score_range',
                        initialValue: const RangeValues(50, 80),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        decoration: const InputDecoration(
                          labelText: 'ช่วงคะแนนสอบ (0-100)',
                          border: InputBorder.none,
                        ),
                        validator: FormBuilderValidators.required(
                          errorText: 'กรุณาเลือกช่วงคะแนน',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: FormBuilderSwitch(
                      name: 'is_member',
                      initialValue: true,
                      title: Row(
                        children: [
                          Icon(
                            Icons.group,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          const Text('สมัครสมาชิกชมรม'),
                        ],
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      validator: FormBuilderValidators.required(
                        errorText: 'กรุณาเลือกสถานะสมาชิก',
                      ),
                    ),
                  ),
                ]),

                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            final data = Map<String, dynamic>.from(
                              _formKey.currentState!.value,
                            );
                            data['birthdate'] = DateFormat(
                              'dd/MM/yyyy',
                            ).format(data['birthdate']);
                            data['study_period'] = {
                              'start': DateFormat(
                                'dd/MM/yyyy',
                              ).format(data['study_period'].start),
                              'end': DateFormat(
                                'dd/MM/yyyy',
                              ).format(data['study_period'].end),
                            };
                            data['score_range'] = {
                              'start': data['score_range'].start,
                              'end': data['score_range'].end,
                            };
                            await _saveStudentData(data);

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('บันทึกข้อมูลเรียบร้อยแล้ว!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('บันทึกข้อมูล'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('รีเซ็ต'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final String value;
  final FormFieldState<List<String>> field;

  const _SkillChip({
    required this.label,
    required this.value,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = field.value?.contains(value) ?? false;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        var newValue = List<String>.from(field.value ?? []);
        if (selected) {
          newValue.add(value);
        } else {
          newValue.remove(value);
        }
        field.didChange(newValue);
      },
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> _students = [];
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _loadStudents();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('students_json') ?? '[]';
    final List<dynamic> students = jsonDecode(jsonString);
    setState(() {
      _students = students.cast<Map<String, dynamic>>();
    });
    _animationController.forward();
  }

  void _showStudentDetails(BuildContext context, Map<String, dynamic> student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  student['name']?.toString().substring(0, 1) ?? '?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  student['name'] ?? 'ไม่ระบุชื่อ',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: student.entries.map((entry) {
                String valueStr = entry.value.toString();
                if (entry.value is Map) {
                  valueStr = jsonEncode(entry.value);
                } else if (entry.value is List) {
                  valueStr = (entry.value as List).join(', ');
                }

                IconData icon = _getIconForField(entry.key);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getFieldLabel(entry.key),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              valueStr,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              label: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }

  IconData _getIconForField(String field) {
    switch (field) {
      case 'name':
        return Icons.person;
      case 'student_id':
        return Icons.badge;
      case 'email':
        return Icons.email;
      case 'phone':
        return Icons.phone;
      case 'birthdate':
        return Icons.cake;
      case 'gender':
        return Icons.people;
      case 'interests':
        return Icons.favorite;
      case 'major':
        return Icons.school;
      case 'gpa':
        return Icons.grade;
      case 'score_range':
        return Icons.assessment;
      case 'is_member':
        return Icons.group;
      case 'study_period':
        return Icons.date_range;
      case 'skills':
        return Icons.star;
      default:
        return Icons.info;
    }
  }

  String _getFieldLabel(String field) {
    switch (field) {
      case 'name':
        return 'ชื่อ-นามสกุล';
      case 'student_id':
        return 'รหัสนักศึกษา';
      case 'email':
        return 'อีเมล';
      case 'phone':
        return 'เบอร์โทร';
      case 'birthdate':
        return 'วันเกิด';
      case 'gender':
        return 'เพศ';
      case 'interests':
        return 'ความสนใจ';
      case 'major':
        return 'สาขาวิชา';
      case 'gpa':
        return 'เกรดเฉลี่ย';
      case 'score_range':
        return 'ช่วงคะแนนสอบ';
      case 'is_member':
        return 'สมาชิกชมรม';
      case 'study_period':
        return 'ช่วงเวลาศึกษา';
      case 'skills':
        return 'ทักษะพิเศษ';
      default:
        return field;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('รายชื่อนักศึกษา'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        actions: [
          IconButton(onPressed: _loadStudents, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _students.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ยังไม่มีข้อมูลนักศึกษา',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'เพิ่มข้อมูลนักศึกษาคนแรกของคุณ',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/form'),
                    icon: const Icon(Icons.add),
                    label: const Text('เพิ่มนักศึกษา'),
                  ),
                ],
              ),
            )
          : AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    final student = _students[index];
                    final animation = Tween<double>(begin: 0.0, end: 1.0)
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              index * 0.1,
                              (index * 0.1) + 0.3,
                              curve: Curves.easeOut,
                            ),
                          ),
                        );

                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(animation),
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: Hero(
                              tag: 'student_$index',
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                child: Text(
                                  student['name']?.toString().substring(0, 1) ??
                                      '?',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              student['name'] ?? 'ไม่ระบุชื่อ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.badge,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'รหัส: ${student['student_id'] ?? 'ไม่ระบุ'}',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        student['major']?.toString().replaceAll(
                                              RegExp(
                                                r'[^\u0E00-\u0E7Fa-zA-Z\s]',
                                              ),
                                              '',
                                            ) ??
                                            'ไม่ระบุ',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.primary,
                              size: 16,
                            ),
                            onTap: () => _showStudentDetails(context, student),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/form'),
        icon: const Icon(Icons.add),
        label: const Text('เพิ่มนักศึกษา'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
