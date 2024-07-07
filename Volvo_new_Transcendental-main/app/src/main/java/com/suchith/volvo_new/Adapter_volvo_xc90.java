package com.suchith.volvo_new;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;

public class Adapter_volvo_xc90 extends FirebaseRecyclerAdapter<Model_volvo_xc90, Adapter_volvo_xc90.NutsBoltsViewHolder> {

    public Adapter_volvo_xc90(@NonNull FirebaseRecyclerOptions<Model_volvo_xc90> options) {
        super(options);
    }

    @Override
    protected void onBindViewHolder(@NonNull Adapter_volvo_xc90.NutsBoltsViewHolder holder, int position, @NonNull Model_volvo_xc90 model) {
        holder.assetNameText.setText(model.getAsset_name_ba1());
        holder.assetIdText.setText(model.getAsset_id_ba2());
        holder.plantLocationText.setText(model.getPlant_location_ba3());
        holder.rackLocationText.setText(model.getRack_location_ba4());
        holder.costText.setText(model.getCost_ba5());
        holder.availUnitsText.setText(model.getAvailable_units_ba6());

        if (model.getActive_ba7().equals("true")) {
            holder.activeText.setVisibility(View.VISIBLE);
            holder.inactiveText.setVisibility(View.GONE);
        } else {
            holder.activeText.setVisibility(View.GONE);
            holder.inactiveText.setVisibility(View.VISIBLE);
        }
    }

    @NonNull
    @Override
    public Adapter_volvo_xc90.NutsBoltsViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_xc90, parent, false);
        return new Adapter_volvo_xc90.NutsBoltsViewHolder(view);
    }

    public void updateOptions(FirebaseRecyclerOptions<Model_volvo_xc90> options) {
        updateOptions(options);
        notifyDataSetChanged();
    }

    class NutsBoltsViewHolder extends RecyclerView.ViewHolder {
        TextView assetNameText, assetIdText, plantLocationText, rackLocationText, costText, availUnitsText, activeText, inactiveText;

        public NutsBoltsViewHolder(@NonNull View itemView) {
            super(itemView);
            assetNameText = itemView.findViewById(R.id.asset_name_xc90_aa1);
            assetIdText = itemView.findViewById(R.id.asset_id_xc90_aa2);
            plantLocationText = itemView.findViewById(R.id.plant_location_xc90_aa3);
            rackLocationText = itemView.findViewById(R.id.rack_location_xc90_aa4);
            costText = itemView.findViewById(R.id.cost_xc90_aa5);
            availUnitsText = itemView.findViewById(R.id.avail_units_xc90_naa6);
            activeText = itemView.findViewById(R.id.active_xc90_aa7);
            inactiveText = itemView.findViewById(R.id.inactive_xc90_aa8);
        }
    }
}