<script>
    import logo from "../../../../lib/assets/images/whitetextlogo.svg";
    import {base} from "$app/paths";
    import {goto} from "$app/navigation";
    import { onMount } from 'svelte';

    /**
	 * @type {any[]}
	 */
    let assets = [];
    /**
	 * @type {{ id: any; name: any; description: any; } | null}
	 */
    let selectedAsset = null;
    /**
	 * @type {any[]}
	 */
    let subAssets = [];

    async function fetchAssets() {
        const response = await fetch('http://localhost:5000/api/assets');
        assets = await response.json();
    }

    /**
	 * @param {any} assetId
	 */
    async function fetchAssetDetails(assetId) {
        const response = await fetch(`http://localhost:5000/api/assets/${assetId}`);
        const data = await response.json();
        selectedAsset = data.asset;
        subAssets = data.sub_assets;
    }

    onMount(() => {
        fetchAssets();
    });
</script>

<main>
    <h1>Inventory</h1>

    <h2>Assets</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            {#each assets as asset}
                <tr on:click={() => fetchAssetDetails(asset.asset_id)}>
                    <td>{asset.asset_id}</td>
                    <td>{asset.asset_name}</td>
                    <td>{asset.asset_description}</td>
                </tr>
            {/each}
        </tbody>
    </table>

    {#if selectedAsset}
        <div class="asset-details">
            <h2>Selected Asset</h2>
            <p><strong>ID:</strong> {selectedAsset.id}</p>
            <p><strong>Name:</strong> {selectedAsset.name}</p>
            <p><strong>Description:</strong> {selectedAsset.description}</p>
        </div>

        <h2>Sub-Assets</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                {#each subAssets as subAsset}
                    <tr>
                        <td>{subAsset.id}</td>
                        <td>{subAsset.name}</td>
                        <td>{subAsset.description}</td>
                    </tr>
                {/each}
            </tbody>
        </table>
    {/if}
</main>

<style>
    h1,h2{
        color: white;
        text-align: center;
    }
     table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
        background-color: white;
    }

    tr:hover {
        background-color: black;
    }

    .asset-details {
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid white;
    }

    th {
        background-color: #333;
        color: white;
    }

    tbody tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    main{
        flex-direction: row;
        background-image: url("../../../../lib/assets/images/frame.jpg");
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
