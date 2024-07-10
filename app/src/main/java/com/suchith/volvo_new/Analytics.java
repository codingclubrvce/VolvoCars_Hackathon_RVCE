package com.suchith.volvo_new;

import android.graphics.Color;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.charts.PieChart;
import com.github.mikephil.charting.charts.BarChart;
import com.github.mikephil.charting.charts.RadarChart;
import com.github.mikephil.charting.components.Legend;
import com.github.mikephil.charting.components.XAxis;
import com.github.mikephil.charting.components.YAxis;
import com.github.mikephil.charting.data.BarData;
import com.github.mikephil.charting.data.BarDataSet;
import com.github.mikephil.charting.data.BarEntry;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.data.PieData;
import com.github.mikephil.charting.data.PieDataSet;
import com.github.mikephil.charting.data.PieEntry;
import com.github.mikephil.charting.data.RadarData;
import com.github.mikephil.charting.data.RadarDataSet;
import com.github.mikephil.charting.data.RadarEntry;
import com.github.mikephil.charting.formatter.IndexAxisValueFormatter;
import com.github.mikephil.charting.formatter.PercentFormatter;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import java.util.ArrayList;
import java.util.List;

public class Analytics extends AppCompatActivity {

    private PieChart pieChart;
    private BarChart barChart;
    private LineChart lineChart;
    private RadarChart radarChart;
    private DatabaseReference databaseReference;

    // Aesthetic blue color palette
    private final int[] AESTHETIC_BLUE_COLORS = {
            Color.rgb(51, 102, 204),   // Deep Blue
            Color.rgb(92, 172, 238),   // Sky Blue
            Color.rgb(70, 130, 180),   // Steel Blue
            Color.rgb(30, 144, 255),   // Dodger Blue
            Color.rgb(135, 206, 250)   // Light Sky Blue
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.analytics);

        pieChart = findViewById(R.id.pieChartProduction);
        barChart = findViewById(R.id.barChartEfficiency);
        lineChart = findViewById(R.id.lineChartTrends);
        radarChart = findViewById(R.id.radarChartQuality);

        databaseReference = FirebaseDatabase.getInstance().getReference("Analytics");

        setupCharts();
        fetchDataFromFirebase();
    }

    private void setupCharts() {
        // Pie Chart setup
        pieChart.getDescription().setEnabled(false);
        pieChart.setCenterText("Vehicle Types");

        // Bar Chart setup
        barChart.getDescription().setEnabled(false);
        barChart.setFitBars(true);
        XAxis xAxisBar = barChart.getXAxis();
        xAxisBar.setPosition(XAxis.XAxisPosition.BOTTOM);
        xAxisBar.setGranularity(1f);
        xAxisBar.setGranularityEnabled(true);

        // Line Chart setup
        lineChart.getDescription().setEnabled(false);
        XAxis xAxisLine = lineChart.getXAxis();
        xAxisLine.setGranularity(1f);
        xAxisLine.setGranularityEnabled(true);

        // Radar Chart setup
        radarChart.getDescription().setEnabled(false);
    }

    private void fetchDataFromFirebase() {
        databaseReference.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                updatePieChart(dataSnapshot.child("pieChart"));
                updateBarChart(dataSnapshot.child("barChart"));
                updateLineChart(dataSnapshot.child("lineChart"));
                updateRadarChart(dataSnapshot.child("radarChart"));
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle error
            }
        });
    }

    private void updatePieChart(DataSnapshot dataSnapshot) {
        ArrayList<PieEntry> entries = new ArrayList<>();
        for (DataSnapshot snapshot : dataSnapshot.getChildren()) {
            entries.add(new PieEntry(snapshot.child("value").getValue(Float.class),
                    snapshot.child("label").getValue(String.class)));
        }

        PieDataSet dataSet = new PieDataSet(entries, "");
        dataSet.setColors(AESTHETIC_BLUE_COLORS);
        dataSet.setValueTextColor(Color.BLACK);
        dataSet.setValueTextSize(14f);

        PieData data = new PieData(dataSet);
        data.setValueFormatter(new PercentFormatter(pieChart));
        data.setValueTextSize(14f);
        data.setValueTextColor(Color.WHITE);

        pieChart.setUsePercentValues(true);
        pieChart.setData(data);
        pieChart.invalidate();
        pieChart.animateY(1000);
        pieChart.setCenterText("Vehicle\nType");
        pieChart.setHoleColor(Color.TRANSPARENT);
        pieChart.setHoleRadius(50f);

        Legend l = pieChart.getLegend();
        l.setVerticalAlignment(Legend.LegendVerticalAlignment.BOTTOM);
        l.setHorizontalAlignment(Legend.LegendHorizontalAlignment.CENTER);
        l.setOrientation(Legend.LegendOrientation.HORIZONTAL);
        l.setTextColor(Color.BLACK);
        l.setDrawInside(false);
    }

    private void updateBarChart(DataSnapshot dataSnapshot) {
        ArrayList<BarEntry> entries = new ArrayList<>();
        ArrayList<String> labels = new ArrayList<>();
        int index = 0;
        for (DataSnapshot snapshot : dataSnapshot.getChildren()) {
            entries.add(new BarEntry(index, snapshot.child("value").getValue(Float.class)));
            labels.add(snapshot.child("label").getValue(String.class));
            index++;
        }

        BarDataSet dataSet = new BarDataSet(entries, "");
        dataSet.setColors(AESTHETIC_BLUE_COLORS);
        dataSet.setValueTextSize(10f);
        dataSet.setValueTextColor(Color.BLACK);

        BarData data = new BarData(dataSet);
        data.setBarWidth(0.9f);

        barChart.setData(data);

        XAxis xAxis = barChart.getXAxis();
        xAxis.setValueFormatter(new IndexAxisValueFormatter(labels));
        xAxis.setTextSize(10f);
        xAxis.setPosition(XAxis.XAxisPosition.BOTTOM);
        xAxis.setDrawGridLines(false);
        xAxis.setGranularity(1f);

        YAxis leftAxis = barChart.getAxisLeft();
        leftAxis.setTextSize(10f);
        leftAxis.setDrawGridLines(false);

        barChart.getAxisRight().setEnabled(false);  // Disable right axis

        barChart.getLegend().setEnabled(false);  // Disable legend
        barChart.getDescription().setEnabled(false);  // Disable description

        barChart.setFitBars(true);
        barChart.setDrawValueAboveBar(true);
        barChart.setDrawGridBackground(false);

        barChart.invalidate();
        barChart.animateY(1000);
    }
    private void updateLineChart(DataSnapshot dataSnapshot) {
        ArrayList<Entry> entries = new ArrayList<>();
        ArrayList<String> labels = new ArrayList<>();
        int index = 0;
        for (DataSnapshot snapshot : dataSnapshot.getChildren()) {
            entries.add(new Entry(index, snapshot.child("value").getValue(Float.class)));
            labels.add(snapshot.child("label").getValue(String.class));
            index++;
        }

        LineDataSet dataSet = new LineDataSet(entries, "");  // Empty string removes the dataset label
        dataSet.setColor(AESTHETIC_BLUE_COLORS[0]);
        dataSet.setValueTextColor(Color.BLACK);
        dataSet.setValueTextSize(10f);
        dataSet.setLineWidth(2f);
        dataSet.setCircleColor(AESTHETIC_BLUE_COLORS[1]);
        dataSet.setCircleRadius(5f);
        dataSet.setDrawCircleHole(false);

        LineData data = new LineData(dataSet);

        lineChart.setData(data);
        lineChart.getXAxis().setValueFormatter(new IndexAxisValueFormatter(labels));

        // Remove legend
        lineChart.getLegend().setEnabled(false);

        // Remove description (title)
        lineChart.getDescription().setEnabled(false);

        // Additional customizations for a cleaner look
        lineChart.getXAxis().setPosition(XAxis.XAxisPosition.BOTTOM);
        lineChart.getAxisRight().setEnabled(false);  // Disable right axis
        lineChart.setDrawGridBackground(false);

        lineChart.invalidate();
        lineChart.animateX(1000);
    }

    private void updateRadarChart(DataSnapshot dataSnapshot) {
        ArrayList<RadarEntry> entries = new ArrayList<>();
        List<String> labels = new ArrayList<>();
        for (DataSnapshot snapshot : dataSnapshot.getChildren()) {
            entries.add(new RadarEntry(snapshot.child("value").getValue(Float.class)));
            labels.add(snapshot.child("label").getValue(String.class));
        }

        RadarDataSet dataSet = new RadarDataSet(entries, "");  // Empty string removes the dataset label
        dataSet.setColor(AESTHETIC_BLUE_COLORS[2]);
        dataSet.setFillColor(AESTHETIC_BLUE_COLORS[3]);
        dataSet.setDrawFilled(true);
        dataSet.setFillAlpha(180);
        dataSet.setLineWidth(2f);
        dataSet.setValueTextColor(Color.BLACK);
        dataSet.setValueTextSize(10f);

        RadarData data = new RadarData(dataSet);

        radarChart.setData(data);
        radarChart.getXAxis().setValueFormatter(new IndexAxisValueFormatter(labels));

        // Remove legend (bottom squares)
        radarChart.getLegend().setEnabled(false);

        // Remove description (title)
        radarChart.getDescription().setEnabled(false);

        // Additional customizations for a cleaner look
        radarChart.setWebColor(Color.LTGRAY);
        radarChart.setWebLineWidth(1f);
        radarChart.setWebAlpha(100);

        // Customize X-axis (the circular labels)
        XAxis xAxis = radarChart.getXAxis();
        xAxis.setTextSize(10f);
        xAxis.setTextColor(Color.BLACK);

        // Customize Y-axis (the value axis)
        YAxis yAxis = radarChart.getYAxis();
        yAxis.setTextSize(10f);
        yAxis.setTextColor(Color.BLACK);
        yAxis.setDrawLabels(false);  // Optionally remove Y-axis labels for a cleaner look

        radarChart.invalidate();
        radarChart.animateXY(1000, 1000);
    }
}