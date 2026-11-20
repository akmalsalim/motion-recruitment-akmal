import 'package:material_ui/material_ui.dart';

void main() => runApp(const CatatanHarianApp());

class CatatanHarianApp extends StatelessWidget {
  const CatatanHarianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Harian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const CatatanPage(),
    );
  }
}

class Catatan {
  Catatan(this.judul, {this.selesai = false});
  final String judul;
  bool selesai;
}

class CatatanPage extends StatefulWidget {
  const CatatanPage({super.key});

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  final _controller = TextEditingController();
  final List<Catatan> _catatan = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _simpan() {
    final teks = _controller.text.trim();
    if (teks.isEmpty) return;
    setState(() {
      _catatan.insert(0, Catatan(teks));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Harian')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _simpan(),
                    decoration: const InputDecoration(
                      hintText: 'Tulis catatan baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _simpan,
                  child: const Text('Simpan'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _catatan.isEmpty
                  ? const Center(child: Text('Belum ada catatan.'))
                  : ListView.builder(
                      itemCount: _catatan.length,
                      itemBuilder: (context, index) {
                        final item = _catatan[index];
                        return ListTile(
                          leading: Checkbox(
                            value: item.selesai,
                            onChanged: (v) =>
                                setState(() => item.selesai = v ?? false),
                          ),
                          title: Text(
                            item.judul,
                            style: TextStyle(
                              decoration: item.selesai
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                setState(() => _catatan.removeAt(index)),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
