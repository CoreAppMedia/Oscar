function agregarTarea() {
    let tarea = document.getElementById('taskInput').value.trim();
    if (tarea !== '') {
      let lista = document.getElementById('taskList');
      let nuevaTarea = document.createElement('li');
      nuevaTarea.textContent = tarea;
  
      let botonEliminar = document.createElement('button');
      botonEliminar.textContent = 'Eliminar';
      botonEliminar.onclick = function() {
        lista.removeChild(nuevaTarea);
      };
  
      nuevaTarea.appendChild(botonEliminar);
      lista.appendChild(nuevaTarea);
  
      document.getElementById('taskInput').value = '';
    } else {
      alert('Por favor, ingresa una tarea válida.');
    }
  }
  