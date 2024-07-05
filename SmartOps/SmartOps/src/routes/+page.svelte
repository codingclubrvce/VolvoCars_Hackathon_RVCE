<script>
    import { onMount } from 'svelte';
  
    /**
	 * @type {string | any[] }
	 */
    let items = [];

    let itemName = '';
    let itemId = '';

    async function addItem() {
    try {
        const response = await fetch('http://localhost:5000/api/items', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id: itemId, name: itemName })
        });
        if (!response.ok) {
        throw new Error('Failed to add item');
        }
        alert('Item added successfully!');
        } catch (error) {
            console.error('Error adding item:', error);
            alert('Failed to add item. Check console for details.');
        }
    }
  
    onMount(async () => {
      try {
        const response = await fetch('http://localhost:5000/api/items');
        if (!response.ok) {
          throw new Error('Failed to fetch items');
        }
        const data = await response.json();
        items = data.items; // Assign fetched items directly
      } catch (error) {
        console.error('Error fetching items:', error);
        // Handle error: e.g., display an error message to the user
      }
    });
  </script>
<div>
  {#if items.length === 0}
    <p>Loading...</p>
  {:else}
    <ul>
      {#each items as item (item)}
        <li>{item.name}</li>
      {/each}
    </ul>
  {/if}
  <label>
    Item ID:
    <input type="text" bind:value={itemId} />
  </label>
  
  <label>
    Item Name:
    <input type="text" bind:value={itemName} />
  </label>
  
  <button on:click={addItem}>Add Item</button>
</div>
