// JavaScript específico para pacientes.html

// Inicializar cuando se carga la página
document.addEventListener('DOMContentLoaded', function() {
    // Cargar la lista de pacientes
    loadPacientes();
    
    // Inicializar event listeners
    initializeEventListeners();
});

// Función para inicializar todos los event listeners
function initializeEventListeners() {
    // Botón de búsqueda
    const btnBuscar = document.getElementById('btn-buscar');
    if (btnBuscar) {
        btnBuscar.addEventListener('click', buscarPacientes);
    }
    
    // Input de búsqueda (para buscar mientras escribe)
    const inputBuscar = document.getElementById('buscar');
    if (inputBuscar) {
        inputBuscar.addEventListener('input', debounce(buscarPacientes, 500));
        // También permitir buscar con Enter
        inputBuscar.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                buscarPacientes();
            }
        });
    }
    
    // Select de obra social
    const selectObraSocial = document.getElementById('obra_social_filter');
    if (selectObraSocial) {
        selectObraSocial.addEventListener('change', buscarPacientes);
    }
    
    // Botón limpiar filtros
    const btnLimpiarFiltros = document.getElementById('btn-limpiar-filtros');
    if (btnLimpiarFiltros) {
        btnLimpiarFiltros.addEventListener('click', limpiarFiltros);
    }
    
    // Botón exportar
    const btnExportar = document.getElementById('btn-exportar');
    if (btnExportar) {
        btnExportar.addEventListener('click', exportarPacientes);
    }
}

// Función para limpiar filtros
function limpiarFiltros() {
    document.getElementById('buscar').value = '';
    document.getElementById('obra_social_filter').value = '';
    // Recargar la lista completa
    if (typeof loadPacientes === 'function') {
        loadPacientes();
    }
}

// Función para exportar pacientes
function exportarPacientes() {
    if (window.api) {
        window.api.showNotification('Función de exportar en desarrollo', 'info');
    } else {
        alert('Función de exportar en desarrollo');
    }
}
