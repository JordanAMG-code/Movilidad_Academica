// 1. VARIABLES Y DATOS: Creamos una lista (Array) de productos (Objetos)
const carrito = [
  { nombre: "Camiseta", precio: 20 },
  { nombre: "Pantalón", precio: 50 },
  { nombre: "Zapatos", precio: 60 }
];

// 2. FUNCIÓN: Creamos la "receta" para procesar la compra
function procesarCompra(listaDeProductos) {
  let total = 0; // Variable que va a cambiar

  // 3. BUCLE: Revisamos el carrito producto por producto y sumamos su precio
  for (let i = 0; i < listaDeProductos.length; i++) {
    total = total + listaDeProductos[i].precio;
  }

  console.log("Total inicial: $" + total);

  // 4. CONDICIONAL: Si el total es mayor a 100, aplicamos descuento
  if (total > 100) {
    total = total * 0.90; // Restamos el 10%
    console.log("¡Felicidades! Se aplicó un 10% de descuento.");
  } else {
    console.log("No alcanzaste el mínimo para el descuento.");
  }

  // Devolvemos el resultado final
  return total;
}

// 5. EJECUCIÓN: Llamamos a la función pasándole nuestro carrito
let totalAPagar = procesarCompra(carrito);
console.log("El monto final a pagar es: $" + totalAPagar);