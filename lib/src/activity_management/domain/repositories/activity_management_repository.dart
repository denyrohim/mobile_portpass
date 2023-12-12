import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

abstract class ActivityManagementRepository {
  const ActivityManagementRepository();

  ResultFuture<Activity> addActivity({
    required Activity activity,
  });

  ResultFuture<List<Item>> addItem({
    required List<Item> items,
    required Item item,
  });

  ResultFuture<void> deleteActivities({
    required List<int> ids,
  });

  ResultFuture<Activity> deleteItems({
    required int activityId,
    required List<int> ids,
  });

  ResultFuture<List<Activity>> getActivities();

  ResultFuture<Activity> updateActivity({
    required Activity activity,
  });

  ResultFuture<Activity> updateItem({
    required int activityId,
    required Item item,
  });

  ResultFuture<dynamic> addPhotoItem({
    required String type
  });
}
