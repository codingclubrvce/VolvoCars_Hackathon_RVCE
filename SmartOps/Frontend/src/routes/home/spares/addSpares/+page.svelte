<script>
    import{base} from "$app/paths";
    import {goto} from "$app/navigation";
    import { onMount } from 'svelte';
    alert("This feature yet to be added.");
    function gohome(){
        goto(base+"/home");
    }
    
    onMount(() => {
        gohome();
    });
</script>