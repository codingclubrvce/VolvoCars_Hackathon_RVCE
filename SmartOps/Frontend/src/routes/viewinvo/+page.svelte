<script>
    import logo from "../../lib/assets/images/whitetextlogo.svg";
    import {base} from "$app/paths";
    import {goto} from "$app/navigation";
    import { onMount } from 'svelte';
    /**
	 * @type {any[]}
	 */
    // let rows = [{"id":12, "sub_number":34, "asset_description":"jsdfs", "location2":"somewhere", "current_apc":29439}];
    let rows = [];
    onMount(async () => {
        const response = await fetch('http://localhost:5000/api/inventory');
        rows = await response.json();
    });
    function add(){
        alert("This feature to be added");
    }
    function back(){
        goto(base+"/home")
    }
</script>

<main>
    <img src={logo} alt="logo"/>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Asset ID</th>
                    <th>Sub Number</th>
                    <th>Description</th>
                    <th>Location</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                {#each rows as row}
                    <tr>
                        <td>{row.id}</td>
                        <td>{row.sub_number}</td>
                        <td>{row.asset_description}</td>
                        <td>{row.location_2}</td>
                        <td>{row.current_apc}</td>
                    </tr>
                {/each}
            </tbody>
        </table>
    </div>
    <div class="buttons">
        <div class = "backButton"><button on:click={back}>Back</button></div>
        <div class = "addButton"><button on:click={add}>Update</button></div>
    </div>
</main>

<style>
    .table-container {
        width: 80%;
        height: 400px; 
        margin: 0 auto;
        overflow-y: auto; 
        background: #d3d3d3;
        padding: 10px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #000;
    }

    th {
        background-color: #333;
        color: white;
    }

    tbody tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    img{
        margin-bottom: 100px;
        margin-left: 1200px;
        margin-top: 80px;
        height: auto;
        width: 100px;
    }
    main{
        flex-direction: row;
        background-image: url("../../lib/assets/images/frame.jpg");
        background-size: cover;
        background-position: center;
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        z-index: 1; /* Ensure content below navbar */
    }
</style>
