```bash
ActivityMain.java:
package com.example.examen_sqlite2;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.ToggleButton;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class ActivityMain extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
    }

    @Override
    protected void onResume() {
        super.onResume();

        ProgressBar progressBar = (ProgressBar) findViewById(R.id.progresBar);
        SqLite db = new SqLite(this);

        int contador = db.contarContraseñas(); // 0–5
        // Si la barra tiene max=100 y máximo 5 contraseñas → 20 por cada una
        progressBar.setProgress(20 * contador);
    }

    public void miFuncion(View Button){
        ToggleButton toggleButton = (ToggleButton) findViewById(R.id.toggleButton1);

        if (toggleButton.isChecked()){
            startActivity(new Intent(this, AñadirContraseñas.class));
        } else {
            startActivity(new Intent(this, MostrarContraseñas.class));
        }
    }
}

main.xml:
<?xml version="1.0" encoding="utf-8"?>
<androidx.appcompat.widget.LinearLayoutCompat xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical">

    <ToggleButton
        android:id="@+id/toggleButton1"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:textOn="Introducción"
        android:textOff="Consulta"/>

    <Button
        android:id="@+id/boton1"
        android:onClick="miFuncion"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Seleccionar"/>

    <ProgressBar
        android:id="@+id/progresBar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        style="?android:attr/progressBarStyleHorizontal"
        android:progress="0"
        android:max="100"/>

</androidx.appcompat.widget.LinearLayoutCompat>

AñadirContraseñas.java:
package com.example.examen_sqlite2;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class AñadirContraseñas extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.anadir_contrasenas);

        EditText Nombre = (EditText) findViewById(R.id.Nombre);
        EditText Contraseña = (EditText) findViewById(R.id.Contraseña);
        Button Añadir = (Button) findViewById(R.id.botonAñadir);

        SqLite db = new SqLite(this);

        if (db.contarContraseñas() == 5){
            Toast.makeText(this, "La base de datos esta llena", Toast.LENGTH_LONG).show();
            finish();
        } else {
            Añadir.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    String nombre = Nombre.getText().toString().trim();
                    String contraseña = Contraseña.getText().toString().trim();
                    if (nombre.isEmpty()) {
                        Toast.makeText(getApplicationContext(), "Faltan datos1", Toast.LENGTH_SHORT).show();
                    } else if (contraseña.isEmpty()){
                        Toast.makeText(getApplicationContext(), "Faltan datos2", Toast.LENGTH_SHORT).show();
                    } else {
                        db.añadirContraseña(nombre, contraseña);
                        Toast.makeText(getApplicationContext(), "Se ha añadido una Contaseña del ususario: " + nombre, Toast.LENGTH_LONG).show();
                        finish();
                    }
                }
            });
        }

    }
}

anadir_contraseñas.xml:
<?xml version="1.0" encoding="utf-8"?>
<androidx.appcompat.widget.LinearLayoutCompat xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical">

    <EditText
        android:id="@+id/Nombre"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Introduce el nombre"/>

    <EditText
        android:id="@+id/Contraseña"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Introduce su contraseña"
        android:inputType="textPassword"/>

    <Button
        android:id="@+id/botonAñadir"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Añadir"/>

</androidx.appcompat.widget.LinearLayoutCompat>

MostrarContraseñas.java:
package com.example.examen_sqlite2;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class MostrarContraseñas extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.mostrar_contrasenas);

        EditText nombreMostrar = (EditText) findViewById(R.id.NombreMostrar);
        TextView contraseñaMostrar = (TextView) findViewById(R.id.ContraseñaMostrar);
        Button botonMostrar = (Button) findViewById(R.id.botonMostrar);

        SqLite db = new SqLite(this);

        botonMostrar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String nombre = nombreMostrar.getText().toString().trim();

                if (nombre.isEmpty()) {
                    Toast.makeText(MostrarContraseñas.this,
                            "Introduce un nombre", Toast.LENGTH_SHORT).show();
                    return;
                }

                String contraseña = db.obtenerContraseñaPorNombre(nombre);

                if (contraseña == null || contraseña.isEmpty()) {
                    contraseñaMostrar.setText("No se encontró contraseña para ese nombre");
                } else {
                    contraseñaMostrar.setText(contraseña);
                }
            }
        });
    }
}

mostrar_contrasenas.xml:
<?xml version="1.0" encoding="utf-8"?>
<androidx.appcompat.widget.LinearLayoutCompat xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical">

    <EditText
        android:id="@+id/NombreMostrar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Introduce el nombre"/>

    <TextView
        android:id="@+id/ContraseñaMostrar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Contraseña a mostrar por nombre"/>

    <Button
        android:id="@+id/botonMostrar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Mostrar"/>

</androidx.appcompat.widget.LinearLayoutCompat>

SqLite.java:
package com.example.examen_sqlite2;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.widget.Toast;

import java.util.ArrayList;

public class SqLite  extends SQLiteOpenHelper {
    public SqLite (Context context) {super(context, "contraseñas.db", null, 1);}

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE contraseñas (id INTEGER PRIMARY KEY AUTOINCREMENT, usuario VARCHAR, contraseña VARCHAR)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE If EXISTS contraseñas");
        onCreate(db);
    }

    public void añadirContraseña(String usuario, String contraseña){
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();

        cv.put("usuario", usuario);
        cv.put("contraseña", contraseña);
        db.insert("contraseñas", null, cv);
    }

    public ArrayList<String> listaContraseñas() {
        SQLiteDatabase db = this.getReadableDatabase();
        ArrayList<String> listaContraseñas = new ArrayList<>();

        Cursor res = db.rawQuery("SELECT usuario FROM contraseñas", null);

        while (res.moveToNext()) {
            int columna = res.getColumnIndex("usuario");
            listaContraseñas.add(res.getString(columna));
        }

        return listaContraseñas;
    }

    public int contarContraseñas() {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res = db.rawQuery("SELECT COUNT(id) FROM contraseñas", null);

        int contador =0;

        if (res.moveToFirst()){
            contador=res.getInt(0);
        }

        return contador;
    }

    public String obtenerContraseñaPorNombre(String usuario) {
        SQLiteDatabase db = this.getReadableDatabase();
        String contraseña = null;

        Cursor res = db.rawQuery("SELECT contraseña FROM contraseñas WHERE usuario = ?", new String[]{usuario}
        );

        if (res.moveToFirst()) {
            int columna = res.getColumnIndex("contraseña");
            if (columna != -1) {
                contraseña = res.getString(columna);
            }
        }

        res.close();
        return contraseña;
    }
}

Manifest.xml:
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <application
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.Examen_SqLite2">

        <activity
            android:name=".ActivityMain"
            android:exported="true">
            <intent-filter>
                <category android:name="android.intent.category.LAUNCHER"/>
                <action android:name="android.intent.action.MAIN"/>
            </intent-filter>
        </activity>

        <activity android:name=".AñadirContraseñas" android:exported="true"/>
        <activity android:name=".MostrarContraseñas" android:exported="true"/>
    </application>

</manifest>
```