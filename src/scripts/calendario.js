// JavaScript específico para calendario.html

// Inicializar cuando se carga la página
document.addEventListener('DOMContentLoaded', function() {
    // Cargar eventos del calendario
    cargarEventos();
    
    // Inicializar event listeners
    initializeEventListeners();
});

// Función para inicializar todos los event listeners
function initializeEventListeners() {
    // Botón buscar eventos
    const btnBuscarEventos = document.getElementById('btn-buscar-eventos');
    if (btnBuscarEventos) {
        btnBuscarEventos.addEventListener('click', buscarEventos);
    }
    
    // Botón nuevo turno
    const btnNuevoTurno = document.getElementById('btn-nuevo-turno');
    if (btnNuevoTurno) {
        btnNuevoTurno.addEventListener('click', crearNuevoTurno);
    }
    
    // Filtros que cambien automáticamente
    const fechaSelector = document.getElementById('fecha-selector');
    if (fechaSelector) {
        fechaSelector.addEventListener('change', buscarEventos);
    }
    
    const filtroEstado = document.getElementById('filtro-estado');
    if (filtroEstado) {
        filtroEstado.addEventListener('change', buscarEventos);
    }
}

// Función para buscar eventos con filtros
function buscarEventos() {
    const fecha = document.getElementById('fecha-selector').value;
    const estado = document.getElementById('filtro-estado').value;
    
    // Crear objeto con filtros
    const filtros = {};
    if (fecha) filtros.fecha = fecha;
    if (estado) filtros.estado = estado;
    
    // Cargar eventos con filtros
    cargarEventos(filtros);
}

// Función para crear nuevo turno
function crearNuevoTurno() {
    if (window.api) {
        window.api.showNotification('Función de nuevo turno en desarrollo', 'info');
    } else {
        alert('Función de nuevo turno en desarrollo');
    }
}
