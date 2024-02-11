from flask import Flask, jsonify

app = Flask(__name__)

# Datos de ejemplo (puedes modificar estos datos como desees)
datos = [
    {
        "nombre": "Juan",
        "frase": "La vida es un viaje, no un destino.",
        "telefono": "123-456-7890"
    },
    {
        "nombre": "María",
        "frase": "El conocimiento es poder.",
        "telefono": "987-654-3210"
    },
    {
        "nombre": "Carlos",
        "frase": "Carpe Diem.",
        "telefono": "555-123-4567"
    }
]

# Ruta para obtener los datos
@app.route('/api/datos', methods=['GET'])
def obtener_datos():
    return jsonify(datos)

if __name__ == '__main__':
    app.run(debug=True)
