# Details

Date : 2023-12-13 23:44:30

Directory c:\\Users\\kryst\\IdeaProjects\\GymTracker_MobileApp\\gym_tracker_flutter\\lib

Total : 97 files,  5487 codes, 59 comments, 614 blanks, all 6160 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/config/get_it_config.dart](/lib/config/get_it_config.dart) | Dart | 10 | 0 | 3 | 13 |
| [lib/data/bloc/training_log/training_log_bloc.dart](/lib/data/bloc/training_log/training_log_bloc.dart) | Dart | 31 | 0 | 5 | 36 |
| [lib/data/bloc/training_log/training_log_event.dart](/lib/data/bloc/training_log/training_log_event.dart) | Dart | 9 | 0 | 5 | 14 |
| [lib/data/bloc/training_log/training_log_state.dart](/lib/data/bloc/training_log/training_log_state.dart) | Dart | 8 | 0 | 6 | 14 |
| [lib/data/bloc/training_routine/training_routine_bloc.dart](/lib/data/bloc/training_routine/training_routine_bloc.dart) | Dart | 38 | 0 | 8 | 46 |
| [lib/data/bloc/training_routine/training_routine_event.dart](/lib/data/bloc/training_routine/training_routine_event.dart) | Dart | 10 | 0 | 6 | 16 |
| [lib/data/bloc/training_routine/training_routine_state.dart](/lib/data/bloc/training_routine/training_routine_state.dart) | Dart | 10 | 0 | 8 | 18 |
| [lib/data/bloc/training_session/training_session_bloc.dart](/lib/data/bloc/training_session/training_session_bloc.dart) | Dart | 49 | 0 | 7 | 56 |
| [lib/data/bloc/training_session/training_session_event.dart](/lib/data/bloc/training_session/training_session_event.dart) | Dart | 10 | 0 | 6 | 16 |
| [lib/data/bloc/training_session/training_session_state.dart](/lib/data/bloc/training_session/training_session_state.dart) | Dart | 9 | 0 | 6 | 15 |
| [lib/data/bloc/user_cubit.dart](/lib/data/bloc/user_cubit.dart) | Dart | 27 | 0 | 6 | 33 |
| [lib/data/models/exercise.dart](/lib/data/models/exercise.dart) | Dart | 26 | 0 | 2 | 28 |
| [lib/data/models/training_log.dart](/lib/data/models/training_log.dart) | Dart | 23 | 1 | 2 | 26 |
| [lib/data/models/training_routine.dart](/lib/data/models/training_routine.dart) | Dart | 23 | 0 | 5 | 28 |
| [lib/data/models/training_session.dart](/lib/data/models/training_session.dart) | Dart | 20 | 0 | 2 | 22 |
| [lib/data/services/auth_service.dart](/lib/data/services/auth_service.dart) | Dart | 84 | 0 | 9 | 93 |
| [lib/data/services/training_log_service.dart](/lib/data/services/training_log_service.dart) | Dart | 41 | 0 | 8 | 49 |
| [lib/data/services/training_routine_service.dart](/lib/data/services/training_routine_service.dart) | Dart | 47 | 0 | 12 | 59 |
| [lib/data/services/training_session_service.dart](/lib/data/services/training_session_service.dart) | Dart | 64 | 0 | 8 | 72 |
| [lib/main.dart](/lib/main.dart) | Dart | 33 | 0 | 4 | 37 |
| [lib/token/token_receiver.dart](/lib/token/token_receiver.dart) | Dart | 12 | 0 | 2 | 14 |
| [lib/token/token_storage.dart](/lib/token/token_storage.dart) | Dart | 14 | 0 | 6 | 20 |
| [lib/ui/auth/auth_page.dart](/lib/ui/auth/auth_page.dart) | Dart | 142 | 0 | 11 | 153 |
| [lib/ui/auth/form_handler.dart](/lib/ui/auth/form_handler.dart) | Dart | 34 | 0 | 6 | 40 |
| [lib/ui/auth/widgets/alternative_action.dart](/lib/ui/auth/widgets/alternative_action.dart) | Dart | 80 | 0 | 8 | 88 |
| [lib/ui/auth/widgets/authentication_button.dart](/lib/ui/auth/widgets/authentication_button.dart) | Dart | 43 | 0 | 2 | 45 |
| [lib/ui/auth/widgets/authentication_form.dart](/lib/ui/auth/widgets/authentication_form.dart) | Dart | 34 | 0 | 6 | 40 |
| [lib/ui/auth/widgets/custom_text_field.dart](/lib/ui/auth/widgets/custom_text_field.dart) | Dart | 82 | 0 | 9 | 91 |
| [lib/ui/auth/widgets/error_dialog.dart](/lib/ui/auth/widgets/error_dialog.dart) | Dart | 38 | 0 | 2 | 40 |
| [lib/ui/auth/widgets/gym_diary_logo.dart](/lib/ui/auth/widgets/gym_diary_logo.dart) | Dart | 12 | 0 | 2 | 14 |
| [lib/ui/auth/widgets/logo_section.dart](/lib/ui/auth/widgets/logo_section.dart) | Dart | 19 | 0 | 2 | 21 |
| [lib/ui/auth/widgets/short_description.dart](/lib/ui/auth/widgets/short_description.dart) | Dart | 48 | 0 | 6 | 54 |
| [lib/ui/auth/widgets/social_icons_field.dart](/lib/ui/auth/widgets/social_icons_field.dart) | Dart | 30 | 0 | 2 | 32 |
| [lib/ui/main_dashboard/home_page.dart](/lib/ui/main_dashboard/home_page.dart) | Dart | 111 | 0 | 13 | 124 |
| [lib/ui/main_dashboard/widgets/progress_tracker.dart](/lib/ui/main_dashboard/widgets/progress_tracker.dart) | Dart | 66 | 0 | 7 | 73 |
| [lib/ui/main_dashboard/widgets/recent_training_sessions-display.dart](/lib/ui/main_dashboard/widgets/recent_training_sessions-display.dart) | Dart | 179 | 0 | 17 | 196 |
| [lib/ui/main_dashboard/widgets/recent_workouts_header.dart](/lib/ui/main_dashboard/widgets/recent_workouts_header.dart) | Dart | 76 | 0 | 8 | 84 |
| [lib/ui/main_dashboard/widgets/user-training-routines.dart](/lib/ui/main_dashboard/widgets/user-training-routines.dart) | Dart | 74 | 0 | 10 | 84 |
| [lib/ui/main_dashboard/widgets/user_training_routines.dart](/lib/ui/main_dashboard/widgets/user_training_routines.dart) | Dart | 74 | 0 | 10 | 84 |
| [lib/ui/main_dashboard/widgets/user_welcome_panel.dart](/lib/ui/main_dashboard/widgets/user_welcome_panel.dart) | Dart | 100 | 0 | 11 | 111 |
| [lib/ui/main_dashboard/widgets/workout_count.dart](/lib/ui/main_dashboard/widgets/workout_count.dart) | Dart | 71 | 1 | 7 | 79 |
| [lib/ui/navi_bar/navigation_bottom_bar.dart](/lib/ui/navi_bar/navigation_bottom_bar.dart) | Dart | 111 | 0 | 13 | 124 |
| [lib/ui/progres_tracker/progress_tracker.dart](/lib/ui/progres_tracker/progress_tracker.dart) | Dart | 0 | 48 | 5 | 53 |
| [lib/ui/progres_tracker/widgets/action_buttons-row.dart](/lib/ui/progres_tracker/widgets/action_buttons-row.dart) | Dart | 23 | 0 | 4 | 27 |
| [lib/ui/progres_tracker/widgets/progress_chart.dart](/lib/ui/progres_tracker/widgets/progress_chart.dart) | Dart | 136 | 7 | 19 | 162 |
| [lib/ui/progres_tracker/widgets/progress_log_list.dart](/lib/ui/progres_tracker/widgets/progress_log_list.dart) | Dart | 21 | 0 | 4 | 25 |
| [lib/ui/settings/settings_page.dart](/lib/ui/settings/settings_page.dart) | Dart | 55 | 0 | 6 | 61 |
| [lib/ui/settings/sub_menu/account_menu/account_view.dart](/lib/ui/settings/sub_menu/account_menu/account_view.dart) | Dart | 44 | 0 | 2 | 46 |
| [lib/ui/settings/sub_menu/account_menu/screens/notifications_view.dart](/lib/ui/settings/sub_menu/account_menu/screens/notifications_view.dart) | Dart | 43 | 0 | 2 | 45 |
| [lib/ui/settings/sub_menu/account_menu/screens/payments_view.dart](/lib/ui/settings/sub_menu/account_menu/screens/payments_view.dart) | Dart | 29 | 0 | 2 | 31 |
| [lib/ui/settings/sub_menu/account_menu/screens/profile_menu/profile_view.dart](/lib/ui/settings/sub_menu/account_menu/screens/profile_menu/profile_view.dart) | Dart | 53 | 0 | 3 | 56 |
| [lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_avatar_page.dart](/lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_avatar_page.dart) | Dart | 26 | 0 | 2 | 28 |
| [lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_email_page.dart](/lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_email_page.dart) | Dart | 27 | 0 | 3 | 30 |
| [lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_password_page.dart](/lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/change_password_page.dart) | Dart | 28 | 0 | 3 | 31 |
| [lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/delete_account_page.dart](/lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/delete_account_page.dart) | Dart | 26 | 0 | 2 | 28 |
| [lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/edit_username_page.dart](/lib/ui/settings/sub_menu/account_menu/screens/profile_menu/screens/edit_username_page.dart) | Dart | 27 | 0 | 3 | 30 |
| [lib/ui/settings/sub_menu/account_menu/screens/profile_menu/widgets/profile_options_tile.dart](/lib/ui/settings/sub_menu/account_menu/screens/profile_menu/widgets/profile_options_tile.dart) | Dart | 26 | 0 | 4 | 30 |
| [lib/ui/settings/sub_menu/account_menu/screens/security_view.dart](/lib/ui/settings/sub_menu/account_menu/screens/security_view.dart) | Dart | 40 | 0 | 2 | 42 |
| [lib/ui/settings/sub_menu/settings_menu/screens/about_page.dart](/lib/ui/settings/sub_menu/settings_menu/screens/about_page.dart) | Dart | 26 | 0 | 2 | 28 |
| [lib/ui/settings/sub_menu/settings_menu/screens/apperance_page.dart](/lib/ui/settings/sub_menu/settings_menu/screens/apperance_page.dart) | Dart | 49 | 0 | 3 | 52 |
| [lib/ui/settings/sub_menu/settings_menu/screens/help_support_page.dart](/lib/ui/settings/sub_menu/settings_menu/screens/help_support_page.dart) | Dart | 109 | 0 | 8 | 117 |
| [lib/ui/settings/sub_menu/settings_menu/screens/logout_page.dart](/lib/ui/settings/sub_menu/settings_menu/screens/logout_page.dart) | Dart | 66 | 0 | 4 | 70 |
| [lib/ui/settings/sub_menu/settings_menu/screens/privacy_page.dart](/lib/ui/settings/sub_menu/settings_menu/screens/privacy_page.dart) | Dart | 53 | 0 | 2 | 55 |
| [lib/ui/settings/sub_menu/settings_menu/settings_view.dart](/lib/ui/settings/sub_menu/settings_menu/settings_view.dart) | Dart | 51 | 0 | 2 | 53 |
| [lib/ui/settings/widgets/custom_header.dart](/lib/ui/settings/widgets/custom_header.dart) | Dart | 48 | 0 | 3 | 51 |
| [lib/ui/settings/widgets/menu_button.dart](/lib/ui/settings/widgets/menu_button.dart) | Dart | 42 | 0 | 4 | 46 |
| [lib/ui/settings/widgets/menu_switch.dart](/lib/ui/settings/widgets/menu_switch.dart) | Dart | 35 | 0 | 4 | 39 |
| [lib/ui/settings/widgets/settings_tile.dart](/lib/ui/settings/widgets/settings_tile.dart) | Dart | 29 | 0 | 3 | 32 |
| [lib/ui/training-routine/training_routine_creator/training_routine_creator_page.dart](/lib/ui/training-routine/training_routine_creator/training_routine_creator_page.dart) | Dart | 74 | 0 | 7 | 81 |
| [lib/ui/training-routine/training_routine_creator/widgets/add_exercise_button.dart](/lib/ui/training-routine/training_routine_creator/widgets/add_exercise_button.dart) | Dart | 104 | 0 | 12 | 116 |
| [lib/ui/training-routine/training_routine_creator/widgets/back_button.dart](/lib/ui/training-routine/training_routine_creator/widgets/back_button.dart) | Dart | 23 | 0 | 4 | 27 |
| [lib/ui/training-routine/training_routine_creator/widgets/dismissible_exercise.dart](/lib/ui/training-routine/training_routine_creator/widgets/dismissible_exercise.dart) | Dart | 206 | 0 | 19 | 225 |
| [lib/ui/training-routine/training_routine_creator/widgets/dismissible_routine_form.dart](/lib/ui/training-routine/training_routine_creator/widgets/dismissible_routine_form.dart) | Dart | 202 | 0 | 15 | 217 |
| [lib/ui/training-routine/training_routine_creator/widgets/submit_button.dart](/lib/ui/training-routine/training_routine_creator/widgets/submit_button.dart) | Dart | 146 | 0 | 19 | 165 |
| [lib/ui/training-routine/training_routine_page.dart](/lib/ui/training-routine/training_routine_page.dart) | Dart | 78 | 0 | 4 | 82 |
| [lib/ui/training-routine/widgets/back_to_home_button.dart](/lib/ui/training-routine/widgets/back_to_home_button.dart) | Dart | 43 | 0 | 4 | 47 |
| [lib/ui/training-routine/widgets/create_routine_button.dart](/lib/ui/training-routine/widgets/create_routine_button.dart) | Dart | 64 | 0 | 7 | 71 |
| [lib/ui/training-routine/widgets/training_routine_card.dart](/lib/ui/training-routine/widgets/training_routine_card.dart) | Dart | 101 | 0 | 11 | 112 |
| [lib/ui/training-routine/widgets/training_routine_detail_dialog.dart](/lib/ui/training-routine/widgets/training_routine_detail_dialog.dart) | Dart | 139 | 0 | 4 | 143 |
| [lib/ui/training_session/training_session_creator/exercise_controllers.dart](/lib/ui/training_session/training_session_creator/exercise_controllers.dart) | Dart | 70 | 0 | 14 | 84 |
| [lib/ui/training_session/training_session_creator/training_session_creator_page.dart](/lib/ui/training_session/training_session_creator/training_session_creator_page.dart) | Dart | 103 | 1 | 11 | 115 |
| [lib/ui/training_session/training_session_creator/widgets/exercise_card_builder.dart](/lib/ui/training_session/training_session_creator/widgets/exercise_card_builder.dart) | Dart | 130 | 0 | 9 | 139 |
| [lib/ui/training_session/training_session_creator/widgets/exercise_set_row.dart](/lib/ui/training_session/training_session_creator/widgets/exercise_set_row.dart) | Dart | 116 | 0 | 7 | 123 |
| [lib/ui/training_session/training_session_creator/widgets/finish_workout_button.dart](/lib/ui/training_session/training_session_creator/widgets/finish_workout_button.dart) | Dart | 63 | 0 | 4 | 67 |
| [lib/ui/training_session/training_session_creator/widgets/routine-name-displayer.dart](/lib/ui/training_session/training_session_creator/widgets/routine-name-displayer.dart) | Dart | 32 | 0 | 5 | 37 |
| [lib/ui/training_session/training_session_creator/widgets/routine_exercises_displayer.dart](/lib/ui/training_session/training_session_creator/widgets/routine_exercises_displayer.dart) | Dart | 137 | 0 | 20 | 157 |
| [lib/ui/training_session/training_session_creator/widgets/timer-display-widget.dart](/lib/ui/training_session/training_session_creator/widgets/timer-display-widget.dart) | Dart | 40 | 0 | 4 | 44 |
| [lib/ui/training_session/training_session_creator/widgets/timer_displayer.dart](/lib/ui/training_session/training_session_creator/widgets/timer_displayer.dart) | Dart | 40 | 0 | 4 | 44 |
| [lib/ui/training_session/training_session_creator/widgets/workout_summary.dart](/lib/ui/training_session/training_session_creator/widgets/workout_summary.dart) | Dart | 113 | 0 | 8 | 121 |
| [lib/ui/training_session/training_session_details/training_session_logs_page.dart](/lib/ui/training_session/training_session_details/training_session_logs_page.dart) | Dart | 84 | 0 | 7 | 91 |
| [lib/ui/training_session/training_session_details/widgets/back_button.dart](/lib/ui/training_session/training_session_details/widgets/back_button.dart) | Dart | 44 | 0 | 2 | 46 |
| [lib/ui/training_session/training_session_details/widgets/training_log_card.dart](/lib/ui/training_session/training_session_details/widgets/training_log_card.dart) | Dart | 109 | 0 | 11 | 120 |
| [lib/ui/training_session/training_session_details/widgets/training_log_list.dart](/lib/ui/training_session/training_session_details/widgets/training_log_list.dart) | Dart | 31 | 0 | 9 | 40 |
| [lib/ui/user_profile/user_profile_page.dart](/lib/ui/user_profile/user_profile_page.dart) | Dart | 9 | 0 | 2 | 11 |
| [lib/utills/global_variables.dart](/lib/utills/global_variables.dart) | Dart | 12 | 1 | 3 | 16 |
| [lib/utills/page_route_animator.dart](/lib/utills/page_route_animator.dart) | Dart | 18 | 0 | 3 | 21 |
| [lib/utills/time_provider.dart](/lib/utills/time_provider.dart) | Dart | 22 | 0 | 6 | 28 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)