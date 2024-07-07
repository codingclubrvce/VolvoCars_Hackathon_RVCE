package com.suchith.volvo_new;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.google.firebase.auth.FirebaseAuth;

public class Home_Page extends AppCompatActivity {

    private CardView assetManagementCard, spareManagementCard, maintenanceCard,
            analyticsCard, customerSupportCard, settingsCard;
    private FirebaseAuth mAuth;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_page);



        // Initialize CardViews
        assetManagementCard = findViewById(R.id.hp_card1);
        spareManagementCard = findViewById(R.id.hp_card2);
        maintenanceCard = findViewById(R.id.hp_card3);
        analyticsCard = findViewById(R.id.hp_card4);
        customerSupportCard = findViewById(R.id.hp_card5);
        settingsCard = findViewById(R.id.hp_card6);

//        // Logout Button Start
//        mAuth = FirebaseAuth.getInstance();
//        Button btn_Logout = findViewById(R.id.Log_out_btn);
//        btn_Logout.setOnClickListener(v -> {
//            // Show dialog box asking user to confirm logout
//            new AlertDialog.Builder(Home_Page.this)
//                    .setTitle("Logout")
//                    .setMessage("Are you sure you want to logout?")
//                    .setPositiveButton(android.R.string.yes, (dialog, which) -> {
//                        mAuth.signOut();
//                        Intent intent = new Intent(Home_Page.this, Welcome_screen.class);
//                        startActivity(intent);
//                        finish();
//                        Toast.makeText(Home_Page.this, "Logout Successful !", Toast.LENGTH_SHORT).show();
//                    })
//                    .setNegativeButton(android.R.string.no, null)
//                    .setIcon(android.R.drawable.ic_dialog_alert)
//                    .show();
//        });



        // Set click listeners
        assetManagementCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Home_Page.this, A_asset_management.class));
            }
        });

        spareManagementCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Home_Page.this, B_Spares_Managament.class));
            }
        });

        maintenanceCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Home_Page.this, C_Maintnance.class));
            }
        });

        analyticsCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Home_Page.this, A_asset_management.class));
            }
        });

        customerSupportCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Home_Page.this, Customer_support.class));
            }
        });

        settingsCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Home_Page.this, Settings.class));
            }
        });


    }
}


