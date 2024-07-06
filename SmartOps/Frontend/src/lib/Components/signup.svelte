<script>
    let isOpened = false;
    let username = "";
    let password = "";
    let repeatpassword = "";
    let email = "";
    let showsignup = true;
</script>
{#if showsignup}
    <div class = "backdrop">
        <div class="modal-container {isOpened ? "blured" : ""}">
            <div class="input-block">
                <label for="username" class="input-label">UserName</label>
                <input type="username" name="username" id="username" placeholder="UserName" bind:value={username}>
            </div>
            <div class="input-block">
                <label for="email" class="input-label">Email</label>
                <input type="email" name="email" id="email" placeholder="Email" bind:value={email}>
            </div>
            <div class="input-block">
                <label for="password" class="input-label">Password</label>
                <input type="password" name="password" id="password" placeholder="Password" bind:value={password}>
            </div>
            <div class="input-block">
                <label for="password" class="input-label">Confirm-Password</label>
                <input type="password" name="password" id="password" placeholder="Retype Password" bind:value={repeatpassword}>
            </div>
            <div class="modal-buttons">
                <button class="input-button">SignUp</button>
            </div>
        </div>
    </div>
{/if}

<style>
    .backdrop{
        width: 100%;
        height: 100%;
        position: fixed;
        background: rgb(0,0,0,0.8);
    }
    @import url("https://fonts.googleapis.com/css?family=Nunito:400,600,700");
* {
  box-sizing: border-box;
}


.modal-container {
  display: flex;
  max-width: 550px;
  max-height: 550px;
  width: 100%;
  border-radius: 10px;
  overflow: hidden;
  position: absolute;
  opacity: 0;
  pointer-events: none;
  transition-duration: 0.3s;
  background: #fff;
  transform: translateY(100px) scale(0.4);
}

.modal-container {
  opacity: 1;
  transition-duration: 0.6s;
  pointer-events: auto;
  transform: translateY(0) scale(1);
}
.modal-buttons {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.input-button {
  padding: 8px 12px;
  outline: none;
  border: 0;
  color: #fff;
  border-radius: 4px;
  background: #8c7569;
  font-family: "Nunito", sans-serif;
  transition: 0.3s;
  cursor: pointer;
}
.input-button:hover {
  background: #55311c;
}

.input-label {
  font-size: 11px;
  text-transform: uppercase;
  font-family: "Nunito", sans-serif;
  font-weight: 600;
  letter-spacing: 0.7px;
  color: #8c7569;
  transition: 0.3s;
}

.input-block {
  display: flex;
  flex-direction: column;
  padding: 10px 10px 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
  margin-bottom: 20px;
  transition: 0.3s;
}
.input-block input {
  outline: 0;
  border: 0;
  padding: 4px 0 0;
  font-size: 14px;
  font-family: "Nunito", sans-serif;
}
.input-block input::-moz-placeholder {
  color: #ccc;
  opacity: 1;
}
.input-block input:-ms-input-placeholder {
  color: #ccc;
  opacity: 1;
}
.input-block input::placeholder {
  color: #ccc;
  opacity: 1;
}
.input-block:focus-within {
  border-color: #8c7569;
}
.input-block:focus-within .input-label {
  color: rgba(140, 117, 105, 0.8);
}


@media (max-width: 750px) {
  .modal-container {
    width: 90%;
  }
}
</style>