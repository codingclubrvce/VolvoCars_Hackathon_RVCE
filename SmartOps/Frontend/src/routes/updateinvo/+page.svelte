<script>
    import {base} from "$app/paths";
    import {goto} from "$app/navigation";
    let assetid = "";
    let units = "";
    let status = "";
    let comments = "";
    let currentapc="";
    let message = "";
    async function add(){
        const response = await fetch('http://localhost:5000/api/update_asset', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ assetid, units, status, comments, currentapc})
        });
        const data = await response.json();
        if (response.ok) {
                message = 'User registered successfully!';
                goto(base+"/home");
            } else {
                message = data.error || 'Registration failed';
            }
    }
    function back(){
        goto(base+"/home")
    }
</script>
<main>
    <div class="leftside">
        <p>Update Inventory</p>
        <div class = "inputholder"><input type="text" id="assetid" bind:value={assetid} placeholder="Asset ID"/></div>
        <div class = "inputholder"><input type="number" id="units" bind:value={units} placeholder="Units"/></div>
        <div class = "inputholder"><input type="number" id="currentapc" bind:value={currentapc} placeholder="APC"/></div>
        <div class = "inputholder">
            <select name="Status" id="Status" bind:value={status}>
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
            </select>
        </div>
        <div class = "description"><input type="" id="Comments" bind:value={comments} placeholder="Description"/></div>
        <div class="buttons">
            <div class = "backButton"><button on:click={back}>Back</button></div>
            <div class = "addButton"><button on:click={add}>Update</button></div>
        </div>
    </div>
</main>

<style>
    button{
        padding: 8px 12px;
  outline: none;
  border: 0;
  color: #fff;
  border-radius: 4px;
  background: #8c7569;
  font-family: "Nunito", sans-serif;
  transition: 0.3s;
  cursor: pointer;
    }
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
        background-image: url("../../lib/assets/images/addbg.jpg");
        background-size: cover;
        background-position: center;
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100vh;
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
    .inputholder{
        height: 50px;
        margin: 4px;
        padding: 2px;
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