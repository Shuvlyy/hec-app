import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repill/l10n/app_localizations.dart';
import 'package:repill/providers/prescription_provider.dart';
import 'package:repill/models/prescription.dart';
import 'package:repill/models/medication.dart';
import 'package:repill/models/frequency.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class EditPrescriptionPage extends ConsumerStatefulWidget {
  final String? prescriptionId;
  const EditPrescriptionPage({super.key, this.prescriptionId});

  @override
  ConsumerState<EditPrescriptionPage> createState() => _EditPrescriptionPageState();
}

class MedicationFormState {
  final TextEditingController nameController;
  final TextEditingController dosageController;
  final TextEditingController timeController;
  Frequency frequency;

  MedicationFormState({
    TextEditingController? nameController,
    TextEditingController? dosageController,
    TextEditingController? timeController,
    this.frequency = Frequency.onceADay,
  })  : nameController = nameController ?? TextEditingController(),
        dosageController = dosageController ?? TextEditingController(),
        timeController = timeController ?? TextEditingController();

  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    timeController.dispose();
  }
}

class _EditPrescriptionPageState extends ConsumerState<EditPrescriptionPage> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  
  final List<MedicationFormState> _medications = [];
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    if (widget.prescriptionId != null) {
      final p = ref.read(prescriptionProvider).firstWhere((p) => p.id == widget.prescriptionId);
      _titleController.text = p.title;
      _dateController.text = DateFormat('yyyy-MM-dd').format(p.endDate);
      for (final m in p.medications) {
        _medications.add(MedicationFormState(
          nameController: TextEditingController(text: m.name),
          dosageController: TextEditingController(text: m.dosage),
          timeController: TextEditingController(text: m.time ?? ''),
          frequency: m.frequency,
        ));
      }
    } else {
      _addMedication();
    }
  }

  void _addMedication() {
    setState(() {
      _medications.add(MedicationFormState());
    });
  }

  void _removeMedication(int index) {
    if (_medications.length > 1) {
      setState(() {
        final removed = _medications.removeAt(index);
        removed.dispose();
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    for (var med in _medications) {
      med.dispose();
    }
    super.dispose();
  }

  Future<void> _simulateScan() async {
    setState(() => _isScanning = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isScanning = false;
      _titleController.text = "Cardiologie";
      
      // Clear existing and add scan results
      for (var med in _medications) {
        med.dispose();
      }
      _medications.clear();
      _medications.add(MedicationFormState(
        nameController: TextEditingController(text: "Kardegic"),
        dosageController: TextEditingController(text: "75mg"),
        timeController: TextEditingController(text: "09:00"),
        frequency: Frequency.onceADay,
      ));
      
      _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 90)));
    });
  }

  void _save() {
    final l10n = AppLocalizations.of(context)!;
    final uuid = const Uuid();
    
    final newPrescription = Prescription(
      id: widget.prescriptionId ?? uuid.v4(),
      title: _titleController.text,
      category: 'General',
      endDate: DateTime.tryParse(_dateController.text) ?? DateTime.now().add(const Duration(days: 30)),
      medications: _medications.map((m) => Medication(
        id: uuid.v4(),
        name: m.nameController.text,
        dosage: m.dosageController.text,
        frequency: m.frequency,
        time: m.timeController.text,
        instructions: l10n.takeWithMeal,
      )).toList(),
    );

    ref.read(prescriptionProvider.notifier).addPrescription(newPrescription);
    context.pop();
  }

  void _delete() {
    if (widget.prescriptionId != null) {
      ref.read(prescriptionProvider.notifier).deletePrescription(widget.prescriptionId!);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prescriptionId == null ? l10n.newPrescription : l10n.editPrescription),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.prescriptionId == null) ...[
              _buildScanButton(l10n),
              const Gap(32),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const Gap(32),
            ],
            _buildTextField(l10n.prescriptionTitle, "e.g., Diabetes", _titleController),
            const Gap(16),
            _buildTextField(l10n.prescriptionEndDate, "yyyy-mm-dd", _dateController),
            const Gap(32),
            ..._medications.asMap().entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _buildMedicationForm(l10n, entry.key, entry.value),
            )),
            OutlinedButton.icon(
              onPressed: _addMedication,
              icon: const Icon(Icons.add),
              label: const Text("Add another medication"),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFFF8C42),
                side: const BorderSide(color: Color(0xFFFF8C42)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const Gap(40),
            FilledButton(
              onPressed: _save,
              child: Text(l10n.savePrescription, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            if (widget.prescriptionId != null) ...[
              const Gap(16),
              TextButton.icon(
                onPressed: _delete,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text("Delete Prescription", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  overlayColor: Colors.red,
                ),
              ),
            ],
            const Gap(40),
          ],
        ),
      ),
    );
  }

  Widget _buildScanButton(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isScanning ? null : _simulateScan,
              icon: _isScanning
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.qr_code_scanner, size: 28),
              label: Text(_isScanning ? "Scanning..." : l10n.scanMyPrescription, style: const TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8C42),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFFF8C42).withOpacity(0.6),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          const Gap(16),
          Text(
            l10n.aiScanDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const Gap(8),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }

  Widget _buildMedicationForm(AppLocalizations l10n, int index, MedicationFormState medState) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Medication ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              if (_medications.length > 1)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.grey),
                  onPressed: () => _removeMedication(index),
                ),
            ],
          ),
          const Gap(16),
          _buildTextField(l10n.medicationName, "Ex: Tylenol", medState.nameController),
          const Gap(16),
          Row(
            children: [
              Expanded(child: _buildTextField(l10n.dosage, "Ex: 1000mg", medState.dosageController)),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.frequency, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Frequency>(
                          value: medState.frequency,
                          isExpanded: true,
                          items: Frequency.values.map((f) => DropdownMenuItem(
                            value: f,
                            child: Text(f.toDisplayString(l10n)),
                          )).toList(),
                          onChanged: (val) => setState(() => medState.frequency = val!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          _buildTextField(l10n.timeOptional, "--:--", medState.timeController),
        ],
      ),
    );
  }
}
