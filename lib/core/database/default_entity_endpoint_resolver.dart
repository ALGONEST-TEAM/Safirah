// import 'package:safirah/core/database/sync_service.dart';
//
// /// Resolver افتراضي لنقاط النهاية الخاصة بالمزامنة.
// ///
// /// تعتمد هذه الدالة على قيمة [entityType] و [operation]
// /// لتحديد مسار الـ API وطريقة HTTP المناسبة.
// ///
// /// ✅ عدِّل قيم `path` هنا لتطابق API الحقيقي في مشروعك.
// Future<EntitySyncEndpoint> defaultEntityEndpointResolver(
//   String entityType,
//   String operation,
// ) async {
//   switch (entityType) {
//     case 'league':
//       return _resolveLeagueEndpoint(operation);
//     case 'match':
//       return _resolveMatchEndpoint(operation);
//     // TODO: أضف كيانات أخرى مثل: team, player, round, group ...
//     default:
//       throw UnsupportedError('Unknown entityType: $entityType');
//   }
// }
//
// EntitySyncEndpoint _resolveLeagueEndpoint(String operation) {
//   switch (operation) {
//     case SyncService.operationCreate:
//       return const EntitySyncEndpoint(
//         path: '/leagues', // POST لإنشاء دوري جديد
//         method: HttpMethod.post,
//       );
//     case SyncService.operationUpdate:
//       return const EntitySyncEndpoint(
//         path: '/leagues/update', // PUT لتحديث بيانات دوري
//         method: HttpMethod.put,
//       );
//     case SyncService.operationDelete:
//       return const EntitySyncEndpoint(
//         path: '/leagues/delete', // DELETE لحذف دوري
//         method: HttpMethod.delete,
//       );
//     default:
//       throw UnsupportedError('Unknown operation for league: $operation');
//   }
// }
//
// EntitySyncEndpoint _resolveMatchEndpoint(String operation) {
//   switch (operation) {
//     case SyncService.operationCreate:
//       return const EntitySyncEndpoint(
//         path: '/matches', // POST لإنشاء مباراة
//         method: HttpMethod.post,
//       );
//     case SyncService.operationUpdate:
//       return const EntitySyncEndpoint(
//         path: '/matches/update', // PUT لتعديل مباراة
//         method: HttpMethod.put,
//       );
//     case SyncService.operationDelete:
//       return const EntitySyncEndpoint(
//         path: '/matches/delete', // DELETE لحذف مباراة
//         method: HttpMethod.delete,
//       );
//     default:
//       throw UnsupportedError('Unknown operation for match: $operation');
//   }
// }
//
