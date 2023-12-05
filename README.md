# Gym Tracker Flutter

## Introduction

**Gym Tracker Flutter** is a comprehensive Flutter application designed to help fitness enthusiasts and gym-goers track their training routines, progress, and workout sessions efficiently. Built with a clean and user-friendly interface, this app offers a range of features to enhance your training experience.

## Features

- **User Authentication**: Secure login and registration functionality.
- **Training Logs**: Keep track of your workout history and progress.
- **Training Routines**: Create and manage personalized workout routines.
- **Training Sessions**: Log your exercises, reps, and sets in real-time.
- **Progress Tracking**: Visualize your progress with detailed charts and statistics.
- **User Profile**: Customize your user profile and settings.

## Project Structure

Below is the project directory structure which highlights the main components of the Gym Tracker Flutter app:

```
├─ lib
│ ├─ config
│ │ └─ get_it_config.dart
│ ├─ data
│ │ ├─ bloc
│ │ │ ├─ training_log
│ │ │ │ ├─ training_log_bloc.dart
│ │ │ │ ├─ training_log_event.dart
│ │ │ │ └─ training_log_state.dart
│ │ │ ├─ training_routine
│ │ │ │ ├─ training_routine_bloc.dart
│ │ │ │ ├─ training_routine_event.dart
│ │ │ │ └─ training_routine_state.dart
│ │ │ ├─ training_session
│ │ │ │ ├─ training_session_bloc.dart
│ │ │ │ ├─ training_session_event.dart
│ │ │ │ └─ training_session_state.dart
│ │ │ └─ user_cubit.dart
│ │ ├─ models
│ │ │ ├─ exercise.dart
│ │ │ ├─ training_log.dart
│ │ │ ├─ training_routine.dart
│ │ │ └─ training_session.dart
│ │ └─ services
│ │ ├─ auth_service.dart
│ │ ├─ training_log_service.dart
│ │ ├─ training_routine_service.dart
│ │ └─ training_session_service.dart
│ ├─ main.dart
│ ├─ token
│ │ ├─ token_receiver.dart
│ │ └─ token_storage.dart
│ ├─ ui
│ │ ├─ auth
│ │ │ ├─ auth_screen.dart
│ │ │ ├─ form_handler.dart
│ │ │ └─ widgets
│ │ │ ├─ alternative_action.dart
│ │ │ ├─ authentication_button.dart
│ │ │ ├─ authentication_form.dart
│ │ │ ├─ custom_text_field.dart
│ │ │ ├─ error_dialog.dart
│ │ │ ├─ gym_diary_logo.dart
│ │ │ ├─ logo_section.dart
│ │ │ ├─ short_description.dart
│ │ │ └─ social_icons_field.dart
│ │ ├─ main_dashboard
│ │ │ ├─ home_page.dart
│ │ │ └─ widgets
│ │ │ ├─ progress_tracker.dart
│ │ │ ├─ recent_training_sessions-display.dart
│ │ │ ├─ recent_workouts_header.dart
│ │ │ ├─ user-training-routines.dart
│ │ │ ├─ user_training_routines.dart
│ │ │ ├─ user_welcome_panel.dart
│ │ │ └─ workout_count.dart
│ │ ├─ navi_bar
│ │ │ └─ navigation_bottom_bar.dart
│ │ ├─ progres_tracker
│ │ │ ├─ progress_tracker.dart
│ │ │ └─ widgets
│ │ │ ├─ action_buttons-row.dart
│ │ │ ├─ progress_chart.dart
│ │ │ └─ progress_log_list.dart
│ │ ├─ settings
│ │ │ └─ settings_page.dart
│ │ ├─ training-routine
│ │ │ ├─ training_routine_creator
│ │ │ │ ├─ training_routine_creator_page.dart
│ │ │ │ └─ widgets
│ │ │ │ ├─ add_exercise_button.dart
│ │ │ │ ├─ back_button.dart
│ │ │ │ ├─ dismissible_exercise.dart
│ │ │ │ ├─ dismissible_routine_form.dart
│ │ │ │ └─ submit_button.dart
│ │ │ ├─ training_routine_page.dart
│ │ │ └─ widgets
│ │ │ ├─ back_to_home_button.dart
│ │ │ ├─ create_routine_button.dart
│ │ │ ├─ training_routine_card.dart
│ │ │ └─ training_routine_detail_dialog.dart
│ │ ├─ training_session
│ │ │ ├─ training_session_creator
│ │ │ │ ├─ exercise_controllers.dart
│ │ │ │ ├─ training_session_creator_page.dart
│ │ │ │ └─ widgets
│ │ │ │ ├─ exercise_card_builder.dart
│ │ │ │ ├─ exercise_set_row.dart
│ │ │ │ ├─ finish_workout_button.dart
│ │ │ │ ├─ routine-name-displayer.dart
│ │ │ │ ├─ routine_exercises_displayer.dart
│ │ │ │ ├─ timer-display-widget.dart
│ │ │ │ ├─ timer_displayer.dart
│ │ │ │ └─ workout_summary.dart
│ │ │ └─ training_session_details
│ │ │ ├─ training_session_logs_page.dart
│ │ │ └─ widgets
│ │ │ ├─ back_button.dart
│ │ │ ├─ training_log_card.dart
│ │ │ └─ training_log_list.dart
│ │ └─ user_profile
│ │ └─ user_profile_screen.dart
│ └─ utills
│ ├─ global_variables.dart
│ └─ time_provider.dart

```

This structure organizes the app's functionality into distinct modules for ease of development and maintenance.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/zephir0/gym_tracker_flutter.git
   ```
2. Navigate to the project directory:

   ```bash
   cd gym_tracker_flutter
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! If you'd like to contribute, please follow these steps:

- Fork the repository.
- Create a new branch (git checkout -b feature-branch).
- Make your changes and commit them (git commit -am 'Add some feature').
- Push to the branch (git push origin feature-branch).
- Create a new Pull Request.
