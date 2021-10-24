# PYTHON-PHP-MYSQL-CRUD
 Pequeño ejemplo de aplicación web PYTHON-MYSQL-PHP
 
 
1.- Debemos crear una carpeta donde alojaremos nuestro proyecto

2.- Una vez creado debemos cersioararnos de haber instalado python y que haya sido añadido a nuestra variable de entorno path

3.- Para comprobarlo utilizamos el comando path

4.- Si nos devuelve la versión de python instalada nos dirigimos a la carpeta del proyecto y luego ejecutaremos el siguiente comando dentro de la terminal
pip install flask

5.- Una vez instalado verificamos que esté añadido en la lista de paquetes con el comando pip list

6.- En nuestro caso necesitaremos que la aplicación se conecte con MySQL, así que debemos instalar el paquete de comunicaciones con el siguiente comando.
pip install Flask-MySQL

7.- Debemos instalar el template de acceso a html con el comando 
pip install jinja2

8.- Luego de haber instalado todo en nuestra carpeta del proyecto.
Crearemos dos carpetar nuevas una llamada templates, dentro de ella otra llamada empleados y dentro de empleados un archivo llamado index.html

9.- Dentro del mismo ejecutamos el siguiente codigo

from flask import  Flask 
from flask import render_template
app=Flask(__name__)
@app.route('/')
def index():
     return render_template('empleados/index.html')
if __name__=='__main__':
    app.run(debug=True)


Siendo render template el parametro de la ruta de nuestro index.html

10.- En este punto ya hemos creado archivos dentro de la carpeta empleados archivos como create.html, edit.html.
Para generar la ruta dentro del archivo principal referenciamos con el siguiente comando.

@app.route('/create')
def method_name():
  return render_template('empleados/create.html')

Donde '/create' es el nombre que le asignamos a la ruta para acceder a ella. Y el parametro de render_template es el archivo al que vamos a acceder por medio de la misma.

11.- Al ser un proceso de envío y recepció de datos definiremos nuestra ruta como almacenamiento y recepción en el método post, el cual se especificará dentro de los parametros de la función quedando el código completo de esa parte de la siguiente manera

@app.route('/store', methods=['POST'])
def storage():
    _nombre=request.form['txtNombre']
    _correo=request.form['txtCorreo']
    _foto=request.files['txtFoto']
    now=datetime.now()
    tiempo=now.strftime("%Y%H%M%S")
    if _foto.filename!='':
       nuevoNombreFoto=tiempo+_foto.filename
       _foto.save("uploads/"+nuevoNombreFoto)
    sql="INSERT INTO empleados (nombre,correo,foto) VALUES (%s, %s, %s)"
    datos=(_nombre,_correo,nuevoNombreFoto)
    conn=mysql.connect()
    cursor=conn.cursor()
    cursor.execute(sql,datos)
    conn.commit()
    return render_template('empleados/index.html')


12.- Dicho ello el código anterior nos permite enviar los datos y almacenarlos temporalmente, verificar que el nombre de la foto es decir el archivo no esté vacío y que su nombre no se repita utilizando formato de fecha y hora concatenado al nombre original.

13. Ahora mostraremos los datos dentro de una tabla para ello utilizaremos el siguiente comando una consulta simple dentro de nuestro app route inicial, asignaremos una variable que recoja los valores y lo enviaremos por parametros del render template para posterior consumo, quedando de la siguiente forma.

@app.route('/')
def index ():
    sql="select *from empleados"
    conn=mysql.connect()
    cursor=conn.cursor()
    cursor.execute(sql)
    empleados=cursor.fetchall()
    print(empleados)
    conn.commit()
    return render_template ('empleados/index.html',empleados=empleados)


/*index.html*/
  <tbody>
                        {% for empleado in empleados  %}
                        <tr>
                            <td>{{empleado[0]}}</td>
                            <td>{{empleado[1]}}</td>
                            <td>{{empleado[2]}}</td>
                            <td>{{empleado[3]}}</td>
                            <td>Editar|Borrar</td>
                       </tr>
                        {% endfor %}
                    </tbody>


Donde se recibe y muestra de acuerdo al orden de los datos obtenidos de la consulta, no olvides verificar la tabla.
Y haber instalado jinja 2 para hacer este consumo

14.- Siguiendo la lógica del create creamos el update

@app.route('/update', methods=['POST'])
def update():
    _nombre=request.form['txtNombre']
    _correo=request.form['txtCorreo']
    _foto=request.files['txtFoto']
    _id=request.form['txtID']
    sql="update empleados set nombre=%s, correo=%s where id=%s "
    datos=(_nombre,_correo,_id)
    conn=mysql.connect()
    cursor=conn.cursor()
    cursor.execute(sql,datos)
    conn.commit()
    return redirect('/')

15.- Esa actualización de datos no contempla la foto, por lo que definiremos una variable que nos permita importar la ruta es decir importaremos la siguiente libreria

import os

Y definiremos el path a donde van las imagenes y almacenar esa ruta como configuraión de la aplicación

CARPETA=os.path.join('uploads')
app.config['CARPETA']=CARPETA

16.- Ahora para dar un formato adecuado a nuestros documentos separaremos la cabecera de estilos y el pie del documento para poder utilizarlos de acuerdo a nuestra conveniencia, se generarán dos archivos html, header.html y footer.html los cuales serán referenciados dentro de otros documentos mediante el uso de jinja include.

{% include 'header.html' %}
<form method="POST" action="/store" enctype="multipart/form-data">
    Nombre:
    <input type="text" name='txtNombre' id='txtNombre'>
    <br>
    Correo:
    <input type="text" name="txtCorreo" id="txtCorreo">
    <br>
    <input type="file" name="txtFoto" id="txtFoto">
    <br>
    <input type="submit" value="Agregar">
</form>
{% include 'footer.html' %}

17.- Ahora mostraremos la foto dentro de nuestra tabla utilizando en el archivo index la propiedad src del componente img es decir

 <img class ="img-thumbnail" width="100" src="uploads/{{empleado[3]}}" alt="">
                                
Donde empleado[3] es el nomre del archivo complementado con la ruta donde se almacena.

18.- Pero tambien en nuestro archivo app.py necesitamos importar el acceso a la dirección del archivo mediante la siguiente libreria

from flask import send_from_directory

Y definir el acceso a la misma y retornando la ruta donde se almacena

@app.route('/uploads/<nombreFoto>')
def uploads(nombreFoto):
    return send_from_directory(app.config['CARPETA'],nombreFoto)

19.- En el componente editar tambien necesitamos mostrar la imagen por lo que haremos referencia al metodo url_for dentro de la importación es decir 

from flask import render_template,request, redirect,url_for

Y dentro del metodo edit cargamos la imagen con la siguiente sentencia

 <img class ="img-thumbnail" width="100" src="{{ url_for('uploads',nombreFoto=empleado[3])}}" alt="">
   





