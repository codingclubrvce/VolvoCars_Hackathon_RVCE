package com.suchith.volvo_new;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.Button;
import android.widget.EditText;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.android.material.button.MaterialButton;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;

public class ba_volvo_xc90 extends AppCompatActivity {



    private RecyclerView recyclerView;
    private Adapter_volvo_xc90 adapter;
    private MaterialButton backBtn;
//    private EditText searchEditText;
    private DatabaseReference databaseReference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ba_volvo_xc90);

//        Button Button2 = findViewById(R.id.nuts_bolts_form);
//        Button2.setOnClickListener(v -> {
//            Intent intent1 = new Intent(Aa_nuts_bolts.this, ab_nuts_bolts_form.class);
//            startActivity(intent1);
//        });

        recyclerView = findViewById(R.id.ba_xc90_recycle_view);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        backBtn = findViewById(R.id.back_btn_xc90);
      //  searchEditText = findViewById(R.id.search_edit_text);

        databaseReference = FirebaseDatabase.getInstance().getReference().child("volvo_XC90_Spares");

        FirebaseRecyclerOptions<Model_volvo_xc90> options =
                new FirebaseRecyclerOptions.Builder<Model_volvo_xc90>()
                        .setQuery(databaseReference, Model_volvo_xc90.class)
                        .build();

        adapter = new Adapter_volvo_xc90(options);
        recyclerView.setAdapter(adapter);

        backBtn.setOnClickListener(v -> finish());

//        searchEditText.addTextChangedListener(new TextWatcher() {
//            @Override
//            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
//
//            @Override
//            public void onTextChanged(CharSequence s, int start, int before, int count) {}
//
//            @Override
//            public void afterTextChanged(Editable s) {
//                filterByAssetId(s.toString());
//            }
//        });
    }

//    private void filterByAssetId(String assetId) {
//        Query query;
//        if (assetId.isEmpty()) {
//            query = databaseReference;
//        } else {
//            query = databaseReference.orderByChild("asset_id_aa2")
//                    .startAt(assetId)
//                    .endAt(assetId + "\uf8ff");
//        }
//
//        FirebaseRecyclerOptions<Model_aa_nuts_bolts> newOptions =
//                new FirebaseRecyclerOptions.Builder<Model_aa_nuts_bolts>()
//                        .setQuery(query, Model_aa_nuts_bolts.class)
//                        .build();
//
//        adapter.updateOptions(newOptions);
//        adapter.notifyDataSetChanged();
//    }

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