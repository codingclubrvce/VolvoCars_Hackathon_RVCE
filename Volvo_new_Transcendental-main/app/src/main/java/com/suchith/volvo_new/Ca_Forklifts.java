package com.suchith.volvo_new;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.Button;
import android.widget.EditText;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.android.material.button.MaterialButton;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;

public class Ca_Forklifts extends AppCompatActivity {



    private RecyclerView recyclerView;
    private Adapter_forklifts adapter;

    private DatabaseReference databaseReference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ca_forklifts);



        recyclerView = findViewById(R.id.ca_fork_recycle_view);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));



        databaseReference = FirebaseDatabase.getInstance().getReference().child("Forklifts");

        FirebaseRecyclerOptions<Model_Forklifts> options =
                new FirebaseRecyclerOptions.Builder<Model_Forklifts>()
                        .setQuery(databaseReference, Model_Forklifts.class)
                        .build();

        adapter = new Adapter_forklifts(options);
        recyclerView.setAdapter(adapter);


    }



    @Override
    protected void onStart() {
        super.onStart();
        adapter.startListening();
    }

    @Override
    protected void onStop() {
        super.onStop();
        adapter.stopListening();
    }
}