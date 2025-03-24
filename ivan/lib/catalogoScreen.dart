
import 'package:flutter/material.dart';
import 'package:ivan/model/producto.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  late Future<List<Producto>> _productosFuture;

  @override
  void initState() {
    super.initState();
    _productosFuture = Producto().obtenerProductosRegistrados();
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

          // Nombre del producto
          Text(
            producto.nombre ?? 'Producto sin nombre',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width * 0.018, 
              fontFamily: 'permanent_marker',
            ),
          ),
          SizedBox(height: 10), 
          // Código del producto
          Text(
            'Código: ${producto.codigo}',
            style: TextStyle(fontSize: width * 0.014,
            fontFamily: 'indie_flower'
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/buscarProductos');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),

      body: FutureBuilder<List<Producto>>(
        future: _productosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay productos disponibles en este momento.'));
          } else {
            var productos = snapshot.data!;
            return LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;

                
                return GridView.builder(
                  padding: EdgeInsets.all(12), 
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width < 600 ? 2 : (width < 1200 ? 3 : 4), 
                    childAspectRatio: 0.75, 
                  ),
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    return _buildProductoCard(productos[index], width);
                  },
                );
              },
            );
          }
        },
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