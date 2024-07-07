<script>
    import {base} from '$app/paths';
    import logo from "../../lib/assets/images/logo.jpg";
    import bg from "../../lib/assets/images/homebg.png"
    let navigationLinks = [
        { id: 'home', text: 'ASSET INVENTORY', dropdownItems: [
            { id: 'addinvo', text: 'Add to Inventory' },
            { id: 'viewinvo', text: 'View Inventory' },
            { id: 'updateinvo', text: 'Update Inventory' },
            { id: 'assetVendorInfo', text: 'Vendor Info' }
        ] },
        { id: 'SPARE', text: 'SPARE PARTS', dropdownItems: [
            { id: 'home', text: 'Update Spares' },
            { id: 'home', text: 'Issue & Transfer' },
            { id: 'home', text: 'View Inventory' },
            { id: 'home', text: 'Vendor Info' }
        ] },
        { id: 'home', text: 'MAINTAINANCE', dropdownItems: [
            { id: 'home', text: 'Maintenance Type' },
            { id: 'home', text: 'Maintenance Plan' },
            { id: 'home', text: 'Maintenance Schedule' },
            { id: 'home', text: 'Maintenance Instructions' }
        ] },
        { id: 'home', text: 'REPORTS', dropdownItems: [
            { id: 'home', text: 'Asset Master' },
            { id: 'home', text: 'Spares Master' },
            { id: 'home', text: 'Asset Status' },
            { id: 'home', text: 'Asset Issues' },
            { id: 'home', text: 'Spares Complaints' }
        ] },
        {
            id: 'contact', text: "CONTACT"
        }
    ];
</script>
<main>
<header class="navbar">
    <img class="logo bottomcontent" src={logo} alt="Logo">
    <nav class="menu bottomcontent" >
        {#each navigationLinks as link}
            {#if link.dropdownItems}
                <div class="dropdown">
                    <a href={'#' + link.id}>{link.text}</a>
                    <div class="dropdown-content">
                        {#each link.dropdownItems as item}
                            <a href={`${base}/${item.id}`}>{item.text}</a>
                        {/each}
                    </div>
                </div>
            {:else}
            <a href={`${base}/${link.id}`}>{link.text}</a>
            {/if}
        {/each}
    </nav>
</header>
<div class="background-image">
</div>
</main>

<style>
    .bottomcontent{
        align-self: flex-end;
    }
    .background-image {
        background-image: url('../../lib/assets/images/homebg.jpg'); /* Replace with your image path */
        background-size: cover;
        background-position: center;
        position: absolute;
        top: 10em; /* Adjust based on navbar height */
        left: 0;
        width: 100%;
        height: calc(100vh - 10em); /* Calculate height to fill screen */
        z-index: 1; /* Ensure content below navbar */
    }
    main{
        height: 100%;
        width: 100%;
    }
    .navbar {   
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: white;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 10em;
        padding: 0 2rem; /* Adjust padding as needed */
        z-index: 999;
    }

    .navbar .menu {
        margin-bottom: 28px;
        margin-right: 250px;
        display: flex;
        align-items: center;
    }

    .navbar .menu a, .dropdown-content a {
        color: black;
        text-decoration: none;
        font-size: 20px;
        padding: 0.5rem 1rem; /* Adjust padding as needed */
        position: relative;
    }

    .navbar .menu a::after {
        content: "";
        position: absolute;
        left: 50%;
        bottom: 0;
        width: 0;
        height: 2px;
        background-image: linear-gradient(to right, #F79533 0%, #F37055 15%, #EF4E7B 30%, #A166AB 44%, #5073B8 58%, #1098AD 72%, #07B39B 86%, #6DBA82 100%);
        transition: width 0.3s ease-in-out, left 0.3s ease-in-out;
        transform: translateX(13%);
    }

    .navbar .menu a:hover::after {
        width: calc(100% - 2rem); /* Adjust width as needed */
        left: 0;
    }

    .dropdown {
        position: relative;
        z-index: 1000;
    }

    .dropdown-content {
        /* display: none;
        position: absolute;
        background-color: #f1f1f1;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        z-index: 1001;
        top: 100%; /* Position below the main link 
        left: 0; Align with the main link */
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #fff;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        z-index: 1001;
        transition: opacity 0.7s ease, transform 0.7s ease;
        opacity: 0;
        transform: translateY(-10px);
    }


    .dropdown:hover .dropdown-content {
        display: block;
        opacity: 1;
        transform: translateY(0);
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown-content a:hover {
        background-color: #ddd;
    }

    .logo {
        margin-left: 50px;
        width: 200px; /* Adjust logo size as needed */
        height: auto;
    }
</style>

