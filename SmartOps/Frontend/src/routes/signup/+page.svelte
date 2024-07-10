<script>
	import { text } from "@sveltejs/kit";

    /**
	 * @type {string | any[] }
	 */
    let items = [];
    let OTP="";
    let username = "";
    let password = "";
    let repeatpassword = "";
    let email = "";
    let message = "";

    const sendOTP = async () => {
        if (password === repeatpassword) {
            const response = await fetch('http://localhost:5000/api/sendOTP', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({email, username})
            });

            const data = await response.json();
            
            if (response.ok) {
                message = 'OTP Generated successfully!';
                alert(data.message);
            } else {
                message = data.error || 'OTP Generation Failed, Check email';
            }
        } else {
            message = "Passwords do not match";
            alert(message);
        }
    };

    const signUp = async () => {
        if (password === repeatpassword) {
            const response = await fetch('http://localhost:5000/api/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, email, password, OTP })
            });

            const data = await response.json();
            
            if (response.ok) {
                message = 'User registered successfully!';
            } else {
                message = data.error || 'Registration failed';
                alert("Wrong OTP");
            }
        } else {
            message = "Passwords do not match";
            alert(message);
        }
    };
</script>

<main>
    <div class="container">
        <div class="background"></div>
        <div class="box">
            <p>Please enter the credentials.</p>
            <form on:submit|preventDefault={signUp}>
                <input type="text" placeholder="Username" bind:value={username} required />
                <input type="email" placeholder="Email" bind:value={email} required />
                <input type="password" placeholder="Password" bind:value={password} required />
                <input type="password" placeholder="Repeat Password" bind:value={repeatpassword} required />
                <input type="text" placeholder="OTP" bind:value={OTP} required>
                <br>
                <button type="button" on:click={sendOTP}>Send OTP</button>
                <button type="submit">Submit</button>
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
