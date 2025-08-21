// API Configuration y comunicación con N8N
// Este archivo maneja toda la comunicación con tu servidor N8N

// Configuración de la API
const API_CONFIG = {
    baseUrl: 'https://n8n.chilldigital.tech/webhook',
    timeout: 30000
};

// Clase principal para manejar las llamadas a la API
class DentalAPI {
    constructor() {
        this.baseUrl = API_CONFIG.baseUrl;
    }

    // Función base para hacer peticiones HTTP
    async request(endpoint, options = {}) {
        const url = `${this.baseUrl}/${endpoint}`;
        const config = {
            headers: {
                'Content-Type': 'application/json',
                ...options.headers
            },
            ...options
        };

        try {
            const response = await fetch(url, config);
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            return await response.json();
        } catch (error) {
            console.error('API Error:', error);
            this.showNotification('Error de conexión', 'error');
            throw error;
        }
    }

    // === MÉTODOS PARA PACIENTES ===
    async getPacientes(filtros = {}) {
        const params = new URLSearchParams(filtros).toString();
        const query = params ? `?${params}` : '';
        return this.request(`pacientes${query}`);
    }

    async createPaciente(datos) {
        return this.request('pacientes', {
            method: 'POST',
            body: JSON.stringify(datos)
        });
    }

    async getPaciente(id) {
        return this.request(`pacientes/${id}`);
    }

    // === MÉTODOS PARA CALENDARIO ===
    async getEventos(filtros = {}) {
        const params = new URLSearchParams(filtros).toString();
        return this.request(`calendario?${params}`);
    }

    // === MÉTODOS PARA ESTADÍSTICAS ===
    async getEstadisticas() {
        return this.request('estadisticas');
    }

    // === UTILIDADES DE INTERFAZ ===
    showNotification(message, type = 'info') {
        const alertClass = type === 'error' ? 'alert-danger' : 
                          type === 'success' ? 'alert-success' : 'alert-info';
        
        const alert = document.createElement('div');
        alert.className = `alert ${alertClass} alert-dismissible fade show position-fixed`;
        alert.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
        alert.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        document.body.appendChild(alert);
        
        setTimeout(() => {
            if (alert.parentNode) {
                alert.remove();
            }
        }, 5000);
    }

    showLoading(element) {
        element.innerHTML = `
            <div class="text-center">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Cargando...</span>
                </div>
            </div>
        `;
    }
}

// Instancia global de la API que se puede usar en todos los archivos
const api = new DentalAPI();
