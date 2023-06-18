import 'package:flutter/material.dart';

class AdvancedAddExerciseButton extends StatefulWidget {
  final VoidCallback onAddExercise;

  const AdvancedAddExerciseButton({required this.onAddExercise});

  @override
  _AdvancedAddExerciseButtonState createState() =>
      _AdvancedAddExerciseButtonState();
}

class _AdvancedAddExerciseButtonState extends State<AdvancedAddExerciseButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 50));
    _animation = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color.fromRGBO(78, 180, 173, 0.612),
          end: Colors.white,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.white,
          end: Colors.blue,
        ),
      ),
    ]).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_animationController.isAnimating) {
          _animationController.forward().then((_) {
            _animationController.reverse().then((_) {
              _animationController.stop(canceled: true);
              widget.onAddExercise();
            });
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 15),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: _animation.value,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: _animation.value!.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Add Exercise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
