/// 用于生命周期的管理
abstract class ILifecycle {
  //初始化
  void initState();

  void didChangeDependencies();

  void didUpdateWidget<T>(T oldWidget);

  void deactivate();

  void dispose();
}
