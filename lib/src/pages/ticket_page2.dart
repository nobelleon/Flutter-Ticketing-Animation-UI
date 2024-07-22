import 'package:flutter/material.dart';
import 'package:ticketing_ui/src/pages/home_page.dart';
import 'package:ticketing_ui/src/pages/ticket_page.dart';
import 'package:ticketing_ui/src/widgets/scale_fade_transition.dart';
import 'package:uicons/uicons.dart';

class TicketPage2 extends StatefulWidget {
  final AnimationController fadeOutTransition;

  const TicketPage2({super.key, required this.fadeOutTransition});

  @override
  State<TicketPage2> createState() => _TicketPage2State();
}

class _TicketPage2State extends State<TicketPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://images.pexels.com/photos/3984822/pexels-photo-3984822.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconContainer(
                        icon: UIcons.regularRounded.arrow_left,
                        onTap: () {
                          widget.fadeOutTransition.reverse();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const BuyTicketColumn(),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 275,
            right: 20,
            child: AnimatedCenterBox(),
          ),
        ],
      ),
    );
  }
}

class BuyTicketColumn extends StatefulWidget {
  const BuyTicketColumn({super.key});

  @override
  State<BuyTicketColumn> createState() => _BuyTicketColumnState();
}

class _BuyTicketColumnState extends State<BuyTicketColumn>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _scale;
  late Animation<double> _fade;
  late Animation<double> _textFade;

  late Animation<Offset> _slide;
  late Animation<Offset> _slide2;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _fade = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.2),
      ),
    );
    _slide =
        Tween(begin: const Offset(0.2, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.25, 0.50, curve: Curves.easeIn),
      ),
    );
    _slide2 =
        Tween(begin: const Offset(0.25, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.25, 0.50, curve: Curves.easeIn),
      ),
    );
    _textFade = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.25, 0.4),
      ),
    );

    _scale = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.7, curve: Curves.decelerate),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      _animationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeTransition(
          opacity: _fade,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _textFade,
                      child: SlideTransition(
                        position: _slide,
                        child: Text(
                          'Ohnnys autograph',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _textFade,
                      child: SlideTransition(
                        position: _slide2,
                        child: Text(
                          '138 people ahead',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                SlideFadeTransition(
                  animation: _animationController,
                  child: Text(
                    '\Rp.79k',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ScaleTransition(
          scale: _scale,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(
                    'Buy',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedCenterBox extends StatefulWidget {
  const AnimatedCenterBox({super.key});

  @override
  State<AnimatedCenterBox> createState() => _AnimatedCenterBoxState();
}

class _AnimatedCenterBoxState extends State<AnimatedCenterBox>
    with TickerProviderStateMixin {
  late AnimationController _animationCtrl;

  late Animation<Offset> _slide;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<double> _size;

  @override
  void initState() {
    _animationCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _size = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationCtrl,
          curve: const Interval(0.0, 0.2, curve: Curves.easeIn)),
    );
    _fade = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationCtrl,
          curve: const Interval(0.2, 0.5, curve: Curves.easeIn)),
    );

    _scale = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationCtrl,
          curve: const Interval(0.5, 1, curve: Curves.decelerate)),
    );
    _slide =
        Tween(begin: const Offset(-0.5, 0.4), end: const Offset(0, 0)).animate(
      CurvedAnimation(
          parent: _animationCtrl,
          curve: const Interval(0.5, 1, curve: Curves.decelerate)),
    );

    _animationCtrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: SlideTransition(
        position: _slide,
        child: SizeTransition(
          sizeFactor: _size,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(0.4),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                FadeTransition(
                  opacity: _fade,
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/3984822/pexels-photo-3984822.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    ),
                  ),
                ),
                Text(
                  'Gustavo Bishop',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.circle, color: Colors.red, size: 5),
                    Text(
                      ' Live',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
