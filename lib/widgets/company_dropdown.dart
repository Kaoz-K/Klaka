import 'package:flutter/material.dart';
import '../services/company_data.dart';

class CompanyDropdown extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<CompanyInfo?> onSelected;
  final VoidCallback? onCustomNameEntered;

  const CompanyDropdown({
    super.key,
    required this.controller,
    required this.onSelected,
    this.onCustomNameEntered,
  });

  @override
  State<CompanyDropdown> createState() => _CompanyDropdownState();
}

class _CompanyDropdownState extends State<CompanyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<CompanyInfo>(
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return knownCompanies;
        }
        return searchCompanies(textEditingValue.text);
      },
      displayStringForOption: (option) => option.name,
      fieldViewBuilder: (context, fieldController, focusNode, onFieldSubmitted) {
        // Sync our external controller with the field controller
        if (fieldController.text != widget.controller.text) {
          fieldController.text = widget.controller.text;
        }
        fieldController.addListener(() {
          if (widget.controller.text != fieldController.text) {
            widget.controller.text = fieldController.text;
            // Notify that a custom name was typed (not selected from list)
            widget.onCustomNameEntered?.call();
          }
        });

        return TextField(
          controller: fieldController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            labelText: 'Bedrijfsnaam',
            hintText: 'Zoek of typ een bedrijfsnaam',
            prefixIcon: Icon(Icons.store),
          ),
          onSubmitted: (_) => onFieldSubmitted(),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    title: Text(option.name),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
      onSelected: (company) {
        widget.controller.text = company.name;
        widget.onSelected(company);
      },
    );
  }
}
