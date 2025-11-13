// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:intl/intl.dart';
// import 'package:qms_tv_app/core/constants/app_colors.dart';
// import 'package:qms_tv_app/core/extensions/sizedbox_extension.dart';
// import 'package:qms_tv_app/core/router/app_routes.dart';
// import 'package:qms_tv_app/presentation/features/auth/provider/login_provider.dart';
// import 'package:qms_tv_app/presentation/features/patients/models/patient_model.dart';
// import 'package:qms_tv_app/presentation/features/patients/provider/patients_provider.dart';
// import 'package:qms_tv_app/presentation/widgets/custom_scaffold.dart';

// /// TV Display Screen for showing called patients in a hospital queue
// class TvDisplayScreen extends ConsumerStatefulWidget {
//   const TvDisplayScreen({super.key});

//   @override
//   ConsumerState<TvDisplayScreen> createState() => _TvDisplayScreenState();
// }

// class _TvDisplayScreenState extends ConsumerState<TvDisplayScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _pulseController;
//   late Animation<double> _pulseAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);
//     _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _pulseController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final patientsAsync = ref.watch(patientsProvider);
//     final loginState = ref.watch(loginProvider);

//     return CustomScaffold(
//       backgroundColor: const Color(0xFF0F172A), // Dark blue background
//       body: Column(
//         children: [
//           // Header
//           _buildHeader(context, loginState.value?.user?.name ?? 'User'),

//           // Content
//           Expanded(
//             child: patientsAsync.when(
//               data: (patients) {
//                 if (patients.isEmpty) {
//                   return _buildEmptyState();
//                 }
//                 return _buildPatientsList(patients);
//               },
//               loading: () => _buildLoadingState(),
//               error: (error, stack) => _buildErrorState(error),
//             ),
//           ),

//           // Footer
//           _buildFooter(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context, String userName) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.kPrimaryColor,
//             AppColors.kPrimaryColor.withOpacity(0.85),
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Logo/Icon with animation
//           AnimatedBuilder(
//             animation: _pulseAnimation,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _pulseAnimation.value,
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.3),
//                         blurRadius: 15,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: const Icon(
//                     Iconsax.hospital,
//                     size: 44,
//                     color: AppColors.kPrimaryColor,
//                   ),
//                 ),
//               );
//             },
//           ),
//           24.widthBox,
//           // Title
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hospital Queue Management System',
//                   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                     fontSize: 28,
//                   ),
//                 ),
//                 8.heightBox,
//                 Row(
//                   children: [
//                     Container(
//                       width: 8,
//                       height: 8,
//                       decoration: const BoxDecoration(
//                         color: Colors.greenAccent,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     8.widthBox,
//                     Text(
//                       'Live Patient Display • Auto-Refresh Every 10s',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: Colors.white.withOpacity(0.95),
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Current Time
//           _buildLiveTime(),
//           32.widthBox,
//           // User info and logout
//           _buildUserInfo(context, userName),
//         ],
//       ),
//     );
//   }

//   Widget _buildLiveTime() {
//     return StreamBuilder(
//       stream: Stream.periodic(const Duration(seconds: 1)),
//       builder: (context, snapshot) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.15),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
//           ),
//           child: Row(
//             children: [
//               const Icon(Iconsax.clock, color: Colors.white, size: 24),
//               12.widthBox,
//               Text(
//                 DateFormat('HH:mm:ss').format(DateTime.now()),
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   fontFeatures: [const FontFeature.tabularFigures()],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildUserInfo(BuildContext context, String userName) {
//     return PopupMenuButton<String>(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Iconsax.user,
//                 color: AppColors.kPrimaryColor,
//                 size: 18,
//               ),
//             ),
//             12.widthBox,
//             Text(
//               userName,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//             8.widthBox,
//             const Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.white,
//               size: 24,
//             ),
//           ],
//         ),
//       ),
//       onSelected: (value) {
//         if (value == 'logout') {
//           _handleLogout();
//         }
//       },
//       itemBuilder: (context) => [
//         const PopupMenuItem(
//           value: 'logout',
//           child: Row(
//             children: [
//               Icon(Iconsax.logout, size: 20, color: Colors.red),
//               SizedBox(width: 12),
//               Text('Logout', style: TextStyle(fontWeight: FontWeight.w500)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _handleLogout() async {
//     await ref.read(loginProvider.notifier).logout();
//     if (mounted) {
//       context.go(kLoginRoute);
//     }
//   }

//   Widget _buildPatientsList(List<PatientModel> patients) {
//     return Container(
//       margin: const EdgeInsets.all(28),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E293B),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Table Header
//           _buildTableHeader(),
//           // Divider
//           Container(
//             height: 2,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.transparent,
//                   AppColors.kPrimaryColor.withOpacity(0.5),
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//           ),
//           // Table Body
//           Expanded(
//             child: ListView.separated(
//               padding: const EdgeInsets.all(12),
//               itemCount: patients.length,
//               separatorBuilder: (context, index) => 8.heightBox,
//               itemBuilder: (context, index) {
//                 return _buildPatientCard(patients[index], index);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTableHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF334155),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Row(
//         children: [
//           _buildHeaderCell('#', flex: 1),
//           _buildHeaderCell('Ticket', flex: 2),
//           _buildHeaderCell('Patient Information', flex: 4),
//           _buildHeaderCell('Department', flex: 2),
//           _buildHeaderCell('Status', flex: 2),
//           _buildHeaderCell('Called At', flex: 2),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeaderCell(String title, {int flex = 1}) {
//     return Expanded(
//       flex: flex,
//       child: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 18,
//           letterSpacing: 0.5,
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientCard(PatientModel patient, int index) {
//     final statusColor = _getStatusColor(patient.status);
//     final isUrgent = patient.status.toLowerCase() == 'urgent';

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: isUrgent
//             ? LinearGradient(
//                 colors: [
//                   Colors.red.withOpacity(0.15),
//                   Colors.red.withOpacity(0.05),
//                 ],
//               )
//             : null,
//         color: isUrgent ? null : const Color(0xFF475569).withOpacity(0.3),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isUrgent
//               ? Colors.red.withOpacity(0.6)
//               : statusColor.withOpacity(0.3),
//           width: isUrgent ? 3 : 2,
//         ),
//         boxShadow: isUrgent
//             ? [
//                 BoxShadow(
//                   color: Colors.red.withOpacity(0.3),
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                 ),
//               ]
//             : null,
//       ),
//       child: Row(
//         children: [
//           // Index
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Text(
//                 '${index + 1}',
//                 style: TextStyle(
//                   color: isUrgent ? Colors.red : Colors.white70,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           // Ticket Number
//           Expanded(
//             flex: 2,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.kPrimaryColor,
//                     AppColors.kPrimaryColor.withOpacity(0.8),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.kPrimaryColor.withOpacity(0.3),
//                     blurRadius: 8,
//                     spreadRadius: 1,
//                   ),
//                 ],
//               ),
//               child: Text(
//                 '#${patient.ticketNumber}',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           12.widthBox,
//           // Patient Information
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Iconsax.user,
//                       size: 18,
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                     8.widthBox,
//                     Expanded(
//                       child: Text(
//                         patient.name,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 8.heightBox,
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(6),
//                         border: Border.all(color: Colors.blue.withOpacity(0.4)),
//                       ),
//                       child: Text(
//                         'MRN: ${patient.mrnNumber}',
//                         style: const TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     12.widthBox,
//                     Icon(
//                       patient.sex.toLowerCase() == 'male'
//                           ? Iconsax.man
//                           : Iconsax.woman,
//                       size: 16,
//                       color: Colors.white60,
//                     ),
//                     4.widthBox,
//                     Text(
//                       '${patient.age}Y • ${patient.sex}',
//                       style: const TextStyle(
//                         color: Colors.white60,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           12.widthBox,
//           // Department
//           Expanded(
//             flex: 2,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.purple.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.purple.withOpacity(0.5)),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Iconsax.building, color: Colors.purple, size: 18),
//                   4.heightBox,
//                   Text(
//                     patient.department.deptname,
//                     style: const TextStyle(
//                       color: Colors.purple,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           12.widthBox,
//           // Status
//           Expanded(
//             flex: 2,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: statusColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: statusColor, width: 2),
//                 boxShadow: isUrgent
//                     ? [
//                         BoxShadow(
//                           color: statusColor.withOpacity(0.4),
//                           blurRadius: 8,
//                         ),
//                       ]
//                     : null,
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     _getStatusIcon(patient.status),
//                     color: statusColor,
//                     size: 24,
//                   ),
//                   6.heightBox,
//                   Text(
//                     patient.status.toUpperCase(),
//                     style: TextStyle(
//                       color: statusColor,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           12.widthBox,
//           // Call Time
//           Expanded(
//             flex: 2,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.teal.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.teal.withOpacity(0.4)),
//               ),
//               child: Column(
//                 children: [
//                   const Icon(Iconsax.clock, color: Colors.teal, size: 20),
//                   6.heightBox,
//                   Text(
//                     patient.firstCallTime != null
//                         ? DateFormat(
//                             'HH:mm:ss',
//                           ).format(DateTime.parse(patient.firstCallTime!))
//                         : '--:--:--',
//                     style: const TextStyle(
//                       color: Colors.teal,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       fontFeatures: [FontFeature.tabularFigures()],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'urgent':
//         return Colors.red;
//       case 'normal':
//         return Colors.green;
//       case 'waiting':
//         return Colors.orange;
//       case 'in progress':
//       case 'in-progress':
//         return Colors.blue;
//       default:
//         return Colors.grey;
//     }
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'urgent':
//         return Iconsax.warning_2;
//       case 'normal':
//         return Iconsax.tick_circle;
//       case 'waiting':
//         return Iconsax.clock;
//       case 'in progress':
//       case 'in-progress':
//         return Iconsax.refresh;
//       default:
//         return Iconsax.info_circle;
//     }
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.all(60),
//         margin: const EdgeInsets.all(32),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1E293B),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Iconsax.clipboard_text,
//                 size: 100,
//                 color: Colors.blue.withOpacity(0.5),
//               ),
//             ),
//             32.heightBox,
//             Text(
//               'No Called Patients',
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 32,
//               ),
//             ),
//             16.heightBox,
//             Text(
//               'Waiting for patients to be called...',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 color: Colors.white60,
//                 fontSize: 18,
//               ),
//             ),
//             24.heightBox,
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AnimatedBuilder(
//                     animation: _pulseController,
//                     builder: (context, child) {
//                       return Icon(
//                         Iconsax.refresh,
//                         color: Colors.green,
//                         size: 20,
//                       );
//                     },
//                   ),
//                   8.widthBox,
//                   const Text(
//                     'System is running • Auto-refresh active',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingState() {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.all(60),
//         margin: const EdgeInsets.all(32),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1E293B),
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: 80,
//               height: 80,
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(
//                   AppColors.kPrimaryColor,
//                 ),
//                 strokeWidth: 6,
//               ),
//             ),
//             32.heightBox,
//             Text(
//               'Loading Patients...',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24,
//               ),
//             ),
//             12.heightBox,
//             Text(
//               'Please wait while we fetch the latest data',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 color: Colors.white60,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState(Object error) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.all(60),
//         margin: const EdgeInsets.all(32),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1E293B),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: AppColors.kErrorColor.withOpacity(0.3),
//             width: 2,
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Iconsax.warning_2,
//                 size: 100,
//                 color: AppColors.kErrorColor,
//               ),
//             ),
//             32.heightBox,
//             Text(
//               'Error Loading Patients',
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 32,
//               ),
//             ),
//             16.heightBox,
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 error.toString(),
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   color: Colors.red.shade300,
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             32.heightBox,
//             ElevatedButton.icon(
//               onPressed: () {
//                 ref.invalidate(patientsProvider);
//               },
//               icon: const Icon(Iconsax.refresh, size: 24),
//               label: const Text(
//                 'Retry',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.kPrimaryColor,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 40,
//                   vertical: 20,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFooter() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E293B),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               AnimatedBuilder(
//                 animation: _pulseAnimation,
//                 builder: (context, child) {
//                   return Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.green.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: Colors.green.withOpacity(0.5),
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Transform.rotate(
//                           angle: _pulseController.value * 2 * 3.14159,
//                           child: const Icon(
//                             Iconsax.refresh,
//                             color: Colors.green,
//                             size: 20,
//                           ),
//                         ),
//                         12.widthBox,
//                         const Text(
//                           'Auto-refresh: Every 10 seconds',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               24.widthBox,
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.kPrimaryColor.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: AppColors.kPrimaryColor.withOpacity(0.5),
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Iconsax.hospital,
//                       color: AppColors.kPrimaryColor,
//                       size: 18,
//                     ),
//                     8.widthBox,
//                     const Text(
//                       'Hospital Queue Management System',
//                       style: TextStyle(
//                         color: AppColors.kPrimaryColor,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Iconsax.calendar, color: Colors.white60, size: 18),
//                 8.widthBox,
//                 Text(
//                   DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
