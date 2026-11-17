import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const ExploreMundoApp());

// ---------------------------------------------------------------------------
// MODELO DE DADOS
// ---------------------------------------------------------------------------
class Destino {
  final String nome;
  final String local;
  final String descricao;
  final String imagem;
  final double nota;
  final int avaliacoes;
  final int dias;
  final double preco;

  const Destino({
    required this.nome,
    required this.local,
    required this.descricao,
    required this.imagem,
    required this.nota,
    required this.avaliacoes,
    required this.dias,
    required this.preco,
  });
}

const List<Destino> destinos = [
  Destino(
    nome: 'Fernando de Noronha',
    local: 'Pernambuco, Brasil',
    descricao:
        'Arquipélago de águas cristalinas, ideal para mergulho e observação de golfinhos. '
        'A Baía do Sancho é frequentemente eleita uma das praias mais bonitas do mundo. '
        'O pacote inclui hospedagem em pousada, passeios de barco e trilhas guiadas.',
    imagem:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1000',
    nota: 4.9,
    avaliacoes: 312,
    dias: 6,
    preco: 7890,
  ),
  Destino(
    nome: 'Paris',
    local: 'Île-de-France, França',
    descricao:
        'A cidade luz reúne a Torre Eiffel, o Louvre e os cafés de Montmartre. '
        'O pacote inclui passagem aérea, hotel no centro e passeio de barco pelo Rio Sena.',
    imagem:
        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=1000',
    nota: 4.7,
    avaliacoes: 528,
    dias: 8,
    preco: 12450,
  ),
  Destino(
    nome: 'Kyoto',
    local: 'Kansai, Japão',
    descricao:
        'Cidade dos templos milenares, jardins zen e das tradicionais casas de chá. '
        'Visite o Fushimi Inari e a floresta de bambu de Arashiyama com guia em português.',
    imagem:
        'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=1000',
    nota: 4.8,
    avaliacoes: 247,
    dias: 10,
    preco: 16300,
  ),
  Destino(
    nome: 'Cinque Terre',
    local: 'Ligúria, Itália',
    descricao:
        'Cinco vilas coloridas penduradas nos penhascos do litoral italiano. '
        'Trilhas panorâmicas, frutos do mar frescos e vinhos locais.',
    imagem:
        'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=1000',
    nota: 4.6,
    avaliacoes: 189,
    dias: 7,
    preco: 11200,
  ),
  Destino(
    nome: 'Aurora Boreal',
    local: 'Tromsø, Noruega',
    descricao:
        'Uma experiência única para ver a aurora boreal, com passeios de trenó '
        'puxado por cães e hospedagem em cabanas aquecidas.',
    imagem:
        'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=1000',
    nota: 4.9,
    avaliacoes: 143,
    dias: 5,
    preco: 14900,
  ),
];

String formatarPreco(double v) {
  final inteiro = v.toStringAsFixed(0);
  final buffer = StringBuffer();
  for (int i = 0; i < inteiro.length; i++) {
    if (i > 0 && (inteiro.length - i) % 3 == 0) buffer.write('.');
    buffer.write(inteiro[i]);
  }
  return 'R\$ $buffer';
}

// ---------------------------------------------------------------------------
// WIDGETS AUXILIARES
// ---------------------------------------------------------------------------
Widget imagemRede(String url, {double? altura}) {
  return Image.network(
    url,
    width: double.infinity,
    height: altura,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stack) => Container(
      width: double.infinity,
      height: altura,
      color: Colors.teal.shade100,
      child: const Icon(Icons.landscape, size: 56, color: Colors.teal),
    ),
  );
}

Column _buildButtonColumn(
    Color color, IconData icon, String label, VoidCallback onTap) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: color),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 4),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}

void mostrarMensagem(BuildContext context, String texto) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(texto)));
}

// ---------------------------------------------------------------------------
// APP
// ---------------------------------------------------------------------------
class ExploreMundoApp extends StatelessWidget {
  const ExploreMundoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Mundo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HomePage(),
    );
  }
}

// ---------------------------------------------------------------------------
// TELA PRINCIPAL COM BARRA DE NAVEGAÇÃO SUPERIOR
// ---------------------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Explore Mundo'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.public), text: 'Destinos'),
              Tab(icon: Icon(Icons.luggage), text: 'Pacotes'),
              Tab(icon: Icon(Icons.mail), text: 'Contato'),
              Tab(icon: Icon(Icons.info), text: 'Sobre nós'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DestinosTab(),
            PacotesTab(),
            ContatoTab(),
            SobreTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ABA DESTINOS: banner + pesquisa rápida + lista
// ---------------------------------------------------------------------------
class DestinosTab extends StatefulWidget {
  const DestinosTab({super.key});

  @override
  State<DestinosTab> createState() => _DestinosTabState();
}

class _DestinosTabState extends State<DestinosTab> {
  String _busca = '';

  @override
  Widget build(BuildContext context) {
    final filtrados = destinos.where((d) {
      final q = _busca.toLowerCase();
      return d.nome.toLowerCase().contains(q) ||
          d.local.toLowerCase().contains(q);
    }).toList();

    return ListView(
      children: [
        const BannerDestaque(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            onChanged: (v) => setState(() => _busca = v),
            decoration: InputDecoration(
              hintText: 'Pesquisar destino...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        if (filtrados.isEmpty)
          const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: Text('Nenhum destino encontrado.')),
          ),
        for (final d in filtrados)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: imagemRede(d.imagem, altura: 56),
                ),
              ),
              title: Text(d.nome),
              subtitle: Text(d.local),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  Text(' ${d.nota}'),
                  const Icon(Icons.keyboard_arrow_right),
                ],
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DestinoPage(destino: d)),
              ),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// BANNER DE DESTAQUE (slideshow com Stack, clicável)
// ---------------------------------------------------------------------------
class BannerDestaque extends StatefulWidget {
  const BannerDestaque({super.key});

  @override
  State<BannerDestaque> createState() => _BannerDestaqueState();
}

class _BannerDestaqueState extends State<BannerDestaque> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _pagina = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;
      final proxima = (_pagina + 1) % destinos.length;
      _controller.animateToPage(
        proxima,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: destinos.length,
            onPageChanged: (i) => setState(() => _pagina = i),
            itemBuilder: (context, i) {
              final d = destinos[i];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DestinoPage(destino: d)),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    imagemRede(d.imagem, altura: 240),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 32,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.nome,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${d.local} • a partir de ${formatarPreco(d.preco)}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(destinos.length, (i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _pagina ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _pagina ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TELA DE DETALHE DO DESTINO (segue o roteiro: imagem, título, botões, texto)
// ---------------------------------------------------------------------------
class DestinoPage extends StatelessWidget {
  final Destino destino;
  const DestinoPage({super.key, required this.destino});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    destino.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  destino.local,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.amber[700]),
          Text(' ${destino.nota} (${destino.avaliacoes})'),
        ],
      ),
    );

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'LIGAR',
            () => mostrarMensagem(context, 'Ligando para a agência...')),
        _buildButtonColumn(color, Icons.near_me, 'ROTA',
            () => mostrarMensagem(context, 'Abrindo rota até ${destino.nome}...')),
        _buildButtonColumn(color, Icons.share, 'COMPARTILHAR',
            () => mostrarMensagem(context, 'Link de ${destino.nome} copiado!')),
      ],
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        '${destino.descricao}\n\n'
        'Duração: ${destino.dias} dias\n'
        'Valor por pessoa: ${formatarPreco(destino.preco)}',
        softWrap: true,
      ),
    );

    Widget reservar = Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: FilledButton.icon(
        icon: const Icon(Icons.check_circle),
        label: const Text('Reservar agora'),
        onPressed: () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Confirmar reserva'),
            content: Text(
                'Deseja reservar o pacote para ${destino.nome} por ${formatarPreco(destino.preco)}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  mostrarMensagem(context, 'Reserva enviada com sucesso!');
                },
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(destino.nome)),
      body: ListView(
        children: [
          imagemRede(destino.imagem, altura: 240),
          titleSection,
          buttonSection,
          textSection,
          reservar,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ABA PACOTES
// ---------------------------------------------------------------------------
class PacotesTab extends StatelessWidget {
  const PacotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: destinos.length,
      itemBuilder: (context, i) {
        final d = destinos[i];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.flight_takeoff),
            title: Text('${d.nome} • ${d.dias} dias'),
            subtitle: Text('${d.local}\n${formatarPreco(d.preco)} por pessoa'),
            isThreeLine: true,
            trailing: FilledButton(
              onPressed: () =>
                  mostrarMensagem(context, 'Reserva de ${d.nome} iniciada!'),
              child: const Text('Reservar'),
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// ABA CONTATO
// ---------------------------------------------------------------------------
class ContatoTab extends StatelessWidget {
  const ContatoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Fale com a gente',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(color, Icons.call, 'LIGAR',
                () => mostrarMensagem(context, 'Ligando: (11) 4000-0000')),
            _buildButtonColumn(color, Icons.email, 'E-MAIL',
                () => mostrarMensagem(context, 'contato@exploremundo.com')),
            _buildButtonColumn(color, Icons.chat, 'WHATSAPP',
                () => mostrarMensagem(context, 'Abrindo WhatsApp...')),
          ],
        ),
        const SizedBox(height: 24),
        const TextField(
          decoration: InputDecoration(
              labelText: 'Nome', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        const TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: 'E-mail', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        const TextField(
          maxLines: 4,
          decoration: InputDecoration(
              labelText: 'Mensagem', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => mostrarMensagem(context, 'Mensagem enviada!'),
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// ABA SOBRE NÓS
// ---------------------------------------------------------------------------
class SobreTab extends StatelessWidget {
  const SobreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        Icon(Icons.travel_explore, size: 72, color: Colors.teal),
        SizedBox(height: 16),
        Text(
          'Explore Mundo',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Somos uma agência de viagens dedicada a transformar sonhos em '
          'roteiros inesquecíveis. Oferecemos pacotes nacionais e '
          'internacionais, atendimento personalizado e suporte durante toda a '
          'viagem.\n\n'
          'Pelo aplicativo e pelo site você consulta destinos, compara '
          'pacotes, confere avaliações de outros viajantes e reserva tudo em '
          'poucos toques.',
          softWrap: true,
        ),
      ],
    );
  }
}
