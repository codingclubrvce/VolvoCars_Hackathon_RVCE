<script>
    import {base} from "$app/paths";
    import {goto} from "$app/navigation";
    let assetId = "";
    let assetName = "";
    let assetLocation = "";
    let maintainancePeriod = "";
    let description = "";
    let message="";
    async function add(){
        const response = await fetch('http://localhost:5000/api/add_asset', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ assetId, assetName, assetLocation, maintainancePeriod, description})
        });
        const data = await response.json();
        if (response.ok) {
                message = 'User registered successfully!';
                goto(base+"/home");
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
        <div class = "inputHolder"><input type="number" id="assetId" bind:value={assetId} placeholder="Asset ID"/></div>
        <div class = "inputHolder"><input type="text" id="assetName" bind:value={assetName} placeholder="Asset Name"/></div>
        <div class = "inputHolder"><input type="text" id="Locatioin" bind:value={assetLocation} placeholder="Branch Location"/></div>
        <div class = "inputHolder"><input type="number" id="mintainance" bind:value={maintainancePeriod} placeholder="Maintainance Period (in days)"/></div>
        <div class = "inputHolder"><input type="text" id="description" bind:value={description} placeholder="Description"/></div>
        <div class="buttons">
            <div class = "backButton"><button on:click={back}>Back</button></div>
            <div class = "addButton"><button on:click={add}>Add</button></div>
        </div>
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
    .leftside input{
        height: 40px;
        width: 80%;
        border-radius: 10px;
    }
    .inputHolder,.assetlocation{
        height: 50px;
        margin: 4px;
        padding: 2px;
    }
    .assetlocation input{
        width: 37%;
        height: 40px;
        border-radius: 10px;
    }
    .description{
        height: 50px;
        margin: 4px;
        margin-top: 10px;
        padding: 2px;
    }
    .description input{
        height: 60px;
    }
</style>