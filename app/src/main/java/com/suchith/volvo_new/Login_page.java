package com.suchith.volvo_new;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.google.firebase.auth.FirebaseAuth;

public class Login_page extends AppCompatActivity {
    TextView txtSignUp, txtForgotPass;
    EditText edtEmail, edtPassword;
    ProgressBar progressBar;
    Button btnSignIn;
    String txtEmail, txtPassword;
    final String emailPattern = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";

    private FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_page);



        txtForgotPass = findViewById(R.id.txtForgetPassword);
        txtSignUp = findViewById(R.id.txtSignUp);
        edtEmail = findViewById(R.id.edtSignInEmail);
        edtPassword = findViewById(R.id.edtSignInPassword);
        progressBar = findViewById(R.id.signInProgressBar);
        btnSignIn = findViewById(R.id.loin_page_btn_login_In);

        // Initialize Firebase Auth
        mAuth = FirebaseAuth.getInstance();

        txtSignUp.setOnClickListener(view -> {
            Intent intent = new Intent(Login_page.this, Signup_page.class);
            startActivity(intent);
            finish();
        });

        txtForgotPass.setOnClickListener(view -> {
            Intent intent = new Intent(Login_page.this, Forgot_password.class);
            startActivity(intent);
            finish();
        });

        btnSignIn.setOnClickListener(view -> {
            txtEmail = edtEmail.getText().toString().trim();
            txtPassword = edtPassword.getText().toString().trim();

            if (!TextUtils.isEmpty(txtEmail)) {
                if (txtEmail.matches(emailPattern)) {
                    if (!TextUtils.isEmpty(txtPassword)) {
                        SignInUser();
                    } else {
                        edtPassword.setError("Password Field can't be empty");
                    }
                } else {
                    edtEmail.setError("Enter a valid Email Address");
                }
            } else {
                edtEmail.setError("Email Field can't be empty");
            }
        });
    }

    private void SignInUser() {

        progressBar.setVisibility(View.VISIBLE);
        btnSignIn.setVisibility(View.INVISIBLE);

        mAuth.signInWithEmailAndPassword(txtEmail, txtPassword).addOnSuccessListener(authResult -> {
            Toast.makeText(Login_page.this, "Login Successful !", Toast.LENGTH_SHORT).show();
            Intent intent = new Intent(Login_page.this, Home_Page.class);
            startActivity(intent);
            recreate();
            finish();
        }).addOnFailureListener(e -> {
            Toast.makeText(Login_page.this, "Error -", Toast.LENGTH_SHORT).show();
            progressBar.setVisibility(View.INVISIBLE);
            btnSignIn.setVisibility(View.VISIBLE);
        });

    }


}