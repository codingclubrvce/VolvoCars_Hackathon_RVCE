package com.suchith.volvo_new;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.GravityCompat;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import com.google.android.material.appbar.MaterialToolbar;
import com.google.android.material.navigation.NavigationView;
import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Customer_support extends AppCompatActivity {
    NavigationView navigationView;
    String txtFeedback, txtRating;
    EditText edtFeedback, edtRating;
    Button btnSubmit;
    Button btnBack;

    private FirebaseFirestore db;





    @SuppressLint("CutPasteId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.customer_support);

        edtFeedback = findViewById(R.id.edtFeedback);
        btnSubmit = findViewById(R.id.btn_submit_feedback_Page);

        btnBack = findViewById(R.id.back_btn_feedback);
        btnBack.setOnClickListener(view -> onBackPressed());




        //Initialize Firebase Fire store
        db = FirebaseFirestore.getInstance();

        btnSubmit.setOnClickListener(view -> {
            //converting edit text data to string Start
            txtFeedback = edtFeedback.getText().toString();
            //converting edit text data to string End

            //check if feedback and rating fields are empty
            if (TextUtils.isEmpty(txtFeedback)) {
                edtFeedback.setError("Please enter your feedback");
                return;
            }



            Map<String, Object> feed = new HashMap<>();
            feed.put("Feedback", txtFeedback);

            db.collection("feedback")
                    .add(feed)
                    .addOnSuccessListener(documentReference -> {
                        Toast.makeText(Customer_support.this, "FeedBack Submitted Successfully !", Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(Customer_support.this, Home_Page.class);
                        startActivity(intent);
                        finish();
                    }).addOnFailureListener(e -> Toast.makeText(Customer_support.this, "Error - " + e.getMessage(), Toast.LENGTH_SHORT).show());
        });



    }



}