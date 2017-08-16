# Breve ejemplo de la importancia del Source Control con Git
## Control de la versión que está en Producción y en Desarrollo a través de ramas (branches)


Este documento trata con una aplicación muy simple en Java que muestra la flexibilidad que provee un SCM como Git para separar la versión que está en Producción de la de está en Desarrollo y a la que se le sigue incorporando funcionalidad. Se incluirá un escenario en el que se detecta un bug en Producción que es imperativo resolver mientras hay trabajo en progreso en Desarrollo que no se quiere perder para que, después de resuelto el bug, se retome para terminarlo.

### Aplicación
Se asume que el lector ha instalado el Java Development Kit en su versión más reciente y dispone de un editor de texto convencional (por ejemplo, Notepad en Windows o Vim en Linux) para crear el siguiente programa:
```java
public class SuperApplication {
    public static void main(String[] args) {
        System.out.println("Super Application v1.0");
    }
}
```
Que evidentemente se guardará en el archivo SuperApplication.java, se compilará y ejecutará como se muestra a continuación:
```
$ javac SuperApplication.java
$ java SuperApplication
Super Application v1.0
$
```
El directorio en el que reside se hace un repositorio local Git con el siguiente comando:
```
$ git init
Initialized empty Git repository
$
```
Por ser una mejor práctica, los archivos ejecutables, los que pueden construirse a partir de los archivos fuente, no se suben a Source Control así que créese el archivo .gitignore en el directorio que recién se ha inicializado como repositorio local de Git con el siguiente contenido:
```
*.class
```
El directorio ahora tiene la siguiente estructura:
```
├── .gitignore
├── SuperApplication.class
└── SuperApplication.java
```
Aunque hay tres archivos, solamente los archivos .gitignore y SuperApplication.java serán controlados por Git.
