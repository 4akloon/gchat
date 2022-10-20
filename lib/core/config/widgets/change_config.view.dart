part of '../config.core.dart';

class _ChangeConfigView extends StatefulWidget {
  @override
  State<_ChangeConfigView> createState() => _ChangeConfigViewState();
}

class _ChangeConfigViewState extends State<_ChangeConfigView> {
  final _core = ConfigCore();

  ConfigModel? currentConfig;

  @override
  void initState() {
    currentConfig = _core.fetchConfig();
    Future.delayed(const Duration(milliseconds: 100)).then(
      (_) => Get.defaultDialog(
        title: 'Warning!',
        middleText:
            'After changing the configuration, you need to restart the application!',
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      ),
    );
    super.initState();
  }

  void fetchConfig() => setState(() => currentConfig = _core.fetchConfig());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change config')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: _core.availableConfigs
            .map(
              (config) => CheckboxListTile(
                title: Text(config.name),
                subtitle: _core.defaultConfig == config
                    ? const Text('default')
                    : null,
                value: config == (currentConfig ?? _core.defaultConfig),
                onChanged: (v) {
                  if (v ?? false) {
                    _core.setConfig(config);
                    fetchConfig();
                  }
                },
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: currentConfig != null
                ? () {
                    _core.setConfig(null);
                    fetchConfig();
                  }
                : null,
            child: const Text('Set defaults'),
          ),
        ),
      ),
    );
  }
}
