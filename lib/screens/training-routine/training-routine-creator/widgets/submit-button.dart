import 'package:flutter/material.dart';

class AdvancedSubmitButton extends StatefulWidget {
  final VoidCallback onSubmit;
  final bool shouldShake;
  final bool isFailed;
  final bool isSaved;

  const AdvancedSubmitButton({
    required this.onSubmit,
    required this.shouldShake,
    required this.isFailed,
    required this.isSaved,
  });

  @override
  _AdvancedSubmitButtonState createState() => _AdvancedSubmitButtonState();
}

class _AdvancedSubmitButtonState extends State<AdvancedSubmitButton>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    if (widget.shouldShake) {
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() => isPressed = true),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onSubmit,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_animation.value, 0),
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: widget.isFailed
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.red.shade800, Colors.red.shade400],
                  )
                : widget.isSaved
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade800, Colors.blue.shade400],
                      )
                    : LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isPressed
                            ? [Colors.green.shade800, Colors.green.shade400]
                            : [Colors.green, Colors.green.shade600],
                      ),
            boxShadow: isPressed
                ? null
                : [
                    BoxShadow(
                      color: Colors.green.shade200.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isFailed)
                Icon(Icons.clear, color: Colors.white)
              else if (widget.isSaved)
                Icon(Icons.check_circle, color: Colors.white)
              else
                Icon(Icons.check, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.isFailed
                      ? 'FAILED'
                      : (widget.isSaved ? 'SAVED!' : 'Submit'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
