import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_route.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/ship.dart';

abstract class ActivityManagementRepository {
  const ActivityManagementRepository();

  ResultFuture<Activity> addActivity({
    required Activity activity,
  });

  ResultFuture<List<Item>> addItem({
    required List<Item> items,
    required Item item,
    required int index,
  });

  ResultFuture<dynamic> deleteActivities({
    required List<int> ids,
  });

  ResultFuture<Activity> deleteItems({
    required int activityId,
    required List<int> ids,
  });

  ResultFuture<List<Activity>> getActivities();

  ResultFuture<List<Ship>> getShip();

  ResultFuture<List<ActivityRoute>> getActivityRoutes();

  ResultFuture<Activity> updateActivity({
    required Activity activity,
    required List<int> deletedIds,
  });

  ResultFuture<Activity> updateItem({
    required int activityId,
    required Item item,
  });

  ResultFuture<dynamic> addPhotoItem({required String type});

  ResultFuture<List<Activity>> changeStatusActivities({
    required List<Activity> activities,
    required String status,
  });

  ResultFuture<List<Activity>> cancelCheckBoxActivities({
    required List<Activity> activities,
  });

  ResultFuture<List<Activity>> updateCheckBoxActivity({
    required int activityId,
    required List<Activity> activities,
  });

  ResultFuture<List<Activity>> selectAllActivities({
    required List<Activity> activities,
  });
}
