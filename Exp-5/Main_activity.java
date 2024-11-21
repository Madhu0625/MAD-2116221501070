package com.example.exp5;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    private EditText usernameEditText;
    private EditText idEditText;
    private Button validateButton;

    // Define the correct usernames and passcodes
    private static final Map<String, String> USER_CREDENTIALS = new HashMap<>();

    static {
        USER_CREDENTIALS.put("Yoges", "1511");
        USER_CREDENTIALS.put("Appu", "7475");

        // Add more users as needed
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Initialize views
        usernameEditText = findViewById(R.id.username_edit_text);
        idEditText = findViewById(R.id.id_edit_text);
        validateButton = findViewById(R.id.validate_button);

        // Set up click listener for the validate button
        validateButton.setOnClickListener(v -> validateInputs());
    }

    // Method to validate username and passcode
    private void validateInputs() {
        String username = usernameEditText.getText().toString().trim();
        String passcode = idEditText.getText().toString().trim();

        // Check if any field is empty
        if (TextUtils.isEmpty(username) || TextUtils.isEmpty(passcode)) {
            showToast(getString(R.string.empty_fields_error));
            return;
        }

        // Validate username and passcode
        if (!USER_CREDENTIALS.containsKey(username)) {
            showToast(getString(R.string.invalid_username_error));
            return;
        }

        if (!USER_CREDENTIALS.get(username).equals(passcode)) {
            showToast(getString(R.string.invalid_id_error));
            return;
        }

        // If both validations pass
        showToast("Validation Successful!");
    }

    // Helper method to show toast messages
    private void showToast(String message) {
        // Inflate the custom layout
        LayoutInflater inflater = getLayoutInflater();
        View toastLayout = inflater.inflate(R.layout.custom_toast_layout, null);

        // Set the message and icon
        TextView toastText = toastLayout.findViewById(R.id.toast_text);
        toastText.setText(message);

        // Create and configure the toast
        Toast customToast = new Toast(getApplicationContext());
        customToast.setView(toastLayout);
        customToast.setDuration(Toast.LENGTH_SHORT);

        // Move the toast downwards
        customToast.setGravity(Gravity.CENTER_HORIZONTAL | Gravity.BOTTOM, 0, dpToPx(100)); // Adjust the y-offset as needed

        // Show the toast
        customToast.show();
    }

    // Convert dp to pixels for offset calculation
    private int dpToPx(int dp) {
        float density = getResources().getDisplayMetrics().density;
        return Math.round(dp * density);
    }
}
