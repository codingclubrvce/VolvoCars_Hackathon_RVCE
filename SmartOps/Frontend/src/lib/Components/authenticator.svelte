<!-- src/components/Authenticator.svelte -->
<script>
    import { isAuthenticated } from '../../stores/auth';
    import { onMount } from 'svelte';
    import { goto } from '$app/navigation';
    import {base} from '$app/paths';

    export let redirectTo = "/";

    let auth = false;
    isAuthenticated.subscribe(value => auth = value);

    onMount(() => {
        if (!auth) {
            goto("/"); // Redirect to the login page if not authenticated"
        }
    });
</script>

{#if auth}
    <slot /> <!-- Render the children components if authenticated -->
{/if}
