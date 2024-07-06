<script>
    import { onMount } from 'svelte';
    import { writable } from 'svelte/store';

    let username = '';
    let password = '';
    let message = writable('');

    const register = async () => {
        const response = await fetch('http://localhost:5000/api/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username, password })
        });
        const data = await response.json();
        message.set(data.message);
    };

    const login = async () => {
        const response = await fetch('http://localhost:5000/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username, password })
        });
        const data = await response.json();
        message.set(data.message);
    };
</script>

<style>
    form {
        display: flex;
        flex-direction: column;
        width: 300px;
        margin: auto;
    }
    input, button {
        margin: 5px 0;
    }
</style>

<form on:submit|preventDefault={login}>
    <input type="text" placeholder="Username" bind:value={username} required />
    <input type="password" placeholder="Password" bind:value={password} required />
    <button type="button" on:click={register}>Register</button>
    <button type="submit">Login</button>
</form>

<p>{$message}</p>
