<script>
    import logo from "../../lib/assets/images/whitetextlogo.svg"
    let rows = [
        { id: 1, name: "Asset 1", description: "Description 1", location: "Location 1", value: "$1000" },
        { id: 2, name: "Asset 2", description: "Description 2", location: "Location 2", value: "$2000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        { id: 3, name: "Asset 3", description: "Description 3", location: "Location 3", value: "$3000" },
        // Add more rows as needed for testing
    ];
</script>

<main>
    <img src={logo} alt="logo"/>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Asset ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Location</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                {#each rows as row}
                    <tr>
                        <td>{row.id}</td>
                        <td>{row.name}</td>
                        <td>{row.description}</td>
                        <td>{row.location}</td>
                        <td>{row.value}</td>
                    </tr>
                {/each}
            </tbody>
        </table>
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
