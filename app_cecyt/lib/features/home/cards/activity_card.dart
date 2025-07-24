import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/models/activity_model.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/home/ui/pages/activity_page.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart';


final ApiService apiService = ApiService();

Future<List<Activity>> loadActivities() async {
  //Recibirá parametro String token
  await Future.delayed(const Duration(milliseconds: 500));
  return [
    //Objetos estaticos de prueba
    Activity(
      image: 'assets/dotImage.jpeg',
      title: 'Actividad Demo',
      subtitle: 'Subtítulo demo',
      description: 'Descripción de la actividad demo',
      date: '20.07.2025',
      time: '10:00 h',
      place: 'Lugar demo',
    ),
    Activity(
      image: 'assets/dotImage.jpeg',
      title: 'Actividad kakAKD',
      subtitle: 'Subtítulo demo',
      description: 'Descripción de la actividad demo',
      date: '20.07.2025',
      time: '10:00 h',
      place: 'Lugar demo',
    ),
  ];
}

class ActivityCardList extends StatelessWidget {
  final String token;
  const ActivityCardList({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Activity>>(
      future: loadActivities(), //Aquí recibe el token como parametro
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar actividades'));
        }
        final activities = snapshot.data ?? [];
        return SizedBox(
          height: 180, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ActivityCard(activity: activity);
            },
          ),
        );
      },
    );
  }
}

class ActivityCard extends StatelessWidget {
  final Activity activity;
  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ActivitiesPage.path, // Cambia por la ruta de tu página destino
          arguments: activity,
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

        child: SizedBox(
          width: 300,
          height: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                  child: Image.asset(
                    activity.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        activity.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        activity.subtitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
