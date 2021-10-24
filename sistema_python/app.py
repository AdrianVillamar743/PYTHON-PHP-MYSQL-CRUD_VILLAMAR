from flask import Flask
from flask import render_template,request, redirect,url_for
from flaskext.mysql import MySQL
from datetime import datetime
from flask import send_from_directory
import os



app= Flask(__name__)
mysql=MySQL()
app.config['MYSQL_DATABASE_HOST']='localhost'
app.config['MYSQL_DATABASE_USER']='root'
app.config['MYSQL_DATABASE_DB']='sistema_python'
app.config['MYSQL_DATABASE_PASSWORD']=''
mysql.init_app(app)

CARPETA=os.path.join('uploads')
app.config['CARPETA']=CARPETA

@app.route('/uploads/<nombreFoto>')
def uploads(nombreFoto):
    return send_from_directory(app.config['CARPETA'],nombreFoto)

@app.route('/destroy/<int:id>')
def destroy(id):
    conn=mysql.connect()
    cursor=conn.cursor()
    cursor.execute("select foto from empleados where id=%s",id)
    fila=cursor.fetchall()
    os.remove(os.path.join(app.config['CARPETA'],fila[0][0]))    
       
    cursor.execute("update empleados set estado='INACTIVO' where id=%s",(id))
    conn.commit()
    return redirect ('/')
    
@app.route('/edit/<int:id>')
def edit(id):
    conn=mysql.connect()
    cursor=conn.cursor()
    cursor.execute("select *from empleados where estado='ACTIVO' and id=%s",(id))
    empleados=cursor.fetchall()
    conn.commit()
    print(empleados)
    
    return render_template('empleados/edit.html',empleados=empleados) 



@app.route('/')
def index ():
    sql="select *from empleados WHERE estado ='ACTIVO'"
    conn=mysql.connect()
    cursor=conn.cursor()
    cursor.execute(sql)
    empleados=cursor.fetchall()
    print(empleados)
    conn.commit()
    return render_template ('empleados/index.html',empleados=empleados)

@app.route('/create')
def create():
    return render_template('empleados/create.html')





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
    sql="INSERT INTO empleados (nombre,correo,foto,estado) VALUES (%s, %s, %s,'ACTIVO')"
    datos=(_nombre,_correo,nuevoNombreFoto)
    conn=mysql.connect()
    cursor=conn.cursor()
    cursor.execute(sql,datos)
    conn.commit()
    return redirect('/')

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

    now=datetime.now()
    tiempo=now.strftime("%Y%H%M%S")
    if _foto.filename!='':
       nuevoNombreFoto=tiempo+_foto.filename
       _foto.save("uploads/"+nuevoNombreFoto)
       cursor.execute("select foto from empleados where id=%s",_id)
       fila=cursor.fetchall()
       os.remove(os.path.join(app.config['CARPETA'],fila[0][0]))    
       cursor.execute("UPDATE empleados set foto=%s where id=%s",(nuevoNombreFoto,_id))
       conn.commit()
    
    cursor.execute(sql,datos)
    conn.commit()
    return redirect('/')



if __name__=='__main__':
    app.run(debug=True)