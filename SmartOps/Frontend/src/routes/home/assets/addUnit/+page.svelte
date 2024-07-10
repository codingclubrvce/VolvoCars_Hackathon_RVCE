<script>
    import {base} from "$app/paths";
    import {goto} from "$app/navigation";
    let assetId = "";
    let subassetId = "";
    let SubAssetName = "";
    let status2 = "";
    let location = "";
    /**
	 * @type {any}
	 */
    let cost = null;
    let vendor = "";
    let message = "";
    async function add(){
        const response = await fetch('http://localhost:5000/api/add_subasset', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ assetId, subassetId, SubAssetName, status2,location,  cost, vendor})
        });
        const data = await response.json();
        if (response.ok) {
                message = 'User registered successfully!';
                goto(base+"/home");
                alert("hoorey!");
            } else {
                message = data.error || 'Registration failed';
                alert(message);
            }
    }

    function back(){
        goto(base+"/home")
    }
</script>
<main>
    <div class="leftside">
        <p>Add Inventory</p>
        <form on:submit={add}>
        <div class = "inputHolder"><input type="number" id="assetId" bind:value={assetId} placeholder="Asset ID" required/></div>
        <div class = "inputHolder"><input type="number" id="subassetId" bind:value={subassetId} placeholder="SubAsset ID" required/></div>
        <div class = "inputHolder"><input type="text" id="location" bind:value={location} placeholder="Location" required/></div>
        <div class = "inputHolder"><input type="text" id="subAssetName" bind:value={SubAssetName} placeholder="Sub-asset Name" required/></div>
        <div class = "inputHolder"><input type="number" id="cost" bind:value={cost} placeholder="Cost" required/></div>
        <div class = "inputHolder"><input type="text" id="vendor" bind:value={vendor} placeholder="Vendor" /></div>
        <select bind:value={status2} title="Status">
            <option value="" disabled selected>Select Status</option>
            <option value="deployed">Deployed</option>
            <option value="reserved">Reserved</option>
        </select>
        <div class="buttons">
            <div class = "backButton"><button on:click={back}>Back</button></div>
            <div class = "addButton"><button type="submit">Add</button></div>
        </div>
        </form>
    </div>
</main>

<style>
    .buttons{
        display: flex;
    }
    .addButton{
        margin-left: 260px;
    }
    .backButton{
        margin-left: 10px;
    }
    main{
        flex-direction: row;
        background-image: url("../../../../lib/assets/images/addbg.jpg");
        background-size: cover;
        background-position: center;
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        z-index: 1; /* Ensure content below navbar */
    }
    .leftside p{
        margin-bottom: 10px;
    }
    .leftside{
        margin-left: 2em;
        width: 30%;
        height: 80%;
        /* background-color: white; */
        color: white;
        font-size: 75px;
    }
    .leftside input,select{
        height: 40px;
        width: 80%;
        border-radius: 10px;
    }
    .inputHolder{
        height: 50px;
        margin: 4px;
        padding: 2px;
    }
    select{
        margin-left: 7px;
    }

</style>