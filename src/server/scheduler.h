// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef _SCHEDULER_H
#define _SCHEDULER_H

class Room;
class RoomThread;
class Lua;

class Scheduler : public QObject {
  Q_OBJECT
 public:
  explicit Scheduler(RoomThread *m_thread);
  ~Scheduler();

  Lua *getLua() const { return L; }

 public slots:
  // 跨线程传递引用可能出问题！
  void handleRequest(const QString &req);
  void doDelay(int roomId, int ms);
  bool resumeRoom(int roomId, const char *reason);

 private:
  RoomThread *m_thread;
  Lua *L;
  // QList<Room *> room_list;
};

#endif // _ROOMTHREAD_H
