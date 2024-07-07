<script>
    import {base} from "$app/paths";
    import {goto} from "$app/navigation";
    let assetid = "";
    let assetname = "";
    let assetlocation1 = "";
    let assetlocation2 = "";
    let value = "";
    let assetstatus = "";
    let description = "";
    function add(){
        
    }
    function back(){
        goto(base+"/home")
    }
</script>
<main>
    <div class="leftside">
        <p>Update Inventory</p>
        <div class = "inputholder"><input type="text" id="assetid" bind:value={assetid} placeholder="Asset ID"/></div>
        <div class = "inputholder"><input type="text" id="assetname" bind:value={assetname} placeholder="Sub number"/></div>
        <div class = "assetlocation">
            <input type="text" id="assetlocation1" bind:value={assetlocation1} placeholder="Asset Location 1"/>
            <input type="text" id="assetlocation2" bind:value={assetlocation2} placeholder="Asset Location 2"/>
        </div>
        <div class = "inputholder"><input type="text" id="value" bind:value={value} placeholder="Asset Value"/></div>
        <div class = "inputholder"><input type="text" id="assetstatus" bind:value={assetstatus} placeholder="Asset status"/></div>
        <div class = "description"><input type="text" id="description" bind:value={description} placeholder="Description"/></div>
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
        background-image: url("../../lib/assets/images/addbg.jpg");
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
    .inputholder,.assetlocation{
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