import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:qms_tv_app/core/constants/app_colors.dart';
import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';

/// Desktop/TV version of patient card - Large prominent display layout
class PatientCardDesktop extends StatefulWidget {
  final PatientModel patient;
  final int index;
  final Color statusColor;
  final IconData statusIcon;

  const PatientCardDesktop({
    super.key,
    required this.patient,
    required this.index,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  State<PatientCardDesktop> createState() => _PatientCardDesktopState();
}

class _PatientCardDesktopState extends State<PatientCardDesktop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 620),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.kDarkSurfaceColor,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: widget.statusColor.withValues(alpha: 0.5),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.statusColor.withValues(alpha: 0.25),
                  blurRadius: 40,
                  spreadRadius: 8,
                  offset: const Offset(0, 20),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ticket Number Label
                Text(
                  'Ticket Number',
                  style: TextStyle(
                    color: AppColors.kDarkTextTertiaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.heightBox,
                // Ticket Number Container with Gradient
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.kPrimaryColor,
                        AppColors.kPrimaryLightColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kPrimaryColor.withValues(alpha: 0.5),
                        blurRadius: 24,
                        spreadRadius: 4,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.patient.ticketNumber.toString(),
                    style: const TextStyle(
                      color: AppColors.kTextOnPrimaryColor,
                      fontSize: 72,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                28.heightBox,
                // Patient Name
                Text(
                  widget.patient.name,
                  style: const TextStyle(
                    color: AppColors.kTextOnPrimaryColor,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                18.heightBox,
                // Department Badge
                if (widget.patient.department != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.kInfoColor.withValues(alpha: 0.2),
                          AppColors.kInfoColor.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.kInfoColor.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Iconsax.hospital,
                          color: AppColors.kInfoColor,
                          size: 24,
                        ),
                        14.widthBox,
                        Text(
                          widget.patient.department?.deptname ?? 'N/A',
                          style: const TextStyle(
                            color: AppColors.kInfoColor,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                24.heightBox,
                // Divider
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.kDarkTextTertiaryColor.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                24.heightBox,
                // Status and Instructions
                Text(
                  'PLEASE PROCEED TO',
                  style: TextStyle(
                    color: AppColors.kDarkTextTertiaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                16.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: widget.statusColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: widget.statusColor.withValues(alpha: 0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.statusColor.withValues(alpha: 0.1),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        widget.statusIcon,
                        color: widget.statusColor,
                        size: 44,
                      ),
                      10.heightBox,
                      Text(
                        widget.patient.status.toUpperCase(),
                        style: TextStyle(
                          color: widget.statusColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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

/// Desktop/TV version of patient card - Large prominent display layout (OLD - for reference)
class PatientCardDesktopOld extends StatelessWidget {
  final PatientModel patient;
  final int index;
  final Color statusColor;
  final IconData statusIcon;

  const PatientCardDesktopOld({
    super.key,
    required this.patient,
    required this.index,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.kDarkSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 3),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.2),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          // Left: Ticket Number - Large and Prominent
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ticket #',
                  style: TextStyle(
                    color: AppColors.kDarkTextTertiaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                8.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    patient.ticketNumber.toString(),
                    style: const TextStyle(
                      color: AppColors.kTextOnPrimaryColor,
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          24.widthBox,
          // Middle: Patient Details
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Patient Name
                Text(
                  patient.name,
                  style: const TextStyle(
                    color: AppColors.kTextOnPrimaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                12.heightBox,
                // MRN
                Row(
                  children: [
                    const Icon(
                      Iconsax.user,
                      color: AppColors.kInfoColor,
                      size: 24,
                    ),
                    12.widthBox,
                    Text(
                      'MRN: ${patient.mrnNumber}',
                      style: const TextStyle(
                        color: AppColors.kDarkTextSecondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                12.heightBox,
                // Department
                if (patient.department != null)
                  Row(
                    children: [
                      const Icon(
                        Iconsax.hospital,
                        color: AppColors.kInfoColor,
                        size: 24,
                      ),
                      12.widthBox,
                      Text(
                        patient.department?.deptname ?? 'N/A',
                        style: const TextStyle(
                          color: AppColors.kInfoColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          24.widthBox,
          // Right: Status and Time
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.6),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 40),
                      8.heightBox,
                      Text(
                        patient.status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                24.heightBox,
                // Call Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Iconsax.clock,
                      color: AppColors.kDarkTextTertiaryColor,
                      size: 24,
                    ),
                    8.widthBox,
                    Text(
                      patient.firstCallTime != null
                          ? DateFormat(
                              'HH:mm',
                            ).format(DateTime.parse(patient.firstCallTime!))
                          : '--:--',
                      style: const TextStyle(
                        color: AppColors.kDarkTextSecondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Mobile version of patient card - vertical card layout
class PatientCardMobile extends StatelessWidget {
  final PatientModel patient;
  final int index;
  final Color statusColor;
  final IconData statusIcon;

  const PatientCardMobile({
    super.key,
    required this.patient,
    required this.index,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kDarkSurfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row - Ticket and Status
          Row(
            children: [
              // Ticket Number
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Iconsax.ticket,
                      color: AppColors.kTextOnPrimaryColor,
                      size: 16,
                    ),
                    6.widthBox,
                    Text(
                      '#${patient.ticketNumber}',
                      style: const TextStyle(
                        color: AppColors.kTextOnPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 14),
                    4.widthBox,
                    Text(
                      patient.status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.heightBox,
          // Patient Name
          Text(
            patient.name,
            style: const TextStyle(
              color: AppColors.kTextOnPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.heightBox,
          // Patient Details
          _buildInfoRow(
            icon: Iconsax.user_octagon,
            label: 'MRN',
            value: patient.mrnNumber,
          ),
          8.heightBox,
          _buildInfoRow(
            icon: Iconsax.hospital,
            label: 'Department',
            value: patient.department?.deptname ?? 'N/A',
            valueColor: AppColors.kInfoColor,
          ),
          8.heightBox,
          _buildInfoRow(
            icon: Iconsax.clock,
            label: 'Called At',
            value: patient.firstCallTime != null
                ? DateFormat(
                    'HH:mm',
                  ).format(DateTime.parse(patient.firstCallTime!))
                : 'Not called yet',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.kDarkTextTertiaryColor, size: 16),
        8.widthBox,
        Text(
          '$label: ',
          style: const TextStyle(
            color: AppColors.kDarkTextSecondaryColor,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColors.kTextOnPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// Side panel patient card - Compact display for sidebar
class PatientCardSide extends StatefulWidget {
  final PatientModel patient;
  final int index;
  final Color statusColor;
  final IconData statusIcon;

  const PatientCardSide({
    super.key,
    required this.patient,
    required this.index,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  State<PatientCardSide> createState() => _PatientCardSideState();
}

class _PatientCardSideState extends State<PatientCardSide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(_controller),
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.kDarkSurfaceColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.statusColor.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.statusColor.withValues(alpha: 0.15),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ticket Number - Highlighted
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.kPrimaryColor.withValues(alpha: 0.2),
                      AppColors.kPrimaryColor.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.patient.ticketNumber.toString(),
                  style: const TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              10.heightBox,
              // Patient Name
              Text(
                widget.patient.name,
                style: const TextStyle(
                  color: AppColors.kTextOnPrimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              10.heightBox,
              // Department
              if (widget.patient.department != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kInfoColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.patient.department?.deptname ?? 'N/A',
                    style: const TextStyle(
                      color: AppColors.kInfoColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              10.heightBox,
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: widget.statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.statusColor.withValues(alpha: 0.4),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.statusColor.withValues(alpha: 0.08),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.statusIcon,
                      color: widget.statusColor,
                      size: 16,
                    ),
                    6.widthBox,
                    Text(
                      widget.patient.status.toUpperCase(),
                      style: TextStyle(
                        color: widget.statusColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovering) {
    // Hover effects can be added here for desktop
  }
}

/// Old Side panel version of patient card - compact layout for side display
class PatientCardSideOld extends StatelessWidget {
  final PatientModel patient;
  final int index;
  final Color statusColor;
  final IconData statusIcon;

  const PatientCardSideOld({
    super.key,
    required this.patient,
    required this.index,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kDarkSurfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ticket Number - Compact
          Text(
            'Ticket #',
            style: TextStyle(
              color: AppColors.kDarkTextTertiaryColor,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          4.heightBox,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              patient.ticketNumber.toString(),
              style: const TextStyle(
                color: AppColors.kTextOnPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          8.heightBox,
          // Patient Name - Compact
          Text(
            patient.name,
            style: const TextStyle(
              color: AppColors.kTextOnPrimaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          6.heightBox,
          // Department
          if (patient.department != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.kInfoColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                patient.department?.deptname ?? 'N/A',
                style: const TextStyle(
                  color: AppColors.kInfoColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          6.heightBox,
          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: statusColor.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Icon(statusIcon, color: statusColor, size: 16),
                2.heightBox,
                Text(
                  patient.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
