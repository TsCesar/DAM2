```bash
ActivityMain.java:
package com.example.examen_sqlite;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class ActivityMain extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        Button botonAñadir = (Button) findViewById(R.id.añadirCarta);
        Button botonBuscar = (Button) findViewById(R.id.consultarColeccion);


        botonAñadir.setOnClickListener(v -> startActivity(new Intent(this, AñadirCarta.class)));
        botonBuscar.setOnClickListener(v -> startActivity(new Intent(this, Buscar.class)));

    }
}

main.xml:
<?xml version="1.0" encoding="utf-8"?>
<androidx.appcompat.widget.LinearLayoutCompat xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical">

    <Button
        android:id="@+id/añadirCarta"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Añadir carta"/>

    <Button
        android:id="@+id/consultarColeccion"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Consultar colección"/>

</androidx.appcompat.widget.LinearLayoutCompat>

AñadirCarta.java:
package com.example.examen_sqlite;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class AñadirCarta extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.anadir);

        SQLite bd = new SQLite(this);

        EditText etNombre = (EditText) findViewById(R.id.nombreNuevaCarta);
        EditText etCoste = (EditText) findViewById(R.id.costeNuevaCarta);
        RadioGroup rgTipos = (RadioGroup) findViewById(R.id.radioElegir);
        Button btnAñadir = (Button) findViewById(R.id.añadirCarta);

        btnAñadir.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String nombre = etNombre.getText().toString().trim();
                String costeStr = etCoste.getText().toString().trim();

                if (nombre.isEmpty() || costeStr.isEmpty()) {
                    Toast.makeText(AñadirCarta.this,
                            "Faltan datos", Toast.LENGTH_SHORT).show();
                    return;
                }

                int coste;
                try {
                    coste = Integer.parseInt(costeStr);
                } catch (NumberFormatException e) {
                    Toast.makeText(AñadirCarta.this,
                            "Coste no válido", Toast.LENGTH_SHORT).show();
                    return;
                }

                String tipo = null;
                for (int i = 0; i < rgTipos.getChildCount(); i++) {
                    View hijo = rgTipos.getChildAt(i);
                    if (hijo instanceof RadioButton) {
                        RadioButton rb = (RadioButton) hijo;
                        if (rb.isChecked()) {
                            tipo = rb.getText().toString();
                            break;
                        }
                    }
                }

                if (tipo == null) {
                    Toast.makeText(AñadirCarta.this,
                            "Elige un tipo", Toast.LENGTH_SHORT).show();
                    return;
                }

                bd.InsertarCarta(tipo, nombre, coste);
                Toast.makeText(AñadirCarta.this,
                        "Carta añadida", Toast.LENGTH_SHORT).show();
                finish();
            }
        });
    }
}

anadir.xml:
<?xml version="1.0" encoding="utf-8"?>
<androidx.appcompat.widget.LinearLayoutCompat xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical">

    <EditText
        android:id="@+id/nombreNuevaCarta"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Nombre"/>

    <EditText
        android:id="@+id/costeNuevaCarta"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Coste"/>

    <RadioGroup
        android:id="@+id/radioElegir"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:orientation="horizontal">
        <RadioButton
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Criatura"/>

        <RadioButton
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Hechizo"/>
        
        <RadioButton
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Habilidad"/>

        <RadioButton
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Daño"/>
    </RadioGroup>


    <Button
        android:id="@+id/añadirCarta"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="añadir"/>

</androidx.appcompat.widget.LinearLayoutCompat>

Buscar.java:
package com.example.examen_sqlite;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class Buscar extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.buscar);

        SQLite bd = new SQLite(this);

        EditText etBuscar = (EditText) findViewById(R.id.cartaBuscar);
        Button btnBuscar = (Button) findViewById(R.id.bucarCarta);
        ListView lvCartas = (ListView) findViewById(R.id.listaCartas);

        ArrayList<String> nombres = bd.ListaDeCartas();

        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, nombres);
        lvCartas.setAdapter(adapter);

        btnBuscar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String nombre = etBuscar.getText().toString().trim();

                if (nombre.isEmpty()) {
                    Toast.makeText(Buscar.this,
                            "Introduce un nombre", Toast.LENGTH_SHORT).show();
                    return;
                }

                if (!nombres.contains(nombre)) {
                    Toast.makeText(Buscar.this,
                            "La carta no existe", Toast.LENGTH_SHORT).show();
                    return;
                }

                Intent i = new Intent(Buscar.this, Carta.class);
                i.putExtra("nombre", nombre);
                startActivity(i);
            }
        });

        lvCartas.setOnItemClickListener((parent, view, position, id) -> {
            String nombreSeleccionado = nombres.get(position);
            Intent i = new Intent(Buscar.this, Carta.class);
            i.putExtra("nombre", nombreSeleccionado);
            startActivity(i);
        });
    }
}


buscar.xml:
<?xml version="1.0" encoding="utf-8"?>
<androidx.appcompat.widget.LinearLayoutCompat xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical">

    <EditText
        android:id="@+id/cartaBuscar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Carta a buscar"/>

    <Button
        android:id="@+id/bucarCarta"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Buscar"/>

    <ListView
        android:id="@+id/listaCartas"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>


</androidx.appcompat.widget.LinearLayoutCompat>

Carta.java:
package com.example.examen_sqlite;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class Carta extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.carta); // tu xml carta.xml

        SQLite bd = new SQLite(this);

        TextView tvNombre = (TextView) findViewById(R.id.tv_nombre_carta);
        TextView tvCoste  = (TextView) findViewById(R.id.tv_coste_carta);
        ImageView ivTipo  = (ImageView) findViewById(R.id.iv_tipo_carta);
        Button btnVolver  = (Button) findViewById(R.id.btn_volver);

        String nombre = getIntent().getStringExtra("nombre");
        tvNombre.setText(nombre);

        SQLiteDatabase db = bd.getReadableDatabase();
        Cursor c = db.rawQuery(
                "SELECT tipo, coste FROM CartasColeccionables WHERE nombre = ?",
                new String[]{nombre}
        );

        if (c.moveToFirst()) {
            int idxTipo  = c.getColumnIndex("tipo");
            int idxCoste = c.getColumnIndex("coste");

            String tipo = c.getString(idxTipo);
            int coste   = c.getInt(idxCoste);

            tvCoste.setText("Coste: " + coste);

            int resId;
            if ("Criatura".equals(tipo)) {
                resId = R.drawable.criatura;
            } else if ("Hechizo".equals(tipo)) {
                resId = R.drawable.hechizo;
            } else if ("Habilidad".equals(tipo)) {
                resId = R.drawable.habilidad;
            } else { // "Daño" u otro
                resId = R.drawable.dano; // crea este drawable
            }

            ivTipo.setImageResource(resId);
        }

        c.close();

        btnVolver.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
    }
}

carta.xml:
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">

    <TextView
        android:id="@+id/tv_nombre_carta"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Nombre"
        android:textSize="20sp" />

    <TextView
        android:id="@+id/tv_coste_carta"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Coste" />

    <ImageView
        android:id="@+id/iv_tipo_carta"
        android:layout_width="120dp"
        android:layout_height="120dp"
        android:layout_marginTop="16dp" />

    <Button
        android:id="@+id/btn_volver"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Volver"
        android:layout_marginTop="16dp" />

</LinearLayout>

SQLite.java:
package com.example.examen_sqlite;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;

public class SQLite extends SQLiteOpenHelper {
    public SQLite (Context context) {super(context, "cartas.db", null, 1);}

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE CartasColeccionables (id INTEGER PRIMARY KEY AUTOINCREMENT, tipo VARCHAR, nombre VARCHAR, coste INTEGER)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE If EXISTS CartasColeccionables");
        onCreate(db);
    }

    public void InsertarCarta(String tipo, String nombre, int coste){
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();

        cv.put("tipo", tipo);
        cv.put("nombre", nombre);
        cv.put("coste",coste);
        db.insert("CartasColeccionables", null, cv);
    }

    public ArrayList<String> ListaDeCartas(){
        SQLiteDatabase db = this.getReadableDatabase();
        ArrayList<String> ListaDeCartas = new ArrayList<>();
        Cursor res = db.rawQuery("SELECT nombre FROM CartasColeccionables", null);
        while (res.moveToNext()){
            int columna = res.getColumnIndex("nombre");
            ListaDeCartas.add(res.getString(columna));
        }

        return ListaDeCartas;
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
        android:theme="@style/Theme.Examen_SqLite">

        <activity
            android:name=".ActivityMain"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <activity android:name=".AñadirCarta" android:exported="true" />
        <activity android:name=".Buscar" android:exported="true" />
        <activity android:name=".Carta" android:exported="false" />

    </application>

</manifest>
```