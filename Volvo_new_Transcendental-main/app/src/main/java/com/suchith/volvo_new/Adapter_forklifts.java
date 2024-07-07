package com.suchith.volvo_new;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;

public class Adapter_forklifts extends FirebaseRecyclerAdapter<Model_Forklifts, Adapter_forklifts.NutsBoltsViewHolder> {

    public Adapter_forklifts(@NonNull FirebaseRecyclerOptions<Model_Forklifts> options) {
        super(options);
    }

    @Override
    protected void onBindViewHolder(@NonNull Adapter_forklifts.NutsBoltsViewHolder holder, int position, @NonNull Model_Forklifts model) {
        holder.assetNameText.setText(model.getAsset_name_ca1());
        holder.assetIdText.setText(model.getAsset_id_ca2());
        holder.plantLocationText.setText(model.getPlant_location_ca3());
        holder.rackLocationText.setText(model.getRack_location_ca4());
        holder.costText.setText(model.getCost_ca5());
        holder.availUnitsText.setText(model.getAvailable_units_ca6());

        if (model.getActive_ca7().equals("true")) {
            holder.activeText.setVisibility(View.VISIBLE);
            holder.inactiveText.setVisibility(View.GONE);
        } else {
            holder.activeText.setVisibility(View.GONE);
            holder.inactiveText.setVisibility(View.VISIBLE);
        }
    }

    @NonNull
    @Override
    public Adapter_forklifts.NutsBoltsViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_forklifts, parent, false);
        return new Adapter_forklifts.NutsBoltsViewHolder(view);
    }

    public void updateOptions(FirebaseRecyclerOptions<Model_Forklifts> options) {
        updateOptions(options);
        notifyDataSetChanged();
    }

    class NutsBoltsViewHolder extends RecyclerView.ViewHolder {
        TextView assetNameText, assetIdText, plantLocationText, rackLocationText, costText, availUnitsText, activeText, inactiveText;

        public NutsBoltsViewHolder(@NonNull View itemView) {
            super(itemView);
            assetNameText = itemView.findViewById(R.id.asset_name_main_aa1);
            assetIdText = itemView.findViewById(R.id.asset_id_main_aa2);
            plantLocationText = itemView.findViewById(R.id.plant_location_main_aa3);
            rackLocationText = itemView.findViewById(R.id.start_date_main_aa4);
            costText = itemView.findViewById(R.id.end_date_main_aa5);
            availUnitsText = itemView.findViewById(R.id.duration_main_aa6);
            activeText = itemView.findViewById(R.id.ready_main_aa7);
            inactiveText = itemView.findViewById(R.id.under_main_aa8);
        }
    }
}