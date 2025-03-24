import 'package:flutter/material.dart';
import 'package:ivan/model/producto.dart';

class BuscarProductosScreen extends StatefulWidget {
  const BuscarProductosScreen({super.key});

  @override
  State<BuscarProductosScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<BuscarProductosScreen> {
  late Future<List<Producto>> _productosFuture;
  List<Producto> _productos = [];
  List<Producto> _productosFiltrados = [];
  String _query = '';

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  void _cargarProductos() async {
    _productosFuture = Producto().obtenerProductosRegistrados();
    var productos = await _productosFuture;
    setState(() {
      _productos = productos;
      _productosFiltrados = productos; 
    });
  }

  void _buscarProducto(String query) async {
    if (query.isEmpty) {
      setState(() {
        _productosFiltrados = _productos;
      });
    } else {
      Producto producto = Producto();
      List<Producto> resultados = await producto.buscarProductosPorNombre(query);
      setState(() {
        _productosFiltrados = resultados;
      });
    }
  }

  Widget _buildProductoCard(Producto producto, double width) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          producto.imagen != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    producto.imagen!,
                    width: width * 0.1,
                    height: width * 0.1,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  width: width * 0.1,
                  height: width * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.image_not_supported,
                    size: width * 0.08,
                    color: Colors.white,
                  ),
                ),
          SizedBox(height: 10),
          Text(
            producto.nombre ?? 'Producto sin nombre',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width * 0.018,
              fontFamily: 'permanent_marker',
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Código: ${producto.codigo}',
            style: TextStyle(
              fontSize: width * 0.014,
              fontFamily: 'indie_flower',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_backspace_sharp),
        ),
        title: Text(
          'Catálogo',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'permanent_marker',
          ),
        ),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      
      body: Column(
        children: [
          // 🔍 Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) {
                _query = value;
                _buscarProducto(_query);
              },
              decoration: InputDecoration(
                labelText: 'Buscar productos...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                
                return GridView.builder(
                  padding: EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width < 600 ? 2 : (width < 1200 ? 3 : 4),
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _productosFiltrados.length,
                  itemBuilder: (context, index) {
                    return _buildProductoCard(_productosFiltrados[index], width);
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ingresar_producto');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}