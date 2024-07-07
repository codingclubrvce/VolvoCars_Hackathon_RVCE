package com.suchith.volvo_new;


public class Model_Forklifts {

    String asset_name_ca1, asset_id_ca2, plant_location_ca3, rack_location_ca4 ,cost_ca5,available_units_ca6, active_ca7, inactive_ca8;

    Model_Forklifts()
    {

    }

    public Model_Forklifts(String asset_name_ca1, String asset_id_ca2, String plant_location_ca3, String rack_location_ca4, String cost_ca5, String available_units_ca6, String active_ca7, String inactive_ca8)
    {
        this.asset_name_ca1 = asset_name_ca1;
        this.asset_id_ca2 = asset_id_ca2;
        this.plant_location_ca3 = plant_location_ca3;
        this.rack_location_ca4 = rack_location_ca4;
        this.cost_ca5 = cost_ca5;
        this.available_units_ca6 = available_units_ca6;
        this.active_ca7 = active_ca7;
        this.inactive_ca8 = inactive_ca8;
    }

    public String getAsset_name_ca1() {
        return asset_name_ca1;
    }

    public void setAsset_name_ca1(String asset_name_ca1) {
        this.asset_name_ca1 = asset_name_ca1;
    }

    public String getAsset_id_ca2() {
        return asset_id_ca2;
    }

    public void setAsset_id_ca2(String asset_id_ca2) {
        this.asset_id_ca2 = asset_id_ca2;
    }

    public String getPlant_location_ca3() {
        return plant_location_ca3;
    }

    public void setPlant_location_ca3(String plant_location_ca3) {
        this.plant_location_ca3 = plant_location_ca3;
    }

    public String getRack_location_ca4() {
        return rack_location_ca4;
    }

    public void setRack_location_ca4(String rack_location_ca4) {
        this.rack_location_ca4 = rack_location_ca4;
    }

    public String getCost_ca5() {
        return cost_ca5;
    }

    public void setCost_ca5(String cost_ca5) {
        this.cost_ca5 = cost_ca5;
    }

    public String getAvailable_units_ca6() {
        return available_units_ca6;
    }

    public void setAvailable_units_ca6(String available_units_ca6) {
        this.available_units_ca6 = available_units_ca6;
    }

    public String getActive_ca7() {
        return active_ca7;
    }

    public void setActive_ca7(String active_ca7) {
        this.active_ca7 = active_ca7;
    }

    public String getInactive_ca8() {
        return inactive_ca8;
    }

    public void setInactive_ca8(String inactive_ca8) {
        this.inactive_ca8 = inactive_ca8;
    }



}