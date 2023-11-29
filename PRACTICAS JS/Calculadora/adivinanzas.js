let numeroAleatorio = Math.floor(Math.random() * 10) + 1; // Genera un número aleatorio entre 1 y 10
let intentos = 3; // Número de intentos

function adivinarNumero() {
  let guess = parseInt(document.getElementById('guess').value);
  let resultado = document.getElementById('resultado1');

  if (guess === numeroAleatorio) {
    resultado.textContent = '¡Felicidades! Has adivinado el número.';
  } else {
    intentos--;
    if (intentos > 0) {
      resultado.textContent = `Número incorrecto. Te quedan ${intentos} intentos.`;
    } else {
      resultado.textContent = `Lo siento, has agotado tus intentos. El número era ${numeroAleatorio}.`;
      document.getElementById('guess').disabled = true; // Deshabilita el input después de los intentos agotados
    }
  }
}
