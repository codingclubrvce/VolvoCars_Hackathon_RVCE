<script>
    /**
	 * @type {string | any[] }
	 */
    let items = [];
    let username = "";
    let password = "";
    let repeatpassword = "";
    let email = "";
    let message = "";

    const signup = async () => {
        if (password === repeatpassword) {
            const response = await fetch('http://localhost:5000/api/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, email, password })
            });

            const data = await response.json();
            
            if (response.ok) {
                message = 'User registered successfully!';
                alert("hoorey!");
            } else {
                message = data.error || 'Registration failed';
            }
        } else {
            message = "Passwords do not match";
        }
    };
</script>

<main>
    <div class="container">
        <div class="background"></div>
        <div class="box">
            <p>Please enter the credentials.</p>
            <form on:submit|preventDefault={signup}>
                <input type="text" placeholder="Username" bind:value={username} required />
                <input type="email" placeholder="Email" bind:value={email} required />
                <input type="password" placeholder="Password" bind:value={password} required />
                <input type="password" placeholder="Repeat Password" bind:value={repeatpassword} required />
                <button type="submit">SignUp</button>
            </form>
        </div>
    </div>
</main>

<style>
    :global(html, body) {
        height: 100%;
        margin: 0;
    }

    main {
        height: 100%;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .container {
        position: relative;
        width: 100%;
        height: 100%;
    }

    .background {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: url("login-factory.jpg");
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        filter: blur(4px) brightness(70%);
        z-index: -1;
    }

    .box {
        padding: 20px;
        border-radius: 10px;
        max-width: 400px;
        width: 100%;
        margin: 10% auto;
        text-align: center;
        background-color: rgba(255, 255, 255, 0.8);
        z-index: 1;
        position: relative;
    }
</style>
