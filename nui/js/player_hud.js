document.addEventListener('DOMContentLoaded', () => {
    const healthBar = document.getElementById('health-bar');
    const hungerBar = document.getElementById('hunger-bar');
    const thirstBar = document.getElementById('thirst-bar');
    const armorBar = document.getElementById('armor-bar');

    window.addEventListener('message', (event) => {
        if (event.data.type === 'updatePlayerStats') {
            
            if (event.data.health !== undefined) {
                updateHealth(event.data.health);
            }
            if (event.data.armor !== undefined) {
                updateArmor(event.data.armor);
            }
            if (event.data.hunger !== undefined) {
                updateHunger(event.data.hunger);
            }
            if (event.data.thirst !== undefined) {
                updateThirst(event.data.thirst);
            }
        }
    });

    function updateHealth(newHealth) {
        healthBar.style.width = newHealth + '%';
        healthBar.style.backgroundColor = newHealth > 50 ? '#00ff00' : '#ff0000';
    }

    function updateArmor(newArmor) {
     
        armorBar.style.width = newArmor + '%';
        armorBar.style.backgroundColor = newArmor > 50 ? '#00ff00' : '#ff0000';
    }

    function updateHunger(newHunger) {

        hungerBar.style.width = newHunger + '%';
        hungerBar.style.backgroundColor = newHunger > 50 ? '#00ff00' : '#ff0000';
    }

    function updateThirst(newThirst) {
       
        thirstBar.style.width = newThirst + '%';
        thirstBar.style.backgroundColor = newThirst > 50 ? '#00ff00' : '#ff0000';
    }
});
