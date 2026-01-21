import 'package:flutter/material.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';

class CustomLoadImage extends StatelessWidget {
  const CustomLoadImage({
    super.key,
    required this.urlImage,
  });

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: textColor.withOpacity(0.1),
                spreadRadius: 0.0,
                blurRadius: 6.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
              loadingBuilder:
                  (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                    print(error);
                    return Text('Error al cargar la imagen');
                  },
            ),
          ),
        ),
      ],
    );
  }
}
