package com.suchith.volvo_new;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;

public class Adapter_aa_nuts_bolts extends FirebaseRecyclerAdapter<Model_aa_nuts_bolts, Adapter_aa_nuts_bolts.NutsBoltsViewHolder> {

    public Adapter_aa_nuts_bolts(@NonNull FirebaseRecyclerOptions<Model_aa_nuts_bolts> options) {
        super(options);
    }

    @Override
    protected void onBindViewHolder(@NonNull NutsBoltsViewHolder holder, int position, @NonNull Model_aa_nuts_bolts model) {
        holder.assetNameText.setText(model.getAsset_name_aa1());
        holder.assetIdText.setText(model.getAsset_id_aa2());
        holder.plantLocationText.setText(model.getPlant_location_aa3());
        holder.rackLocationText.setText(model.getRack_location_aa4());
        holder.costText.setText(model.getCost_aa5());
        holder.availUnitsText.setText(model.getAvailable_units_aa6());

        if (model.getActive_aa7().equals("true")) {
            holder.activeText.setVisibility(View.VISIBLE);
            holder.inactiveText.setVisibility(View.GONE);
        } else {
            holder.activeText.setVisibility(View.GONE);
            holder.inactiveText.setVisibility(View.VISIBLE);
        }
    }

    @NonNull
    @Override
    public NutsBoltsViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_aa_nuts_bolts, parent, false);
        return new NutsBoltsViewHolder(view);
    }

    public void updateOptions(FirebaseRecyclerOptions<Model_aa_nuts_bolts> options) {
        updateOptions(options);
        notifyDataSetChanged();
    }

    class NutsBoltsViewHolder extends RecyclerView.ViewHolder {
        TextView assetNameText, assetIdText, plantLocationText, rackLocationText, costText, availUnitsText, activeText, inactiveText;

        public NutsBoltsViewHolder(@NonNull View itemView) {
            super(itemView);
            assetNameText = itemView.findViewById(R.id.asset_name_text_aa1);
            assetIdText = itemView.findViewById(R.id.asset_id_text_aa2);
            plantLocationText = itemView.findViewById(R.id.plant_location_text_aa3);
            rackLocationText = itemView.findViewById(R.id.rack_location_text_aa4);
            costText = itemView.findViewById(R.id.cost_text_aa5);
            availUnitsText = itemView.findViewById(R.id.avail_units_text_naa6);
            activeText = itemView.findViewById(R.id.active_text_aa7);
            inactiveText = itemView.findViewById(R.id.inactive_text_aa8);
        }
    }
}