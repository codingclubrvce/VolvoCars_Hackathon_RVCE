<script>
    let name = '';
    let email = '';
    let phone = '';
    let message = '';

    function handleSubmit() {
        alert("This feature needs to be added");
        console.log({ name, email, phone, message });
    }
</script>

<style>
    main{
        margin: 0;
        padding: 0;
        height: 100%;
        height: calc(100vh);
        background-size: cover;
        background-color: #050D19;
    }
    .contact-container {
        padding-top: 50px;
        background-image: radial-gradient(#12151A,#02060B);
        color: white;
        padding: 20px;
        border-radius: 10px;
        width: 500px;
        margin: 0 auto;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        font-family: Arial, sans-serif;
    }

    .contact-container h1 {
        margin-bottom: 20px;
        text-align: center;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    .form-group input,
    .form-group textarea {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .form-group input {
        height: 40px;
    }

    .form-group textarea {
        height: 100px;
        resize: none;
    }

    .contact-container button {
        background: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        margin-top: 10px;
    }

    .contact-container button:hover {
        background: #0056b3;
    }

    .contact-info {
        margin-top: 20px;
        text-align: center;
    }

    .contact-info h2 {
        margin-bottom: 10px;
        font-size: 1.2em;
    }

    .contact-info p {
        font-size: 1em;
    }

    .form-row {
        display: flex;
        justify-content: space-between;
    }

    .form-row .form-group {
        flex: 1;
    }

    .form-row .form-group:first-child {
        margin-right: 10px;
    }
</style>
<main>
<div class="contact-container">
    <h1>Contact Us</h1>
    <form on:submit|preventDefault={handleSubmit}>
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" bind:value={name} />
        </div>
        
        <div class="form-row">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" bind:value={email} />
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="tel" id="phone" bind:value={phone} />
            </div>
        </div>
        
        <div class="form-group">
            <label for="message">Message:</label>
            <textarea id="message" bind:value={message}></textarea>
        </div>

        <button type="submit">Submit</button>
    </form>

    <div class="contact-info">
        <h2>For questions and technical assistance,<br> Contact: **********</h2>
        <p></p>
    </div>
</div>
</main>
