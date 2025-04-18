import 'package:flutter/material.dart';
import 'package:ivan/model/producto.dart';
import 'package:ivan/services/api_service.dart'; 

class BuscarProductosScreen extends StatefulWidget {
  const BuscarProductosScreen({super.key});

  @override
  State<BuscarProductosScreen> createState() => _BuscarProductosScreenState();
}

class _BuscarProductosScreenState extends State<BuscarProductosScreen> {
  List<Producto> _productos = [];  //Almaceno  la lista de productos obtenidos por la API
  List<Producto> _productosFiltrados = [];
  String _query = '';  //almaceno el texto del campo de búsqueda

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  void _cargarProductos() async {  //Cargo los productos desde la API
    var productosData = await ApiService.buscarProductos(); 
    List<Producto> productos = productosData.map((data) => Producto.fromJson(data)).toList();
    
    setState(() {  // Actualiza la interfaz cuando las variables cambian
      _productos = productos;
      _productosFiltrados = productos;
    });
  }

  void _buscarProducto(String query) {
    setState(() {
      _productosFiltrados = _productos
          .where((producto) => producto.nombre!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
          'Buscar Productos',
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
