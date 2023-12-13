// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gym_tracker_flutter/config/get_it_config.dart';
// import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_bloc.dart';
// import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_event.dart';
// import 'package:gym_tracker_flutter/data/bloc/training_log/training_log_state.dart';
// import 'package:gym_tracker_flutter/data/services/training_log_service.dart';
// import 'package:gym_tracker_flutter/ui/progres_tracker/widgets/action_buttons-row.dart';
// import 'package:gym_tracker_flutter/ui/progres_tracker/widgets/progress_chart.dart';
// import 'package:gym_tracker_flutter/ui/progres_tracker/widgets/progress_log_list.dart';

// class ProgressTrackerScreen extends StatefulWidget {
//   @override
//   _ProgressTrackerScreenState createState() => _ProgressTrackerScreenState();
// }

// class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
//   bool _isChartVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Progress Tracker')),
//       body: BlocProvider(
//         create: (_) => TrainingLogBloc(getIt<TrainingLogService>())
//           ..add(FetchTrainingLogs(161)),
//         child: BlocBuilder<TrainingLogBloc, TrainingLogState>(
//           builder: (context, state) {
//             if (state is TrainingLogsLoaded) {
//               return Column(
//                 children: [
//                   _buildDateRangePicker(),
//                   _buildSortOptions(),
//                   Expanded(
//                       child: ProgressChartWidget(progressLogs: state.logs)),
//                 ],
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   void _fetchData() {
//     BlocProvider.of<TrainingLogBloc>(context).add(
//       FetchTrainingLogsByDateRange(selectedStartDate, selectedEndDate),
//     );
//   }
// }
