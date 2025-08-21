// JavaScript específico para nuevo-paciente.html

// Inicializar cuando se carga la página
document.addEventListener('DOMContentLoaded', function() {
    // Conectar el formulario con la función de crear paciente
    const form = document.getElementById('formNuevoPaciente');
    if (form) {
        form.addEventListener('submit', crearPaciente);
        // Agregar validación en tiempo real
        setupFormValidation(form);
    }
    
    // Conectar botón limpiar
    const btnLimpiar = document.getElementById('btn-limpiar');
    if (btnLimpiar) {
        btnLimpiar.addEventListener('click', limpiarFormulario);
    }
});

// Función para configurar validación en tiempo real
function setupFormValidation(form) {
    // Validar campos requeridos al salir del foco
    const requiredFields = form.querySelectorAll('[required]');
    requiredFields.forEach(field => {
        field.addEventListener('blur', () => validateField(field));
        field.addEventListener('input', () => clearFieldError(field));
    });
    
    // Validaciones específicas
    const emailField = form.querySelector('#email');
    if (emailField) {
        emailField.addEventListener('blur', () => validateEmail(emailField));
    }
    
    const dniField = form.querySelector('#dni');
    if (dniField) {
        dniField.addEventListener('blur', () => validateDNI(dniField));
    }
    
    const telefonoField = form.querySelector('#telefono');
    if (telefonoField) {
        telefonoField.addEventListener('blur', () => validateTelefono(telefonoField));
    }
}

// Función para validar un campo individual
function validateField(field) {
    const value = field.value.trim();
    let isValid = true;
    let errorMessage = '';
    
    // Validar campos requeridos
    if (field.required && !value) {
        isValid = false;
        errorMessage = `El campo ${getFieldLabel(field)} es obligatorio.`;
    }
    
    // Validar longitud mínima
    if (value && field.minLength && value.length < field.minLength) {
        isValid = false;
        errorMessage = `El campo debe tener al menos ${field.minLength} caracteres.`;
    }
    
    // Mostrar/ocultar error
    showFieldError(field, isValid ? '' : errorMessage);
    
    return isValid;
}

// Función para validar email
function validateEmail(field) {
    const value = field.value.trim();
    if (!value) return true; // Email es opcional
    
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const isValid = emailRegex.test(value);
    
    showFieldError(field, isValid ? '' : 'Por favor ingrese un email válido.');
    return isValid;
}

// Función para validar DNI
function validateDNI(field) {
    const value = field.value.trim();
    if (!value) return true; // DNI es opcional
    
    const dniRegex = /^\d{7,8}$/;
    const isValid = dniRegex.test(value);
    
    showFieldError(field, isValid ? '' : 'El DNI debe tener 7 u 8 dígitos sin puntos.');
    return isValid;
}

// Función para validar teléfono
function validateTelefono(field) {
    const value = field.value.trim();
    if (!value) return true; // Teléfono es opcional
    
    // Regex más flexible para teléfonos argentinos
    const telRegex = /^[\+]?[0-9\s\-\(\)]{8,15}$/;
    const isValid = telRegex.test(value);
    
    showFieldError(field, isValid ? '' : 'Por favor ingrese un teléfono válido.');
    return isValid;
}

// Función para mostrar error en campo
function showFieldError(field, message) {
    const errorElement = document.getElementById(field.getAttribute('aria-describedby')?.split(' ').find(id => id.includes('error')));
    
    if (message) {
        field.classList.add('is-invalid');
        field.classList.remove('is-valid');
        if (errorElement) {
            errorElement.textContent = message;
        }
    } else {
        field.classList.remove('is-invalid');
        field.classList.add('is-valid');
        if (errorElement) {
            errorElement.textContent = '';
        }
    }
}

// Función para limpiar error de campo
function clearFieldError(field) {
    field.classList.remove('is-invalid', 'is-valid');
    const errorElement = document.getElementById(field.getAttribute('aria-describedby')?.split(' ').find(id => id.includes('error')));
    if (errorElement) {
        errorElement.textContent = '';
    }
}

// Función para obtener el label de un campo
function getFieldLabel(field) {
    const label = document.querySelector(`label[for="${field.id}"]`);
    return label ? label.textContent.replace('*', '').trim() : field.name || field.id;
}

// Función para validar todo el formulario
function validateForm(form) {
    let isValid = true;
    
    // Validar todos los campos requeridos
    const requiredFields = form.querySelectorAll('[required]');
    requiredFields.forEach(field => {
        if (!validateField(field)) {
            isValid = false;
        }
    });
    
    // Validar campos específicos
    const emailField = form.querySelector('#email');
    if (emailField && !validateEmail(emailField)) {
        isValid = false;
    }
    
    const dniField = form.querySelector('#dni');
    if (dniField && !validateDNI(dniField)) {
        isValid = false;
    }
    
    const telefonoField = form.querySelector('#telefono');
    if (telefonoField && !validateTelefono(telefonoField)) {
        isValid = false;
    }
    
    return isValid;
}

// Función para limpiar el formulario
function limpiarFormulario() {
    const form = document.getElementById('formNuevoPaciente');
    if (form && confirm('¿Está seguro de que desea limpiar todos los campos?')) {
        form.reset();
    }
}
