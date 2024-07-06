<script>
  import { base } from '$app/paths';
  import Login from '../lib/Components/login.svelte';
  import Signup from '$lib/Components/signup.svelte';
  import { onMount } from 'svelte';
  import factory from "../lib/assets/images/login-factory.avif"
  import car from "../lib/assets/images/login-car.jpg"
  
  let signup = false;
  let email = "";
  let password = "";
  /**
	 * @type {HTMLDivElement}
	 */
  let modal;
  /**
	 * @type {HTMLElement}
	 */
  let body;
  /**
	 * @type {boolean}
	 */
  let isOpened = false;
  let currentScroll;
  let lastScroll = 3;
  let container;
  let message = "";

  const login = async () => {
        const response = await fetch('http://localhost:5000/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email, password })
        });
        const data = await response.json();
        if (response.ok) {
                message = 'User registered successfully!';
                alert("hoorey!");
            } else {
                alert('boo');
                message = data.error || 'Registration failed';
            }
    };

  onMount(() => {
    function handleScroll() {
      currentScroll = window.scrollY;
      if (currentScroll>lastScroll && window.scrollY > window.innerHeight / 3 && !isOpened) {
        isOpened = true;
        openModal();
      }
      lastScroll = currentScroll;
    }

    window.addEventListener('scroll', handleScroll);

    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  });

  const openModal = () => {
    if(modal){
      isOpened = true;
      document.body.style.overflow = "hidden";
    }
  };
  const closeModal = () => {
    modal.classList.remove("is-open");
    document.body.style.overflow = "initial";
    isOpened = false;
  };

</script>

<main>
  <div class="{lastScroll === 0 ? "scroll-down" : "no-scroll"}">SCROLL DOWN
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
      <path d="M16 3C8.832031 3 3 8.832031 3 16s5.832031 13 13 13 13-5.832031 13-13S23.167969 3 16 3zm0 2c6.085938 0 11 4.914063 11 11 0 6.085938-4.914062 11-11 11-6.085937 0-11-4.914062-11-11C5 9.914063 9.914063 5 16 5zm-1 4v10.28125l-4-4-1.40625 1.4375L16 23.125l6.40625-6.40625L21 15.28125l-4 4V9z" />
    </svg>
  </div>
  <div class="container">
  </div>
  <div class="modal {isOpened ? "is-open" : ""}" bind:this={modal}>
    <div class="modal-container {isOpened ? "blured" : ""}" bind:this={container}>
      <div class="modal-left">
        <h1 class="modal-title">Welcome!</h1>
        <p class="modal-desc">Fanny pack hexagon food truck, street art waistcoat kitsch.</p>
        <div class="input-block">
          <label for="email" class="input-label">Email</label>
          <input type="email" name="email" id="email" placeholder="Email">
        </div>
        <div class="input-block">
          <label for="password" class="input-label">Password</label>
          <input type="password" name="password" id="password" placeholder="Password">
        </div>
        <div class="modal-buttons">
          <a href="something" class="">Forgot your password?</a>
          <button class="input-button" on:click={login}>Login</button>
        </div>
        <p class="sign-up">Don't have an account? <button class="input-button"><a href="{base}/signup">Sign up now</a></button></p>
      </div>
      <div class="modal-right">
        <img src="{car}" alt="">
      </div>
      <button class="icon-button close-button" on:click={closeModal}>
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 50 50">
          <path d="M 25 3 C 12.86158 3 3 12.86158 3 25 C 3 37.13842 12.86158 47 25 47 C 37.13842 47 47 37.13842 47 25 C 47 12.86158 37.13842 3 25 3 z M 25 5 C 36.05754 5 45 13.94246 45 25 C 45 36.05754 36.05754 45 25 45 C 13.94246 45 5 36.05754 5 25 C 5 13.94246 13.94246 5 25 5 z M 16.990234 15.990234 A 1.0001 1.0001 0 0 0 16.292969 17.707031 L 23.585938 25 L 16.292969 32.292969 A 1.0001 1.0001 0 1 0 17.707031 33.707031 L 25 26.414062 L 32.292969 33.707031 A 1.0001 1.0001 0 1 0 33.707031 32.292969 L 26.414062 25 L 33.707031 17.707031 A 1.0001 1.0001 0 0 0 32.980469 15.990234 A 1.0001 1.0001 0 0 0 32.292969 16.292969 L 25 23.585938 L 17.707031 16.292969 A 1.0001 1.0001 0 0 0 16.990234 15.990234 z"></path>
        </svg>
      </button>
    </div>
    <button class="modal-button" on:click={openModal}>Click here to login</button>
  </div>
</main>

<style>
  @import url("https://fonts.googleapis.com/css?family=Nunito:400,600,700");
* {
  box-sizing: border-box;
}

.no-scroll{
  display: none;
}

.container {
  height: 200vh;
  filter: brightness(70%);
  z-index: -1;
  background-image: url("login-factory.jpg");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

.modal {
  position: fixed;
  left: 0;
  bottom: 0;
  width: 100%;
  height: 80px;
  background: rgba(51, 51, 51, 0.5);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  transition: 0.4s;
}
.modal-container {
  display: flex;
  max-width: 550px;
  height: 550px;
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
.modal-title {
  font-size: 26px;
  margin: 0;
  font-weight: 400;
  color: #55311c;
}
.modal-desc {
  margin: 6px 0 30px 0;
}
.modal-left {
  padding: 60px 30px 20px;
  background: #fff;
  flex: 1.5;
  transition-duration: 0.5s;
  transform: translateY(80px);
  opacity: 0;
}
.modal-button {
  color: #7d695e;
  font-family: "Nunito", sans-serif;
  font-size: 18px;
  cursor: pointer;
  border: 0;
  outline: 0;
  padding: 10px 40px;
  border-radius: 30px;
  background: white;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.16);
  transition: 0.3s;
}
.modal-button:hover {
  border-color: rgba(255, 255, 255, 0.2);
  background: rgba(255, 255, 255, 0.8);
}
.modal-right {
  flex: 2;
  font-size: 0;
  transition: 0.3s;
  overflow: hidden;
}
.modal-right img {
  width: 100%;
  height: 100%;
  transform: scale(2);
  -o-object-fit: cover;
     object-fit: cover;
  transition-duration: 1.2s;
}
.modal.is-open {
  height: 100%;
  background: rgba(51, 51, 51, 0.85);
}
.modal.is-open .modal-button {
  opacity: 0;
}
.modal.is-open .modal-container {
  opacity: 1;
  transition-duration: 0.6s;
  pointer-events: auto;
  transform: translateY(0) scale(1);
}
.modal.is-open .modal-right img {
  transform: scale(1);
}
.modal.is-open .modal-left {
  transform: translateY(0);
  opacity: 1;
  transition-delay: 0.1s;
}
.modal-buttons {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.modal-buttons a {
  color: rgba(51, 51, 51, 0.6);
  font-size: 14px;
}

.sign-up {
  margin: 60px 0 0;
  font-size: 14px;
  text-align: center;
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

.icon-button {
  outline: 0;
  position: absolute;
  right: 10px;
  top: 12px;
  width: 32px;
  height: 32px;
  border: 0;
  background: 0;
  padding: 0;
  cursor: pointer;
}

.scroll-down {
  position: fixed;
  top: 50%;
  left: 50%;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  color: #7d695e;
  font-size: 32px;
  font-weight: 800;
  transform: translate(-50%, -50%);
}
.scroll-down svg {
  margin-top: 16px;
  width: 52px;
  fill: currentColor;
}

@media (max-width: 750px) {
  .modal-container {
    width: 90%;
  }

  .modal-right {
    display: none;
  }
}
</style>
