# 🔌 Documentación de API - DentalPro

Esta documentación describe todos los endpoints disponibles en la API de DentalPro.

## 🌐 Información General

- **Base URL**: `https://odonto.chilldigital.tech/api/`
- **Backend**: N8N workflows con webhooks
- **Autenticación**: No requerida (endpoints públicos para el frontend)
- **Formato**: JSON
- **Rate Limiting**: 10 requests/segundo para API, 30/segundo general

## 📊 Endpoints

### 1. Estadísticas del Dashboard

Obtiene métricas generales del consultorio.

**GET** `/api/estadisticas`

#### Respuesta Exitosa (200)
```json
{
  "success": true,
  "data": {
    "totalPacientes": 150,
    "turnosHoy": 8,
    "turnosSemana": 45,
    "ultimoRegistro": 2
  },
  "timestamp": "2024-08-21T15:30:00Z"
}
```

#### Campos de Respuesta
| Campo | Tipo | Descripción |
|-------|------|-------------|
| `totalPacientes` | number | Total de pacientes registrados |
| `turnosHoy` | number | Turnos programados para hoy |
| `turnosSemana` | number | Turnos de esta semana |
| `ultimoRegistro` | number | Días desde el último paciente registrado |

---

### 2. Gestión de Pacientes

#### Listar Pacientes

Obtiene la lista de todos los pacientes con paginación opcional.

**GET** `/api/pacientes`

#### Parámetros de Query (Opcionales)
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `page` | number | Página (por defecto: 1) |
| `limit` | number | Resultados por página (por defecto: 50) |
| `search` | string | Buscar por nombre |
| `obra_social` | string | Filtrar por obra social |

#### Ejemplo de Request
```bash
GET /api/pacientes?search=juan&obra_social=OSDE&page=1&limit=10
```

#### Respuesta Exitosa (200)
```json
{
  "success": true,
  "data": [
    {
      "id": "recABC123XYZ",
      "fields": {
        "Nombre": "Juan Pérez",
        "DNI": "12345678",
        "Telefono": "+54 11 1234-5678",
        "Email": "juan@email.com",
        "Obra Social": "OSDE",
        "Numero Afiliado": "123456789",
        "Fecha Nacimiento": "1985-03-15",
        "Historia Clinica": "Paciente con...",
        "Alergias": "Penicilina",
        "Antecedentes": ["Hipertensión"],
        "Fecha Registro": "2024-08-20"
      },
      "createdTime": "2024-08-20T10:30:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 150,
    "pages": 15
  }
}
```

---

#### Crear Paciente

Registra un nuevo paciente en el sistema.

**POST** `/api/pacientes`

#### Body de Request
```json
{
  "nombre": "María García",
  "dni": "87654321",
  "telefono": "+54 11 8765-4321",
  "email": "maria@email.com",
  "obra_social": "Swiss Medical",
  "numero_afiliado": "SM987654",
  "fecha_nacimiento": "1990-07-22",
  "historia_clinica": "Primera consulta. Paciente refiere dolor en muela superior derecha...",
  "alergias": "Aspirina, mariscos",
  "antecedentes": ["Diabetes", "Hipertensión"]
}
```

#### Campos Requeridos
| Campo | Tipo | Validación |
|-------|------|------------|
| `nombre` | string | Mínimo 2 caracteres |
| `obra_social` | string | Valor del select |
| `historia_clinica` | string | Mínimo 10 caracteres |

#### Campos Opcionales
| Campo | Tipo | Validación |
|-------|------|------------|
| `dni` | string | 7-8 dígitos |
| `telefono` | string | Formato flexible |
| `email` | string | Email válido |
| `numero_afiliado` | string | Alfanumérico |
| `fecha_nacimiento` | string | Formato YYYY-MM-DD |
| `alergias` | string | Texto libre |
| `antecedentes` | array | Lista de strings |

#### Respuesta Exitosa (201)
```json
{
  "success": true,
  "data": {
    "id": "recNEW123XYZ",
    "message": "Paciente creado exitosamente"
  },
  "timestamp": "2024-08-21T15:30:00Z"
}
```

#### Errores de Validación (400)
```json
{
  "success": false,
  "error": "Validation failed",
  "details": {
    "nombre": "El nombre es obligatorio",
    "historia_clinica": "Debe tener al menos 10 caracteres"
  }
}
```

---

## 🚨 Códigos de Error

### Códigos HTTP Estándar
| Código | Significado | Descripción |
|--------|-------------|-------------|
| `200` | OK | Request exitoso |
| `201` | Created | Recurso creado exitosamente |
| `400` | Bad Request | Error en los datos enviados |
| `404` | Not Found | Recurso no encontrado |
| `429` | Too Many Requests | Rate limit excedido |
| `500` | Internal Server Error | Error interno del servidor |

### Estructura de Errores
```json
{
  "success": false,
  "error": "Error code",
  "message": "Descripción legible del error",
  "details": {
    "field": "Detalles específicos del campo"
  },
  "timestamp": "2024-08-21T15:30:00Z"
}
```

## 🧪 Testing de API

### Con curl
```bash
# Test estadísticas
curl -X GET "https://odonto.chilldigital.tech/api/estadisticas" \
  -H "Accept: application/json"

# Test crear paciente
curl -X POST "https://odonto.chilldigital.tech/api/pacientes" \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Test User",
    "obra_social": "OSDE",
    "historia_clinica": "Paciente de prueba para testing de API"
  }'
```

### Con JavaScript (Frontend)
```javascript
// Configuración base
const API_BASE = 'https://odonto.chilldigital.tech/api';

// Obtener estadísticas
const getStats = async () => {
  const response = await fetch(`${API_BASE}/estadisticas`);
  return response.json();
};

// Crear paciente
const createPatient = async (data) => {
  const response = await fetch(`${API_BASE}/pacientes`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  });
  return response.json();
};
```

---

**¡La API está lista para usar!** 🚀

Para más información, consulta el [README principal](../README.md) o la [guía de setup](setup.md).
