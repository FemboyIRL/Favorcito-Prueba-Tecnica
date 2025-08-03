
**Instrucciones:** 
### 1. Clonar el repositorio
git clone https://github.com/tu-usuario/weather-app-flutter.git
cd weather-app-flutter

### 2. Obtener una API Key gratuita

1. Ve a https://www.weatherapi.com/
2. Regístrate para obtener una cuenta gratuita
3. Obtén tu API Key desde el dashboard

### 3. Configurar variables de entorno

1. Copia el archivo de ejemplo:
    cp .env.example .env

2. Edita el archivo `.env` y agrega tu API Key: 
    WEATHER_API_KEY=tu_api_key_aqui

### 4. Instalar dependencias
    flutter pub get


### 5. Ejecutar la aplicación

#### Para Android:
    flutter run

#### Para iOS (solo en macOS):
    flutter run -d ios
