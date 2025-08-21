// JavaScript específico para index.html (Dashboard)

// Inicializar cuando se carga la página
document.addEventListener('DOMContentLoaded', function() {
    // Cargar datos del dashboard
    loadDashboardStats();
    loadRecentPatients();
    
    // Agregar event listeners
    initializeEventListeners();
});

// Función para inicializar todos los event listeners del dashboard
function initializeEventListeners() {
    // Botón sincronizar datos
    const btnSincronizar = document.getElementById('btn-sincronizar');
    if (btnSincronizar) {
        btnSincronizar.addEventListener('click', sincronizarDatos);
    }
}

// Función para sincronizar datos
function sincronizarDatos() {
    if (window.api) {
        window.api.showNotification('Sincronización iniciada', 'info');
        // Recargar estadísticas
        loadDashboardStats();
        loadRecentPatients();
    } else {
        console.warn('API no disponible');
    }
}
